package DateTime::TimeZone;

use strict;

use vars qw ($VERSION);
$VERSION = 0.01;

use Date::ICal; # will go away later
use Date::ICal::Duration; # will go away later
#use DateTime;
#use DateTime::Duration;

use DateTime::TimeZoneCatalog;
use DateTime::TimeZoneObservance;

use Params::Validate qw( validate validate_pos SCALAR HASHREF );

sub new
{
    my $class = shift;
    my %p = validate( @_,
                      { name => { type => SCALAR } },
                    );

    $p{name} =~ s/-/_/g;
    $p{name} =~ s/\//::/g;
    my $real_class = "DateTime::TimeZone::" . $p{name};

    eval "require $real_class";
    die "Invalid time zone name: $p{name}" if $@;

    return $real_class->new;
}

sub _init
{
    my $class = shift;
    my %p = validate( @_,
                      { zone_info => { type => HASHREF } },
                    );

    my $self = bless { zone_info   => $p{zone_info},
                       observances => [],
                     }, $class;

    $self->_build_observances();

    return $self;
}

sub _build_observances
{
    my $self = shift;

    foreach my $o ( @{ $self->{zone_info}{STANDARD} } )
    {
        push ( @{ $self->{observances} },
               DateTime::TimeZoneObservance->new
                   ( %$o,
                     is_dst => 0,
                   )
             );
    }

    foreach my $o ( @{ $self->{zone_info}{DAYLIGHT} } )
    {
        push ( @{ $self->{observances} },
               DateTime::TimeZoneObservance->new
                   ( %$o,
                     is_dst => 1,
                   )
             );
    }
}

sub observance_for_datetime
{
    my $self = shift;
    my $dt = validate_pos( @_, { isa => 'DateTime' } );

    # will go away
    my $ical =
        Date::ICal->new( ical =>
                         sprintf( '%04d%02d%02dT%02d%02d%02dZ',
                                  $dt->year, $dt->month, $dt->day,
                                  $dt->hour, $dt->minute, $dt->second ),
                       );

    my $most_recent_observance;
    my $most_recent_max;

    # Iterate through observance specified in the timezone definition
    # We're trying to find the most recent timezone marker in any
    # observance.  this will tell us which observance $dt is in
    foreach my $observance ( @{ $self->{observances} } )
    {
        # Observances should be stored as a b-tree (use
        # Tree::RedBlack?) where node keys mark range start & end.
        # Then we find the node inside which the given date fits.  If
        # no node is found and the date at hand is high than the given
        # date, we generate new nodes until we find one inside which
        # the given date fits and store all the nodes in the tree.  If
        # the given date is earlier than the earliest range start, do
        # the opposite. - dave

        # will become a DateTime object eventually
        my $year_ago = $ical - Date::ICal::Duration->new( weeks => 100 );

        my $set = $observance->date_set;
        # Limits the span we look at, I think?  - dave
	$set->during( start => $year_ago, end => $ical );

        # These are ICal datetime specs, which compare properly when
        # lt/gt is used
        my $max = $set->max;
        my $min = $set->min;

        # If we don't yet have _any_ marker or this marker is more
        # recent than than our last candidate marker, pick this one as
        # the new candidate
        if ( ( ( ! defined $most_recent_max ) ||
               ( $max gt $most_recent_max )
             )
             &&
             ( $min lt $ical )
           )
        {
            $most_recent_max = $max;
            $most_recent_observance = $observance;
        }
    }

    # there should be _something here - anything else is a bug ;)
    return $most_recent_observance;
}

sub offset_for_datetime
{
    $_[0]->observance_for_datetime->offset( $_[1] );
}

sub offset_string_for_datetime { offset_as_string( $_[0]->offset_for_datetime( $_[1] ) ) }

sub is_floating { 0 }

#
# Functions
#

sub offset_as_seconds
{
    my $offset = shift;

    # if it's just numbers assume it's seconds
    return $offset if $offset =~ /^\d+$/;

    return undef unless $offset =~ /^([\+\-])(\d\d?):?(\d\d)(:?\d\d)?$/;

    my ( $sign, $hours, $minutes, $seconds ) = ( $1, $2, $3, $4 );

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

=item * offset_string_for_datetime( $datetime )

Given an object which implements the DateTime.pm API, this method
returns the offset as a string for the given datetime.

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

Much of the implementaiton for this module comes from work by Jesse
Vincent <jesse@fsck.com> on Date::ICal::Timezone.

Other pieces were written by Dave Rolsky <autarch@urth.org>

=head1 COPYRIGHT

This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.

=cut
