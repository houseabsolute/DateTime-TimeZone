use strict;

use File::Spec;
use Test::More;

use lib File::Spec->catdir( File::Spec->curdir, 't' );

BEGIN { require 'check_datetime_version.pl' }

plan tests => 6;

use DateTime::TimeZone;

{
    # make sure it doesn't find an /etc/localtime file
    local *DateTime::TimeZone::readlink = sub { undef };

    local $ENV{TZ} = 'this will not work';

    my $tz;
    eval { $tz = DateTime::TimeZone->new( name => 'local' ) };
    is( $@, '', 'invalid time zone name in $ENV{TZ} should not die' );
    isa_ok( $tz, 'DateTime::TimeZone::OffsetOnly' );
}

{
    local $ENV{TZ} = 'America/Chicago';

    my $tz;
    eval { $tz = DateTime::TimeZone->new( name => 'local' ) };
    is( $@, '', 'valid time zone name in $ENV{TZ} should not die' );
    isa_ok( $tz, 'DateTime::TimeZone::America::Chicago' );
}

{
    local *DateTime::TimeZone::readlink = sub { '/usr/share/zoneinfo/US/Eastern' };

    my $tz;
    eval { $tz = DateTime::TimeZone->new( name => 'local' ) };
    is( $@, '', 'valid time zone name in /etc/localtime should not die' );
    isa_ok( $tz, 'DateTime::TimeZone::America::New_York' );
}
