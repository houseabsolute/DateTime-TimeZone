use strict;

use Test::More;

BEGIN
{
    eval { require DateTime };
    if ($@)
    {
        plan skip_all => "Cannot run tests before DateTime.pm is installed.";
        exit;
    }
}

plan tests => 4;

use DateTime::TimeZone;

{
    local $ENV{TZ} = 'this will not work';

    my $tz;
    eval { $tz = DateTime::TimeZone->new( name => 'local' ) };
    ok( ! $@, 'invalid time zone name in $ENV{TZ} should not die' );
    isa_ok( $tz, 'DateTime::TimeZone::OffsetOnly' );
}

{
    local $ENV{TZ} = 'America/Chicago';

    my $tz;
    eval { $tz = DateTime::TimeZone->new( name => 'local' ) };
    ok( ! $@, 'valid time zone name in $ENV{TZ} should not die' );
    isa_ok( $tz, 'DateTime::TimeZone::America::Chicago' );
}
