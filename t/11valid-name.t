#!/usr/bin/perl -w

use strict;

use DateTime::TimeZone;

use Test::More tests => 11;

foreach ( qw( America/Chicago
              UTC
              US/Eastern
              Europe/Paris
              Etc/Zulu
              Pacific/Midway
            ) )
{
    ok( DateTime::TimeZone->is_valid_name($_),
        "$_ is a valid timezone name" );
}

foreach ( qw( America/Hell
              FooBar
              adhdsjghs;dgohas098huqjy4ily
              EST
              1000:0001
            ) )
{
    ok( ! DateTime::TimeZone->is_valid_name($_),
        "$_ is not a valid timezone name" );
}
