package DateTime::TimeZone::OffsetOnly;

use strict;

use vars qw ($VERSION);
$VERSION = 0.01;

sub new
{
    my $class = shift;
    my %p = validate( @_, { offset => { type => SCALAR },
                          } );

    my $self = {};
    $self->{offset} =
        DateTime::TimeZone::offset_as_seconds( $p{offset} );

    $self->{offset_string} =
        DateTime::TimeZone::offset_as_string( $p{offset} );

    return bless $self, $class;
}

sub observance_for_datetime { return }

sub offset_for_datetime { $_[0]->{offset} }

sub is_floating { 0 }


1;

__END__

=head1 NAME

DateTime::TimeZone::OffsetOnly - A DateTime::TimeZone object that just contains an offset

=head1 SYNOPSIS

  my $offset_tz = DateTime::TimeZone::OffsetOnly->new( offset => '-0300' );

=head1 DESCRIPTION

This class is used to provide the DateTime::TimeZone API needed by
DateTime.pm, but with a fixed offset.  An object in this class always
returns the same offset as was given in its constructor, regardless of
the date.

=head1 USAGE

This class has the following methods:

=over 4

=item * new ( offset => $offset )

The value given to the offset parameter may be either a string, such
as "+0300", or a number.  Strings will be converted into numbers by
the C<DateTime::TimeZone::offset_as_seconds> function.  Numbers are
used as is.

=item * offset_for_datetime( $datetime )

No matter what date is given, the offset provided to the constructor
is always used.

=back

This class does not support the C<observance_for_datetime()> method.

=cut
