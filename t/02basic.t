use strict;

use Test::More tests => 18;

use DateTime::TimeZone;

my $tz = DateTime::TimeZone->new( name => 'America/Chicago' );
ok( $tz, 'get America/Chicago time zone object' );
isa_ok( $tz, 'DateTime::TimeZone' );

is( $tz->name, 'America/Chicago', 'check ->name' );
is( $tz->category, 'America', 'check ->category' );

is( $tz->is_floating, 0, 'should not be floating' );
is( $tz->is_utc, 0, 'should not be UTC' );

# These tests are odd since we're feeding UTC times into the time zone
# object, which isn't what will happen in real usage (I think).
{
    my $dt = DateTime->new( year => 2001,
                            month => 9,
                            day => 10,
                            offset => 0,
                          );
    is( $tz->offset_for_datetime($dt), -18000, 'offset should be -18000' );
    is( $tz->short_name_for_datetime($dt), 'CDT', 'name should be CDT' );
}

{
    my $dt = DateTime->new( year => 2001,
                            month => 10,
                            day => 29,
                            offset => 0,
                          );
    is( $tz->offset_for_datetime($dt), -21600, 'offset should be -21600' );
    is( $tz->short_name_for_datetime($dt), 'CST', 'name should be CST' );
}

{
    my $dt = DateTime->new( year => 2002,
                            month => 10,
                            day => 29,
                            offset => 0,
                          );
    is( $tz->offset_for_datetime($dt), -18000, 'offset should be -18000' );
    is( $tz->short_name_for_datetime($dt), 'CDT', 'name should be CDT' );
}

{
    my $dt = DateTime->new( year => 1944,
                            month => 10,
                            day => 29,
                            offset => 0,
                          );
    is( $tz->offset_for_datetime($dt), -18000, 'offset should be -18000' );
    is( $tz->short_name_for_datetime($dt), 'CWT', 'name should be CWT' );
}


{
    my $dt = DateTime->new( year => 1936,
                            month => 1,
                            day => 29,
                            offset => 0,
                          );
    is( $tz->offset_for_datetime($dt), -18000, 'offset should be -18000' );
    is( $tz->short_name_for_datetime($dt), 'EST', 'name should be EST' );
}

{
    my $dt = DateTime->new( year => 1883,
                            month => 1,
                            day => 29,
                            offset => 0,
                          );
    is( $tz->offset_for_datetime($dt), -21036, 'offset should be -21036' );
    is( $tz->short_name_for_datetime($dt), 'LMT', 'name should be LMT' );
}
