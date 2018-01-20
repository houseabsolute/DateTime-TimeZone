package DateTime::TimeZone::Floating;

use strict;
use warnings;
use namespace::autoclean;

our $VERSION = '2.17';

use parent 'Class::Singleton', 'DateTime::TimeZone::OffsetOnly';

sub new {
    return shift->instance;
}

## no critic (Subroutines::ProhibitUnusedPrivateSubroutines)
sub _new_instance {
    my $class = shift;

    return bless {
        name   => 'floating',
        offset => 0
    }, $class;
}
## use critic

sub is_floating {1}

sub STORABLE_thaw {
    my $self = shift;

    my $class = ref $self || $self;

    my $obj;
    if ( $class->isa(__PACKAGE__) ) {
        $obj = __PACKAGE__->new();
    }
    else {
        $obj = $class->new();
    }

    %$self = %$obj;

    return $self;
}

1;

# ABSTRACT: A time zone that is always local

__END__

=head1 SYNOPSIS

  my $floating_tz = DateTime::TimeZone::Floating->new;

=head1 DESCRIPTION

This class is used to provide the DateTime::TimeZone API needed by
DateTime.pm, but for floating times, as defined by the RFC 2445 spec.
A floating time has no time zone, and has an effective offset of zero.

=head1 USAGE

This class has the same methods as a real time zone object. The
C<short_name_for_datetime()> method returns the string "floating" and the
C<category()> method returns C<undef>.

=cut
