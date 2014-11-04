package DateTime::TimeZone::Local::Android;

use strict;
use warnings;

use Try::Tiny;

use parent 'DateTime::TimeZone::Local';

sub Methods {
    return qw(
        FromEnv
        FromGetProp
        FromDefault
    );
}

sub EnvVars { return 'TZ' }

# https://chromium.googlesource.com/native_client/nacl-bionic/+/upstream/master/libc/tzcode/localtime.c
sub FromGetProp {
    my $name = `getprop persist.sys.timezone`;
    chomp $name;
    my $tz = try {
        local $SIG{__DIE__} = undef;
        DateTime::TimeZone->new( name => $name );
    };

    return $tz if $tz;
}

# See the link above. Android always defaults to UTC
sub FromDefault {
    my $tz = try {
        local $SIG{__DIE__} = undef;
        $tz = DateTime::TimeZone->new( name => 'UTC' );
    }

    return $tz if $tz;
}

1;
