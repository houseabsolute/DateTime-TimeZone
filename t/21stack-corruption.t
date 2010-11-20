use strict;
use warnings;

use DateTime::TimeZone::Local;

use Test::More;

use lib File::Spec->catdir( File::Spec->curdir, 't' );

BEGIN { require 'check_datetime_version.pl' }

# We need to make sure that we can determine the local tz
$ENV{TZ} = 'America/Chicago';

$^O = 'does_not_exist';

my @input = ( 1 .. 10 );

# Stack corruption from a failed use of eval to load a local subclass would
# cause the sort to exit prematurely.
my @output = sort {
    DateTime::TimeZone::Local->TimeZone();
    $a <=> $b
} @input;

is_deeply( \@output, \@input );

done_testing();

