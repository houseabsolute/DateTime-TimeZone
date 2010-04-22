use strict;
use warnings;

use File::Spec;
use Test::More;

use lib File::Spec->catdir( File::Spec->curdir, 't' );

BEGIN { require 'check_datetime_version.pl' }

use DateTime::TimeZone;

for my $link ( DateTime::TimeZone::links() ) {
    my $tz = DateTime::TimeZone->new( name => $link );
    isa_ok( $tz, 'DateTime::TimeZone' );
}

my $tz = DateTime::TimeZone->new( name => 'Libya' );
is( $tz->name, 'Africa/Tripoli', 'check ->name' );

$tz = DateTime::TimeZone->new( name => 'US/Central' );
is( $tz->name, 'America/Chicago', 'check ->name' );

done_testing();
