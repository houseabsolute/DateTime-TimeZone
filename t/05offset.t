#!/usr/bin/perl -w

use strict;

use DateTime::TimeZone;

use Test::More tests => 9;

is(DateTime::TimeZone::offset_as_string(0), "+0000",
    "offset_as_string does the right thing on 0");
is(DateTime::TimeZone::offset_as_string(3600), "+0100",
    "offset_as_string works on positive whole hours");
is(DateTime::TimeZone::offset_as_string(-3600), "-0100",
    "offset_as_string works on negative whole hours");
is(DateTime::TimeZone::offset_as_string(5400), "+0130",
    "offset_as_string works on positive half hours");
is(DateTime::TimeZone::offset_as_string(-5400), "-0130",
    "offset_as_string works on negative half hours");

is(DateTime::TimeZone::offset_as_string(20700), "+0545",
    "offset_as_string works on positive 15min zones");
is(DateTime::TimeZone::offset_as_string(-20700), "-0545",
    "offset_as_string works on negative 15min zones");

is(DateTime::TimeZone::offset_as_string(86400), "+0000",
    "offset_as_string rolls over properly on one full day of seconds");
is(DateTime::TimeZone::offset_as_string(86400 + 3600), "+0100",
    "offset_as_string rolls over properly on one day + 1 hour of seconds");

