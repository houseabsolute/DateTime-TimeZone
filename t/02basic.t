use strict;

use File::Spec;
use Test::More;

use lib File::Spec->catdir( File::Spec->curdir, 't' );

BEGIN { require 'check_datetime_version.pl' }

use DateTime::TimeZone;

my @names = DateTime::TimeZone::all_names;

my $is_maintainer = -d './CVS' ? 1 : 0;

my $tests_per_zone = $is_maintainer ? 7 : 4;
plan tests => 26 + ( $tests_per_zone * scalar @names );

foreach my $name (@names)
{
    my $tz = DateTime::TimeZone->new( name => $name );
    isa_ok( $tz, 'DateTime::TimeZone' );

    is( $tz->name, $name, 'check ->name' );

    is( $tz->is_floating, 0, 'should not be floating' );
    is( $tz->is_utc, 0, 'should not be UTC' );

    if ( $is_maintainer )
    {
        my $dt;
        eval { $dt = DateTime->now( time_zone => $name ) };
        is( $@, '', "Can call DateTime->now with $name" );
        eval { $dt->add( years => 50 ) };
        is( $@, '', "Can add 200 years with $name" );
        eval { $dt->subtract( years => 400 ) };
        is( $@, '', "Can subtract 400 years with $name" );
    }
}

foreach my $name ( '0', 'Z', 'UTC' )
{
    my $tz = DateTime::TimeZone->new( name => $name );
    isa_ok( $tz, 'DateTime::TimeZone' );

    is( $tz->name, 'UTC', 'name should be UTC' );

    is( $tz->is_floating, 0, 'should not be floating' );
    is( $tz->is_utc, 1, 'should be UTC' );
}


my $tz = DateTime::TimeZone->new( name => 'America/Chicago' );

# These tests are odd since we're feeding UTC times into the time zone
# object, which isn't what happens in real usage.  But doing this
# minimizes how much of DateTime.pm needs to work for these tests.
{
    my $dt = DateTime->new( year => 2001,
                            month => 9,
                            day => 10,
                            time_zone => 'UTC',
                          );
    is( $tz->offset_for_datetime($dt), -18000, 'offset should be -18000' );
    is( $tz->short_name_for_datetime($dt), 'CDT', 'name should be CDT' );
}

{
    my $dt = DateTime->new( year => 2001,
                            month => 10,
                            day => 29,
                            time_zone => 'UTC',
                          );
    is( $tz->offset_for_datetime($dt), -21600, 'offset should be -21600' );
    is( $tz->short_name_for_datetime($dt), 'CST', 'name should be CST' );
}

{
    # check that generation works properly
    my $dt = DateTime->new( year => 2200,
                            month => 10,
                            day => 26,
                            time_zone => 'UTC',
                          );
    is( $tz->offset_for_datetime($dt), -18000, 'generated offset should be -1800' );
    is( $tz->short_name_for_datetime($dt), 'CDT', 'generated name should be CDT' );
}

{
    # check that generation works properly
    my $dt = DateTime->new( year => 2200,
                            month => 10,
                            day => 27,
                            time_zone => 'UTC',
                          );
    is( $tz->offset_for_datetime($dt), -21600, 'generated offset should be -21600' );
    is( $tz->short_name_for_datetime($dt), 'CST', 'generated name should be CST' );
}

{
    my $dt = DateTime->new( year => 1944,
                            month => 10,
                            day => 29,
                            time_zone => 'UTC',
                          );
    is( $tz->offset_for_datetime($dt), -18000, 'offset should be -18000' );
    is( $tz->short_name_for_datetime($dt), 'CWT', 'name should be CWT' );
}


{
    my $dt = DateTime->new( year => 1936,
                            month => 3,
                            day => 2,
                            time_zone => 'UTC',
                          );

    is( $tz->offset_for_datetime($dt), -18000, 'offset should be -18000' );
    is( $tz->short_name_for_datetime($dt), 'EST', 'name should be EST' );
}

{
    my $dt = DateTime->new( year => 1883,
                            month => 1,
                            day => 29,
                            time_zone => 'UTC',
                          );

    is( $tz->offset_for_datetime($dt), -21036, 'offset should be -21036' );
    is( $tz->short_name_for_datetime($dt), 'LMT', 'name should be LMT' );
}
