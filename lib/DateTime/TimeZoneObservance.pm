package DateTime::TimeZoneObservance;

use strict;

use Date::ICal;
use Date::Set;

use Params::Validate qw( validate SCALAR BOOLEAN UNDEF ARRAYREF );

sub new
{
    my $class = shift;
    my %args = validate( @_,
                         { DTSTART => { type => SCALAR },
                           TZOFFSETFROM => { type => SCALAR },
                           TZOFFSETTO   => { type => SCALAR },
                           RRULE  => { type => SCALAR | UNDEF, optional => 1 },
                           RDATE  => { type => ARRAYREF | UNDEF, optional => 1 },
                           TZNAME => { type => SCALAR },
                           is_dst => { type => BOOLEAN },
# not used, AFAICT
#                           EXRULE          => undef,
#                           EXDATE          => undef,
                         }
                       );

    die "Must provide either RDATE or RRULE to DateTime::TimeZoneObservance->new"
        unless $args{RRULE} || $args{RDATE};

    my $self = bless \%args, $class;

    if ( $self->{TZOFFSETTO} eq '0' )
    {
        $self->{offset} = 0;
    }
    elsif ( $self->{TZOFFSETTO} =~ /^([\+\-])(\d\d)(\d\d)(\d\d)?$/ )
    {
        my ( $sign, $hours, $minutes, $seconds ) = ( $1, $2, $3, $4 );

        $self->{offset} = ($hours * 60 * 60) + ($minutes * 60);
        $self->{offset} += $seconds if $seconds;
        $self->{offset} *= -1 if $sign eq '-';
    }
    else
    {
        die "Invalid offset $self->{TZOFFSETTO}";
    }

    $self->_build_date_set;

    return $self;
}

sub _build_date_set
{
    my $self = shift;

    my $start_in_gmt = Date::ICal->new( ical => $self->{DTSTART},
                                        offset => $self->{TZOFFSETFROM} );

    $self->{date_set} = Date::Set->event( start => $start_in_gmt->ical );

    $self->{date_set} =
        $self->{date_set}->event( rule => @{ $self->{RDATE} } )
            if $self->{RDATE};

    $self->{date_set} =
        $self->{date_set}->event( rule => $self->{RRULE} )
            if $self->{RRULE};

}

sub is_dst { $_[0]->{is_dst} }

sub date_set { $_[0]->{date_set} }

sub _DTSTART { $_[0]->{DTSTART} }

sub _RRULE { $_[0]->{RRULE} }

sub _RDATE { $_[0]->{RDATE} }

sub _EXRULE { $_[0]->{EXRULE} }

sub _EXRULE { $_[0]->{EXDATE} }

sub _TZNAME { $_[0]->{TZNAME} }
*short_name = \&TZNAME;

sub _TZOFFSETFROM { $_[0]->{TZOFFSETFROM} }

sub _TZOFFSETTO { $_[0]->{TZOFFSETTO} }
*offset_string = \&TZOFFSETTO;

sub offset { $_[0]->{offset} }



1;

__END__


=head1 NAME

DateTime::TimeZoneObservance - Represents an single observance for a time zone

=head1 SYNOPSIS

 ...

=head1 DESCRIPTION

This class represents an observance for a single time zone.

An observance describes how offsets from GMT change over a number of
years.

=head1 METHODS

=item * new

Takes a hash of:

    RRULE
    RDATE
    TZNAME
    OFFSETFROM
    OFFSETTO
    EXDATE
    EXRULE
    DTSTART
    is_dst

Builds an observance, including a Date::Set describing the recurrence.

=over 4

=item * is_dst

Returns true if this observance is daylight savings time.

=item * offset

The observance's offset in seconds as an integer.

=item * offset_string

The observance's offset in string form, such as '-0600'.

=item * short_name

The abbreviated name for the observance's offset, such as 'EST'.

=back

=cut
