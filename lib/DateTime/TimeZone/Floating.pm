package DateTime::TimeZone::Floating;

use strict;

use vars qw ($VERSION @ISA);
$VERSION = 0.01;

@ISA = 'DateTime::TimeZone::OffsetOnly';

sub new
{
    my $class = shift;

    return $class->SUPER::new( offset => 0 );
}

sub is_floating { 1 }

__END__

=head1 NAME

DateTime::TimeZone::Floating - A DateTime::TimeZone object that just contains an offset

=head1 SYNOPSIS

  my $floating_tz = DateTime::TimeZone::Floating->new;

=head1 DESCRIPTION

This class is used to provide the DateTime::TimeZone API needed by
DateTime.pm, but for floating times, as defined by the RFC 2445 spec.
A floating time has no time zone, and has an effective offset of zero.

=head1 USAGE

This class has the following methods:

=over 4

=item * new ( offset => $offset )

The value given to the offset parameter may be either a string, such
as "+0300", or a number.  Strings will be converted into numbers by
the C<DateTime::TimeZone::offset_as_seconds> function.  Numbers are
used as is.

=item * offset_for_datetime( $datetime )

No matter what date is given, this method always returns zero.

=back

This class does not support the C<observance_for_datetime()> method.

=cut
