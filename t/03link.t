use strict;

use Test::More tests => 1;

use DateTime::TimeZone;

my $tz = DateTime::TimeZone->new( name => 'CST6CDT' );
is( $tz->name, 'America/Chicago', 'check ->name' );
