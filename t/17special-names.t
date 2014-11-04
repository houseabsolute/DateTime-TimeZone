use strict;
use warnings;

use Test::More;

use File::Spec;
use Try::Tiny;

use lib File::Spec->catdir( File::Spec->curdir, 't' );

BEGIN { require 'check_datetime_version.pl' }

for my $name (
    qw( EST MST HST CET EET MET WET EST5EDT CST6CDT MST7MDT PST8PDT )) {
    my $tz = try { DateTime::TimeZone->new( name => $name ) };
    ok( $tz, "got a timezone for name => $name" );
}

done_testing();
