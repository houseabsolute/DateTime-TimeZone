use strict;
use warnings;

use DateTime::TimeZone;

BEGIN {
    # Work around not having a version when using dzil
    if ( !$DateTime::TimeZone::VERSION ) {
        $DateTime::TimeZone::VERSION = 99;
    }

    my $version = '0.1501';

    ## no critic (BuiltinFunctions::ProhibitStringyEval)
    unless ( "use DateTime $version; 1;" && !$@ ) {
        Test::More::plan( skip_all =>
                "Cannot run tests before DateTime.pm $version is installed."
        );
        exit;
    }
}

1;
