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

BEGIN
{
    use_ok('DateTime::TimeZone');
}
