use strict;

use Test::More tests => 10;

use DateTime::TimeZone;

my $tz = DateTime::TimeZone->new( name => 'America/Chicago' );
ok( $tz, 'get America/Chicago time zone object' );
isa_ok( $tz, 'DateTime::TimeZone' );

