package DateTime::TimeZone;

use strict;

use vars qw( $VERSION $INFINITY $NEG_INFINITY );
$VERSION = '0.09';

use DateTime::TimeZoneCatalog;
use DateTime::TimeZone::Floating;
use DateTime::TimeZone::OffsetOnly;
use DateTime::TimeZone::UTC;
use Params::Validate qw( validate validate_pos SCALAR ARRAYREF );
use Time::Local;

use constant INFINITY     =>       100 ** 100 ** 100 ;
use constant NEG_INFINITY => -1 * (100 ** 100 ** 100);

sub new
{
    my $class = shift;
    my %p = validate( @_,
                      { name => { type => SCALAR } },
                    );

    if ( exists $DateTime::TimeZone::Links{ $p{name} } )
    {
        $p{name} = $DateTime::TimeZone::Links{ $p{name} };
    }

    unless ( $p{name} =~ m,/, )
    {
        if ( $p{name} eq 'floating' )
        {
            return DateTime::TimeZone::Floating->new;
        }

        if ( $p{name} eq 'local' )
        {
            if ( defined $ENV{TZ} && $ENV{TZ} ne 'local' )
            {
                my $tz;
                eval { $tz = $class->new( name => $ENV{TZ} ) };
                return $tz if $tz && ! $@;
            }

            my @t = gmtime;

            my $local = Time::Local::timelocal(@t);
            my $gm    = Time::Local::timegm(@t);

            return
                DateTime::TimeZone::OffsetOnly->new
                    ( offset => offset_as_string( $gm - $local ) );
        }

        if ( $p{name} eq 'UTC' || $p{name} eq 'Z' )
        {
            return DateTime::TimeZone::UTC->new;
        }

        return DateTime::TimeZone::OffsetOnly->new( offset => $p{name} );
    }

    my $subclass = $p{name};
    $subclass =~ s/-/_/g;
    $subclass =~ s/\//::/g;
    my $real_class = "DateTime::TimeZone::$subclass";

    eval "require $real_class";
    die "Invalid time zone name: $p{name}" if $@;

    return $real_class->instance( name => $p{name} );
}

sub _init
{
    my $class = shift;
    my %p = validate( @_,
                      { name => { type => SCALAR },
                        spans => { type => ARRAYREF },
                      },
                    );

    my $self = bless { name  => $p{name},
                       spans => $p{spans},
                     }, $class;

    return $self;
}

sub is_dst_for_datetime
{
    my $self = shift;

    my $span = $self->_span_for_datetime( 'utc', $_[0] );

    return $span->{is_dst};
}

sub offset_for_datetime
{
    my $self = shift;

    my $span = $self->_span_for_datetime( 'utc', $_[0] );

    return $span->{offset};
}

sub offset_for_local_datetime
{
    my $self = shift;

    my $span = $self->_span_for_datetime( 'local', $_[0] );

    return $span->{offset};
}

sub short_name_for_datetime
{
    my $self = shift;

    my $span = $self->_span_for_datetime( 'utc', $_[0] );

    return $span->{short_name};
}

sub _span_for_datetime
{
    my $self = shift;
    my $type = shift;
    my $dt   = shift;

    my $method = $type . '_rd_as_seconds';

    my $seconds = $dt->$method();
    if ( $seconds < $self->max_span->{"${type}_end"} )
    {
        my $span = $self->_spans_binary_search( $type, $seconds );

        # This means someone gave a local time that doesn't exist
        # (like during a transition into savings time)
        unless ( defined $span )
        {
            my $err = 'Invalid local time for date';
            $err .= ' ' . $dt->iso8601 if $type eq 'utc';
            $err .= "\n";

            die $err;
        }

        return $span;
    }
    else
    {
        return $self->_generate_spans_until_match($dt);
    }
}

sub max_span { $_[0]->{spans}[-1] }

sub _spans_binary_search
{
    my $self = shift;
    my ( $type, $seconds ) = @_;

    my $start = "${type}_start";
    my $end   = "${type}_end";

    my $min = 0;
    my $max = scalar @{ $self->{spans} } + 1;
    my $i = int( $max / 2 );
    $i++ if $max % 2;

    while (1)
    {
        my $current = $self->{spans}[$i];

        if ( $seconds < $current->{$start} )
        {
            $max = $i;
            my $c = int( ( $i - $min ) / 2 );
            $c ||= 1;

            $i -= $c;

            return if $i < $min;
        }
        elsif ( $seconds >= $current->{$end} )
        {
            $min = $i;
            my $c = int( ( $max - $i ) / 2 );
            $c ||= 1;

            $i += $c;

            return if $i >= $max;
        }
        else
        {
            # Special case for overlapping ranges because of DST.
            # Always prefer earliest span.
            if ( ! $current->{is_dst} && $type eq 'local' )
            {
                my $prev = $self->{spans}[$i - 1];

                if ( $prev->{$start} <= $seconds &&
                     $seconds        <= $prev->{$end} )
                {
                    return $prev;
                }
            }

            return $current;
        }
    }
}

sub is_floating { 0 }

sub is_utc { 0 }

sub name      { $_[0]->{name} }
sub category  { (split /\//, $_[0]->{name}, 2)[0] }


#
# Functions
#
sub offset_as_seconds
{
    my $offset = shift;

    return undef unless defined $offset;

    return 0 if $offset eq '0';

    return undef unless $offset =~ /^([\+\-])?(\d\d?):?(\d\d)(?::?(\d\d))?$/;

    my ( $sign, $hours, $minutes, $seconds ) = ( $1, $2, $3, $4 );
    $sign = '+' unless defined $sign;

    my $total =  ($hours * 60 * 60) + ($minutes * 60);
    $total += $seconds if $seconds;
    $total *= -1 if $sign eq '-';

    return $total;
}

sub offset_as_string
{
    my $offset = shift;

    return undef unless defined $offset;

    my $sign = $offset < 0 ? '-' : '+';

    my $hours = $offset / ( 60 * 60 );
    $hours = abs($hours) % 24;

    my $mins = ( $offset % ( 60 * 60 ) ) / 60;

    my $secs = $offset % 60;

    return ( $secs ?
             sprintf( '%s%02d%02d%02d', $sign, $hours, $mins, $secs ) :
             sprintf( '%s%02d%02d', $sign, $hours, $mins )
           );
}


1;

__END__

=head1 NAME

DateTime::TimeZone - Time zone object base class and factory

=head1 SYNOPSIS

  use DateTime::TimeZone

  my $tz = DateTime::TimeZone->new( name => 'America/Chicago' );

=head1 DESCRIPTION

This class is the base class for all time zone objects.  A time zone
is represented internally as a set of observances, each of which
describes the offset from GMT for a given time period.

=head1 USAGE

This class has the following methods:

=over 4

=item * new( name => $tz_name )

Given a valid time zone name, this method returns a new time zone
blessed into the appropriate subclass.  Subclasses are named for the
given time zone, so that the time zone "America/Chicago" is the
DateTime::TimeZone::America::Chicago class.

If the name given is a "link" name in the Olson database, the object
created may have a different name.  For example, there is a link from
the old "EST5EDT" name to "America/New_York".

There are also several special values that can be given as names.

If the "name" parameter is "floating", then a
C<DateTime::TimeZone::Floating> object is returned.  A floating time
zone does have I<any> offset, and is always the same time.  This is
useful for calendaring applications, which may need to specify that a
given event happens at the same I<local> time, regardless of where it
occurs.  See RFC 2445 for more details.

If the "name" parameter is "local", then the local time zone of the
current system is used.  If C<$ENV{TZ}> is defined, and it is not the
string 'local', then it is treated as any other valid name (including
"floating"), and the constructor tries to create a time zone based on
that name.

If C<$ENV{TZ}> is not defined, or it does not contain a valid time
zone name, then the local offset is calculated by comparing the
difference between the C<Time::Local> module's C<timegm()> and
C<timelocal()> functions.  This offset is then used to create a
C<DateTime::TimeZone::OffsetOnly> object.

If the "name" parameter is "UTC", then a C<DateTime::TimeZone::UTC>
object is returned.

Finally, if the "name" is an offset string, it is converted to a
number, and a C<DateTime::TimeZone::OffsetOnly> object is returned.

=item * offset_for_datetime( $datetime )

Given an object which implements the DateTime.pm API, this method
returns the offset in seconds for the given datetime.  This takes into
account historical time zone information, as well as Daylight Saving
Time.  The offset is determined by looking at the object's UTC Rata
Die days and seconds.

=item * offset_for_local_datetime( $datetime )

Given an object which implements the DateTime.pm API, this method
returns the offset in seconds for the given datetime.  Unlike the
previous method, this method uses the local time's Rata Die days and
seconds.  This should only be done when the corresponding UTC time is
not yet known, because local times can be ambiguous due to Daylight
Saving Time rules.

=item * name

Returns the name of the time zone, as given in the Olson database.

=item * short_name_for_datetime( $datetime )

Given an object which implements the DateTime.pm API, this method
returns the "short name" for the current observance and rule this
datetime is in.  These are names like "EST", "GMT", etc.

It is B<strongly> recommended that you do not rely on these names for
anything other than display.  These names are not official, and many
of them are simply the invention of the Olson database maintainers.
Moreover, these names are not unique.  For example, there is an "EST"
at both -0500 and +1000/+1100.

=item * is_floating

Returns a boolean indicating whether or not this object represents a
floating timezone, as defined by RFC 2445.

=item * is_utc

Indicates whether or not this object represents the UTC (GMT) time
zone.

=item * category

Returns the part of the time zone name before the first slash.  For
example, the "America/Chicago" time zone would return "America".

=back

This class also contains several functions, none of which are
exported.

=over 4

=item * all_names

This returns a pre-sorted list of all the time zone names.  This list
does not include link names.  In scalar context, it returns an array
reference, while in list context it returns an array.

=item * categories

This returns a list of all time zone categories.  In scalar context,
it returns an array reference, while in list context it returns an
array.

=item * names_in_category( $category )

Given a valid category, this method returns a list of the names in
that category, without the category portion.  So the list for the
"America" category would include the strings "Chicago",
"Kentucky/Monticello", and "New_York".  In scalar context, it returns
an array reference, while in list context it returns an array.

=item * offset_as_seconds( $offset )

Given an offset as a string, this returns the number of seconds
represented by the offset as a positive or negative number.

=item * offset_as_string( $offset )

Given an offset as a number, this returns the offset as a string.

=back

=head1 SUPPORT

Support for this module is provided via the datetime@perl.org email
list.  See http://lists.perl.org/ for more details.

=head1 AUTHOR

Dave Rolsky <autarch@urth.org>, inspired by Jesse Vincent's work on
Date::ICal::Timezone, and with help from the datetime@perl.org list.

=head1 COPYRIGHT

Copyright (c) 2003 David Rolsky.  All rights reserved.  This program
is free software; you can redistribute it and/or modify it under the
same terms as Perl itself.

The full text of the license can be found in the LICENSE file included
with this module.

=head1 SEE ALSO

datetime@perl.org mailing list

http://datetime.perl.org/

=cut
