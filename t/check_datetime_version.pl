use strict;

BEGIN
{
    eval "use DateTime 0.09";
    if ($@)
    {
        Test::More::plan
            ( skip_all => "Cannot run tests before DateTime.pm is installed." );
        exit;
    }
}

1;
