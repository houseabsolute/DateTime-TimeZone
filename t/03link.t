use strict;

use File::Spec;
use Test::More;

use lib File::Spec->catdir( File::Spec->curdir, 't' );

BEGIN { require 'check_datetime_version.pl' }

plan tests => 4;

use DateTime::TimeZone;

my $tz = DateTime::TimeZone->new( name => 'CST6CDT' );
is( $tz->name, 'America/Chicago', 'check ->name' );

my $tz = DateTime::TimeZone->new( name => 'CST' );
is( $tz->name, 'America/Chicago', 'check ->name' );

my $tz = DateTime::TimeZone->new( name => 'cst' );
is( $tz->name, 'America/Chicago', 'check ->name' );

my $tz = DateTime::TimeZone->new( name => 'US/Central' );
is( $tz->name, 'America/Chicago', 'check ->name' );
