package DateTime::TimeZone;

use strict;

use vars qw( $VERSION $INFINITY $NEG_INFINITY );
$VERSION = 0.01;

use DateTime::TimeZone::Floating;
use DateTime::TimeZoneCatalog;
use Params::Validate qw( validate validate_pos SCALAR ARRAYREF );
use Tree::RedBlack;

$INFINITY = 10 ** 10 ** 10;
$NEG_INFINITY = -1 * $INFINITY;

sub new
{
    my $class = shift;
    my %p = validate( @_,
                      { name => { type => SCALAR } },
                    );

    if ( $p{name} eq 'floating' )
    {
        return DateTime::TimeZone::Floating->new;
    }

    if ( exists $DateTime::TimeZone::Links{ $p{name} } )
    {
        $p{name} = $DateTime::TimeZone::Links{ $p{name} };
    }

    my $subclass = $p{name};
    $subclass =~ s/-/_/g;
    $subclass =~ s/\//::/g;
    my $real_class = "DateTime::TimeZone::$subclass";

    eval "require $real_class";
    die "Invalid time zone name: $p{name}" if $@;

    return $real_class->load( name => $p{name} );
}

sub _init
{
    my $class = shift;
    my %p = validate( @_,
                      { name => { type => SCALAR },
                        spans => { type => ARRAYREF },
                      },
                    );

    my $self = bless { name => $p{name} }, $class;

    $self->_build_span_tree( $p{spans} );

    return $self;
}

sub _build_span_tree
{
    my $self = shift;
    my $spans = shift;

    my $tree = Tree::RedBlack->new;
    $tree->cmp( \&_is_in_span );
    foreach my $span (@$spans)
    {
        $tree->insert( [ $span->{start_date}, $span->{end_date} ], $span );
    }

    $self->{tree} = $tree;
}

sub _is_in_span
{
    my ($i1, $i2) = @_;

    # We have to compare two spans when adding nodes to the tree.
    if ( ref $i1 && ref $i2 )
    {
        return -1 if $i1->[0] < $i2->[0];
        return  1 if $i1->[1] > $i2->[1];

        return  0;
    }
    elsif ( ref $i1 )
    {
        return -1 if $i2 <  $i1->[0];
        return  1 if $i2 >= $i1->[1];

        return  0;
    }
    else
    {
        return -1 if $i1 <  $i2->[0];
        return  1 if $i1 >= $i2->[1];

        return  0;
    }
}

sub offset_for_datetime
{
    my $self = shift;

    my $span = $self->_span_for_datetime( $_[0] );

    return $span->{offset};
}

sub short_name_for_datetime
{
    my $self = shift;

    my $span = $self->_span_for_datetime( $_[0] );

    return $span->{short_name};
}

sub _span_for_datetime
{
    my $self = shift;
    my $dt   = shift;

    my $number = $self->_numeric_dt($dt);

    if ( my $span = $self->{tree}->find($number) )
    {
        return $span;
    }
    else
    {
        return $self->_generate_spans_until_match($dt);
    }
}

sub _numeric_dt
{
    # add 0 to force numification
    sprintf( '%04d%02d%02d%02d%02d%02d',
             $_[1]->year, $_[1]->month, $_[1]->day,
             $_[1]->hour, $_[1]->minute, $_[1]->second,
           ) + 0;
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

    # if it's just numbers assume it's seconds
    return $offset if $offset =~ /^\d+$/;

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

    return '0' unless $offset;

    return $offset if $offset =~ /^[\+\-]\d\d\d\d(?:\d\d)?$/;

    my $sign = $offset < 0 ? '-' : '+';

    my $hours = $offset / ( 60 * 60 );
    $hours %= 24;

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

=item * new ( name => $tz_name )

Given a valid time zone name, this method returns a new time zone
blessed into the appropriate subclass.  Subclasses are named for the
given time zone, so that the time zone "America/Chicago" is the
DateTime::TimeZone::America::Chicago class.

=item * offset_for_datetime( $datetime )

Given an object which implements the DateTime.pm API, this method
returns the offset in seconds for the given datetime.  This takes into
account historical time zone information, as well as Daylight Saving
Time.

=item * short_name_for_datetime( $datetime )

Given an object which implements the DateTime.pm API, this method
returns the "short name" for the current observance and rule this
datetime is in.  These are things like "EST", "GMT", etc.

=item * is_floating

Returns a boolean indicating whether or not this object represents a
floating timezone, as defined by RFC 2445.

=item * is_utc

Indicates whether or not this object represents the UTC (GMT) time
zone.

=item * name

Returns the name of the time zone.

=item * category

Returns the part of the time zone name before the first slash.  For
example, the "America/Chicago" time zone would return "America".

=back

This class also contains two functions, which are not exported.

=over 4

=item * offset_as_seconds( $offset )

Given an offset as a string or number, this returns the number of
seconds represented by the offset as a positive or negative number.

=item * offset_as_string( $offset )

Given an offset as a string or number, this returns the offset as
string.

=back

=head1 SUPPORT



=head1 AUTHOR

Dave Rolsky <autarch@urth.org>, with inspiration from Jesse Vincent's
work on Date::ICal::Timezone.

=head1 COPYRIGHT

This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.

=cut
