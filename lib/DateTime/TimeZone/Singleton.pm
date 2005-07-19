package DateTime::TimeZone::Singleton;
use strict;
use DateTime::TimeZone;
use Class::Singleton;
use Params::Validate qw(validate SCALAR BOOLEAN);

@DateTime::TimeZone::Singleton::ISA = ('Class::Singleton', 'DateTime::TimeZone');

sub _new_instance
{
    my $class = shift;
    my %p = validate( @_,
                      { name     => { type => SCALAR },
                        is_olson => { type => BOOLEAN, default => 0 },
                      },
                    );
    return $class->_init(\%p);
}

# Only meaningful for Storable >= 2.14
sub STORABLE_attach
{
    my $class = shift;
    my $cloning = shift;
    my $serialized = shift;

    $class->instance(name => $serialized);
}

sub STORABLE_thaw
{
}

1;

__END__

=head1 NAME

DateTime::TimeZone::Singleton - Base Class For Singleton TimeZones

=head1 SYNOPSIS

  package MyTimeZone;
  use base qw(DateTime::TimeZone::Singleon);

=head1 DESCRIPTION

This module is a base class for DateTime::TimeZone objects that are implemented
as a singleton. It provides the necessary hooks for certain commoon operations.


=cut
