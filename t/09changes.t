#!/usr/bin/perl -w

use strict;

use File::Spec;
use Test::More;

use lib File::Spec->catdir( File::Spec->curdir, 't' );

BEGIN { require 'check_datetime_version.pl' }

plan tests => 34;

# The point of this group of tests is to try to check that DST changes
# are occuring at exactly the right time in various time zones.  It's
# important to check both pre-generated spans, as well as spans that
# have to be generated on the fly.

# Rule	AN	1996	max	-	Mar	lastSun	2:00s	0	-
# Rule	AN	2000	only	-	Aug	lastSun	2:00s	1:00	-
# Rule	AN	2001	max	-	Oct	lastSun	2:00s	1:00	-
# Zone	NAME		GMTOFF	RULES	FORMAT	[UNTIL]
# Zone Australia/Sydney	10:04:52 -	LMT	1895 Feb
# 			10:00	Aus	EST	1971
# 			10:00	AN	EST

{
    # one minute before change to standard time
    my $dt = DateTime->new( year => 1997, month => 3, day => 29,
                            hour => 15, minute => 59,
                            time_zone => 'UTC' );

    $dt->set_time_zone('Australia/Sydney');

    is( $dt->hour, 2, 'A/S 1997: hour should be 2' );

    $dt->set_time_zone('UTC')->add( minutes => 1 )->set_time_zone('Australia/Sydney');

    is( $dt->hour, 2, 'A/S 1997: hour should still be 2' );
}

# same tests without using UTC as intermediate
{
    # Can't start at 1:59 or we get the _2nd_ 1:59 of that day (post-DST change)
    my $dt = DateTime->new( year => 1997, month => 3, day => 30,
                            hour => 1, minute => 59,
                            time_zone => 'Australia/Sydney' );

    $dt->add( hours => 1 );

    is( $dt->hour, 2, 'A/S 1997: hour should be 2' );

    $dt->add( minutes => 1 );

    is( $dt->hour, 2, 'A/S 1997: hour should still be 2' );
}

{
    # one minute before change to standard time
    my $dt = DateTime->new( year => 2002, month => 10, day => 26,
                            hour => 15, minute => 59,
                            time_zone => 'UTC' );

    $dt->set_time_zone('Australia/Sydney');

    is( $dt->hour, 1, 'A/S 2002: hour should be 1' );

    $dt->set_time_zone('UTC')->add( minutes => 1 )->set_time_zone('Australia/Sydney');

    is( $dt->hour, 3, 'A/S 2002: hour should be 3' );

}

# same tests without using UTC as intermediate
{
    my $dt = DateTime->new( year => 2002, month => 10, day => 27,
                            hour => 1, minute => 59,
                            time_zone => 'Australia/Sydney' );

    is( $dt->hour, 1, 'A/S 2002: hour should be 1' );

    $dt->add( minutes => 1 );

    is( $dt->hour, 3, 'A/S 2002: hour should be 3' );
}

# do same tests with future dates so more data is generated
{
    # Can't start at 1:59 or we get the _2nd_ 1:59 of that day (post-DST change)
    my $dt = DateTime->new( year => 2040, month => 3, day => 25,
                            hour => 1, minute => 59,
                            time_zone => 'Australia/Sydney' );

    $dt->add( hours => 1 );

    is( $dt->hour, 2, 'A/S 2040: hour should be 2' );

    $dt->add( minutes => 1 );

    is( $dt->hour, 2, 'A/S 2040: hour should still be 2' );
}

{
    my $dt = DateTime->new( year => 2040, month => 10, day => 28,
                            hour => 1, minute => 59,
                            time_zone => 'Australia/Sydney' );

    is( $dt->hour, 1, 'A/S 2040: hour should be 1' );

    $dt->add( minutes => 1 );

    is( $dt->hour, 3, 'A/S 2040: hour should be 3' );
}

# Rule	EU	1981	max	-	Mar	lastSun	 1:00u	1:00	S
# Rule	EU	1996	max	-	Oct	lastSun	 1:00u	0	-
{
    # one minute before change to standard time
    my $dt = DateTime->new( year => 1982, month => 3, day => 28,
                            hour => 0, minute => 59,
                            time_zone => 'UTC' );

    $dt->set_time_zone('Europe/Vienna');

    is( $dt->hour, 1, 'E/V 1982: hour should be 1' );

    $dt->set_time_zone('UTC')->add( minutes => 1 )->set_time_zone('Europe/Vienna');

    is( $dt->hour, 3, 'E/V 1982: hour should be 3' );
}

# same tests without using UTC as intermediate
{
    # wrapped in eval because if change data is buggy it can throw exception
    my $dt = DateTime->new( year => 1982, month => 3, day => 28,
                            hour => 1, minute => 59,
                            time_zone => 'Europe/Vienna' );

    is( $dt->hour, 1, 'E/V 1982: hour should be 1' );

    $dt->add( minutes => 1 );

    is( $dt->hour, 3, 'E/V 1982: hour should be 3' );
}

{
    # one minute before change to standard time
    my $dt = DateTime->new( year => 1997, month => 10, day => 26,
                            hour => 0, minute => 59,
                            time_zone => 'UTC' );

    $dt->set_time_zone('Europe/Vienna');

    is( $dt->hour, 2, 'E/V 1997: hour should be 2' );

    $dt->set_time_zone('UTC')->add( minutes => 1 )->set_time_zone('Europe/Vienna');

    is( $dt->hour, 2, 'E/V 1997: hour should still be 2' );

}

# same tests without using UTC as intermediate
{
    # can't be created directly because of overlap between changes
    my $dt = DateTime->new( year => 1997, month => 10, day => 26,
                            hour => 1, minute => 59,
                            time_zone => 'Europe/Vienna' );

    $dt->add( hours => 1 );

    is( $dt->hour, 2, 'E/V 1997: hour should be 2' );

    $dt->add( minutes => 1 );

    is( $dt->hour, 2, 'E/V 1997: hour should still be 2' );
}

# future
{
    my $dt = DateTime->new( year => 2040, month => 3, day => 25,
                            hour => 1, minute => 59,
                            time_zone => 'Europe/Vienna' );

    is( $dt->hour, 1, 'E/V 2040: hour should be 1' );

    $dt->add( minutes => 1 );

    is( $dt->hour, 3, 'E/V 2040: hour should be 3' );
}

{
    my $dt = DateTime->new( year => 2040, month => 10, day => 28,
                            hour => 1, minute => 59,
                            time_zone => 'Europe/Vienna' );

    $dt->add( hours => 1 );

    is( $dt->hour, 2, 'E/V 2040: hour should be 2' );

    $dt->add( minutes => 1 );

    is( $dt->hour, 2, 'E/V 2040: hour should still be 2' );
}

# Africa/Algiers has an observance that ends at 1977-10-21T00:00:00
# local time and a rule that starts at exactly the same time

# Rule	Algeria	1977	only	-	May	 6	 0:00	1:00	S
# Rule	Algeria	1977	only	-	Oct	21	 0:00	0	-
#
# 			0:00	Algeria	WE%sT	1977 Oct 21
# 			1:00	Algeria	CE%sT	1979 Oct 26
{
    my $dt = DateTime->new( year => 1977, month => 10, day => 20,
                            hour => 23, minute => 59,
                            time_zone => 'Africa/Algiers'
                          );

    is( $dt->time_zone_short_name, 'WEST', 'short name is WEST' );
    is( $dt->is_dst, 1, 'is dst' );

    # observance ends, new rule starts, net effect is same offset,
    # different short name, no longer is DST
    $dt->add( minutes => 1 );

    is( $dt->time_zone_short_name, 'CET', 'short name is CET' );
    is( $dt->is_dst, 0, 'is not dst' );
}

# Asia/Aqtau has an observance  that ends at 1995-09-24T00:00:00 local
# time, and a new rule that  starts one hour later!  The net effect is
# that right  before the end of  the observance, the  offset if +0600,
# then the observance  ends, the offset if +0500 for  1 hour, and then
# +0400.  Confused yet?

# Rule RussiaAsia	1993	max	-	Mar	lastSun	 2:00s	1:00	S
# Rule RussiaAsia	1993	1995	-	Sep	lastSun	 2:00s	0	-
# Rule RussiaAsia	1996	max	-	Oct	lastSun	 2:00s	0	-
#
# 			5:00 RussiaAsia	AQT%sT	1995 Sep lastSun # Aqtau Time
# 			4:00 RussiaAsia	AQT%sT
{
    my $dt = DateTime->new( year => 1995, month => 9, day => 23,
                            hour => 23, minute => 59,
                            time_zone => 'Asia/Aqtau'
                          );

    is( $dt->time_zone_short_name, 'AQTST', 'short name is AQTST' );
    is( $dt->offset, 3600 * 6, 'offset if +0600' );

    # observance ends, old rule still in effect, same short name,
    # different offset
    $dt->add( minutes => 1 );

    is( $dt->time_zone_short_name, 'AQTST', 'short name is AQTST' );
    is( $dt->offset, 3600 * 5, 'offset if +0500' );

    # rule ends, new name, new offset
    $dt->add( hours => 1 );

    is( $dt->time_zone_short_name, 'AQTT', 'short name is AQTT' );
    is( $dt->offset, 3600 * 4, 'offset if +0400' );
}
