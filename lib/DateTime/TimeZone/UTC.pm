package DateTime::TimeZone::UTC;

use strict;
use vars qw ($VERSION @ISA);
use Class::Singleton;
use DateTime::TimeZone;

BEGIN
{
    $VERSION = 0.01;
    @ISA = ('DateTime::TimeZone', 'Class::Singleton');

    require DateTime::TimeZone::UTCPP
        unless DateTime::TimeZone::LOADED_XS();
}

sub new
{
    my $class = shift;
    return $class->instance();
}

sub _new_instance
{
    my $class = shift;
    my $foo;
    return bless \$foo, $class;
}

sub DESTROY {}

1;

__END__

=head1 NAME

DateTime::TimeZone::UTC - The UTC time zone

=head1 SYNOPSIS

  my $utc_tz = DateTime::TimeZone::UTC->new;

=head1 DESCRIPTION

This class is used to provide the DateTime::TimeZone API needed by
DateTime.pm for the UTC time zone, which is not explicitly included in
the Olson time zone database.

The offset for this object will always be zero.

=head1 USAGE

This class has the same methods as a real time zone object, but the
C<category()> method returns undef and C<is_utc()> returns true.

=cut
