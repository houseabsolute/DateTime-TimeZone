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

plan tests => 1;

use DateTime::TimeZone;

my $tz = DateTime::TimeZone->new( name => 'CST6CDT' );
is( $tz->name, 'America/Chicago', 'check ->name' );
