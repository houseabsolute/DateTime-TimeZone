package DateTime::TimeZone::Local;

use strict;

use File::Spec;

sub local_time_zone
{
    my $tz;

    $tz = _from_env();
    return $tz if $tz;

    $tz = _from_etc_localtime();
    return $tz if $tz;

    $tz = _from_etc_timezone();
    return $tz if $tz;

    $tz = _from_etc_sysconfig_clock();
    return $tz if $tz;

    die "Cannot determine local time zone\n";
}

sub _from_env
{
    if ( defined $ENV{TZ} &&
         $ENV{TZ} ne 'local' &&
         _could_be_valid_time_zone( $ENV{TZ} )
       )
    {
        return eval { DateTime::TimeZone->new( name => $ENV{TZ} ) };
    }
}

sub _from_etc_localtime
{
    return unless -l '/etc/localtime';

    # called like this so test suite can test this functionality
    my $real_name = _readlink( '/etc/localtime' );

    if ( defined $real_name )
    {
        my ($vol, $dirs, $file) = File::Spec->splitpath( $real_name );

        my @parts =
            grep { defined && length } File::Spec->splitdir( $dirs ), $file;

        foreach my $x ( reverse 0..$#parts )
        {
            my $name =
                ( $x < $#parts ?
                  join '/', @parts[$x..$#parts] :
                  $parts[$x]
                );

            my $tz;
            $tz = eval { DateTime::TimeZone->new( name => $name ) };
            return $tz if $tz;
        }
    }
}

sub _from_etc_timezone
{
    return unless -f '/etc/timezone' && -r _;

    local *TZ;
    open TZ, "</etc/timezone"
        or die "Cannot read /etc/timezone: $!";
    my $name = join '', <TZ>;
    close TZ;

    $name =~ s/^\s+|\s+$//g;

    return eval { DateTime::TimeZone->new( name => $name ) };
}

sub _readlink { readlink($_[0]) }

# RedHat uses this
sub _from_etc_sysconfig_clock
{
    return unless -r "/etc/sysconfig/clock" && -f _;

    my $name = _read_etc_sysconfig_clock();

    if ( defined $name && _could_be_valid_time_zone($name) )
    {
        return eval { DateTime::TimeZone->new( name => $name ) };
    }
}

# this is a sparate function so that it can be overridden in the test
# suite
sub _read_etc_sysconfig_clock
{
    local *CLOCK;
    local $_;
    open CLOCK, '</etc/sysconfig/clock'
        or die "Cannot read /etc/sysconfig/clock: $!";

    while (<CLOCK>)
    {
        next unless /^ZONE/;

        return $1 if /ZONE="([^"]+)"/;
    }
}

sub _could_be_valid_time_zone
{
    return 0 unless defined $_[0];
    return 0 if $_[0] eq 'local';

    return $_[0] =~ m,^[\w/]+$, ? 1 : 0;
}


1;

__END__

=head1 NAME

DateTime::TimeZone::Local - Code to determine the system's local time zone

=head1 SYNOPSIS

  my $tz = DateTime::TimeZone->new( name => 'local' );

=head1 DESCRIPTION

This package is used to try to figure out what the local time zone is,
in a variety of ways.  See the
L<DateTime::TimeZone|DateTime::TimeZone> docs for more details.

=back

=cut
