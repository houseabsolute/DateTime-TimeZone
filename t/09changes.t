#!/usr/bin/perl -w

use strict;

use File::Spec;
use Test::More;

use lib File::Spec->catdir( File::Spec->curdir, 't' );

BEGIN { require 'check_datetime_version.pl' }

plan tests => 16;

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
                            hour => 14, minute => 59,
                            time_zone => 'UTC' );

    $dt->set_time_zone('Australia/Sydney');

    is( $dt->hour, 1, 'hour should be 2' );

    $dt->set_time_zone('UTC')->add( minutes => 1 )->set_time_zone('Australia/Sydney');

    is( $dt->hour, 1, 'hour should still be 2' );
}

# same tests without using UTC as intermediate
{
    # Can't start at 1:59 or we get the _2nd_ 1:59 of that day (post-DST change)
    my $dt = DateTime->new( year => 1997, month => 3, day => 30,
                            hour => 0, minute => 59,
                            time_zone => 'Australia/Sydney' );

    $dt->add( hours => 1 );

    is( $dt->hour, 1, 'hour should be 2' );

    $dt->add( minutes => 1 );

    is( $dt->hour, 1, 'hour should still be 2' );
}


{
    # one minute before change to standard time
    my $dt = DateTime->new( year => 2002, month => 10, day => 26,
                            hour => 15, minute => 59,
                            time_zone => 'UTC' );

    $dt->set_time_zone('Australia/Sydney');

    is( $dt->hour, 1, 'hour should be 1' );

    $dt->set_time_zone('UTC')->add( minutes => 1 )->set_time_zone('Australia/Sydney');

    is( $dt->hour, 3, 'hour should be 3' );

}

# same tests without using UTC as intermediate
{
    my $dt = DateTime->new( year => 2002, month => 10, day => 27,
                            hour => 1, minute => 59,
                            time_zone => 'Australia/Sydney' );

    is( $dt->hour, 1, 'hour should be 1' );

    $dt->add( minutes => 1 );

    is( $dt->hour, 3, 'hour should be 3' );
}


# Rule	EU	1981	max	-	Mar	lastSun	 1:00u	1:00	S
# Rule	EU	1996	max	-	Oct	lastSun	 1:00u	0	-
{
    # one minute before change to standard time
    my $dt = DateTime->new( year => 1982, month => 3, day => 28,
                            hour => 0, minute => 59,
                            time_zone => 'UTC' );

    $dt->set_time_zone('Europe/Vienna');

    is( $dt->hour, 1, 'hour should be 1' );

    $dt->set_time_zone('UTC')->add( minutes => 1 )->set_time_zone('Europe/Vienna');

    is( $dt->hour, 3, 'hour should be 3' );
}

# same tests without using UTC as intermediate
{
    # wrapped in eval because if change data is buggy it can throw exception
    my $dt =
        eval { DateTime->new( year => 1982, month => 3, day => 28,
                              hour => 1, minute => 59,
                              time_zone => 'Europe/Vienna' ) };

    if ($@)
    {
        ok( 0, "1982-03-28T01:59:00: $@" ) for 1..2;
    }
    else
    {
        is( $dt->hour, 1, 'hour should be 1' );

        $dt->add( minutes => 1 );

        is( $dt->hour, 3, 'hour should be 3' );
    }
}

{
    # one minute before change to standard time
    my $dt = DateTime->new( year => 1997, month => 10, day => 26,
                            hour => 0, minute => 59,
                            time_zone => 'UTC' );

    $dt->set_time_zone('Europe/Vienna');

    is( $dt->hour, 2, 'hour should be 2' );

    $dt->set_time_zone('UTC')->add( minutes => 1 )->set_time_zone('Europe/Vienna');

    is( $dt->hour, 2, 'hour should still be 2' );

}

# same tests without using UTC as intermediate
{
    my $dt = DateTime->new( year => 1997, month => 10, day => 26,
                            hour => 2, minute => 59,
                            time_zone => 'Europe/Vienna' );

    is( $dt->hour, 2, 'hour should be 2' );

    $dt->add( minutes => 1 );

    is( $dt->hour, 2, 'hour should still be 2' );
}
