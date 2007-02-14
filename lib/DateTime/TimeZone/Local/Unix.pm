package DateTime::TimeZone::Local::Unix;

use strict;
use warnings;

use base 'DateTime::TimeZone::Local';


sub Methods { return qw( FromEnv FromEtc ) }

sub EnvVars { return 'TZ' }

sub FromEtc
{
    my $class = shift;

    for my $meth ( qw( _EtcLocaltime _EtcTimezone _EtcTIMEZONE
                       _EtcSysconfigClock _EtcDefaultInit) )
    {
        my $tz = $class->$meth();

        return $tz if $tz;
    }
}

sub _EtcLocaltime
{
    my $class = shift;

    my $lt_file = '/etc/localtime';

    return unless -r $lt_file && -s _;

    my $real_name;
    if ( -l $lt_file )
    {
	# The _Readlink sub exists so the test suite can mock it.
	$real_name = $class->_Readlink( $lt_file );
    }
    else
    {
        $real_name = $class->_FindMatchingZoneinfoFile( $lt_file );
    }

    if ( defined $real_name )
    {
	my ( $vol, $dirs, $file ) = File::Spec->splitpath( $real_name );

	my @parts =
	    grep { defined && length } File::Spec->splitdir( $dirs ), $file;

        foreach my $x ( reverse 0..$#parts )
        {
            my $name =
                ( $x < $#parts ?
                  join '/', @parts[$x..$#parts] :
                  $parts[$x]
                );

            my $tz = eval { DateTime::TimeZone->new( name => $name ) };

            return $tz if $tz;
        }
    }
}

sub _Readlink { readlink $_[0] }

# for systems where /etc/localtime is a copy of a zoneinfo file
sub _FindMatchingZoneinfoFile
{
    my $class         = shift;
    my $file_to_match = shift;

    return unless -d '/usr/share/zoneinfo';

    require File::Basename;
    require File::Compare;
    require File::Find;

    my $size = -s $file_to_match;

    my $real_name;

    local $_;
    eval
    {
        local $SIG{__DIE__};
        File::Find::find
            ( { wanted =>
                sub
                {
                    if ( ! defined $real_name
                         && -f $_
                         && ! -l $_
                         && $size == -s _
                         # This fixes RT 24026 - apparently such a
                         # file exists on FreeBSD and it can cause a
                         # false positive
                         && File::Basename::basename($_) ne 'posixrules'
                         && File::Compare::compare( $_, $file_to_match ) == 0
                       )
                    {
                        $real_name = $_;

                        # File::Find has no mechanism for bailing in the
                        # middle of a find.
                        die { found => 1 };
                    }
                },
                no_chdir => 1,
              },
              '/usr/share/zoneinfo',
            );
    };

    if ($@)
    {
        return $real_name if ref $@ && $@->{found};
        die $@;
    }
}

sub _EtcTimezone
{
    my $class = shift;

    my $tz_file = '/etc/timezone';

    return unless -f $tz_file && -r _;

    local *TZ;
    open TZ, "<$tz_file"
        or die "Cannot read $tz_file: $!";
    my $name = join '', <TZ>;
    close TZ;

    $name =~ s/^\s+|\s+$//g;

    return eval { DateTime::TimeZone->new( name => $name ) };
}

sub _EtcTIMEZONE
{
    my $class = shift;

    my $tz_file = '/etc/TIMEZONE';

    return unless -f $tz_file && -r _;

    local *TZ;
    open TZ, "<$tz_file"
        or die "Cannot read $tz_file: $!";

    my $name;
    while ($name = <TZ>)
    {
       if ($name =~ /\A\s*TZ=\s*(\S+)/)
       {
          $name = $1;
          last;
       }
    }

    close TZ;

    return $name && eval { DateTime::TimeZone->new( name => $name ) };
}

# RedHat uses this
sub _EtcSysconfigClock
{
    my $class = shift;

    return unless -r "/etc/sysconfig/clock" && -f _;

    my $name = $class->_ReadEtcSysconfigClock();

    if ( $class->_IsValidName($name) )
    {
        return eval { DateTime::TimeZone->new( name => $name ) };
    }
}

# this is a sparate function so that it can be overridden in the test
# suite
sub _ReadEtcSysconfigClock
{
    my $class = shift;

    local *CLOCK;
    open CLOCK, '</etc/sysconfig/clock'
        or die "Cannot read /etc/sysconfig/clock: $!";

    local $_;
    while (<CLOCK>)
    {
        return $1 if /^(?:TIME)?ZONE="([^"]+)"/;
    }
}

sub _EtcDefaultInit
{
    my $class = shift;

    return unless -r "/etc/default/init" && -f _;

    my $name = $class->_ReadEtcDefaultInit();

    if ( $class->_IsValidName($name) )
    {
        return eval { DateTime::TimeZone->new( name => $name ) };
    }
}

# this is a sparate function so that it can be overridden in the test
# suite
sub _ReadEtcDefaultInit
{
    my $class = shift;

    local *INIT;
    open INIT, '</etc/default/init'
        or die "Cannot read /etc/default/init: $!";

    local $_;
    while (<INIT>)
    {
        return $1 if /^TZ=(.+)/;
    }
}


1;
