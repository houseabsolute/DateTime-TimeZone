# This file is auto-generated by the Perl DateTime Suite time zone
# code generator (0.08) This code generator comes with the
# DateTime::TimeZone module distribution in the tools/ directory

#
# Generated from /tmp/yoUeXA_NPK/africa.  Olson data version 2021c
#
# Do not edit this file directly.
#
package DateTime::TimeZone::Indian::Mauritius;

use strict;
use warnings;
use namespace::autoclean;

our $VERSION = '2.50';

use Class::Singleton 1.03;
use DateTime::TimeZone;
use DateTime::TimeZone::OlsonDB;

@DateTime::TimeZone::Indian::Mauritius::ISA = ( 'Class::Singleton', 'DateTime::TimeZone' );

my $spans =
[
    [
DateTime::TimeZone::NEG_INFINITY, #    utc_start
60147519000, #      utc_end 1906-12-31 20:10:00 (Mon)
DateTime::TimeZone::NEG_INFINITY, #  local_start
60147532800, #    local_end 1907-01-01 00:00:00 (Tue)
13800,
0,
'LMT',
    ],
    [
60147519000, #    utc_start 1906-12-31 20:10:00 (Mon)
62538724800, #      utc_end 1982-10-09 20:00:00 (Sat)
60147533400, #  local_start 1907-01-01 00:10:00 (Tue)
62538739200, #    local_end 1982-10-10 00:00:00 (Sun)
14400,
0,
'+04',
    ],
    [
62538724800, #    utc_start 1982-10-09 20:00:00 (Sat)
62552718000, #      utc_end 1983-03-20 19:00:00 (Sun)
62538742800, #  local_start 1982-10-10 01:00:00 (Sun)
62552736000, #    local_end 1983-03-21 00:00:00 (Mon)
18000,
1,
'+05',
    ],
    [
62552718000, #    utc_start 1983-03-20 19:00:00 (Sun)
63360655200, #      utc_end 2008-10-25 22:00:00 (Sat)
62552732400, #  local_start 1983-03-20 23:00:00 (Sun)
63360669600, #    local_end 2008-10-26 02:00:00 (Sun)
14400,
0,
'+04',
    ],
    [
63360655200, #    utc_start 2008-10-25 22:00:00 (Sat)
63373957200, #      utc_end 2009-03-28 21:00:00 (Sat)
63360673200, #  local_start 2008-10-26 03:00:00 (Sun)
63373975200, #    local_end 2009-03-29 02:00:00 (Sun)
18000,
1,
'+05',
    ],
    [
63373957200, #    utc_start 2009-03-28 21:00:00 (Sat)
DateTime::TimeZone::INFINITY, #      utc_end
63373971600, #  local_start 2009-03-29 01:00:00 (Sun)
DateTime::TimeZone::INFINITY, #    local_end
14400,
0,
'+04',
    ],
];

sub olson_version {'2021c'}

sub has_dst_changes {2}

sub _max_year {2031}

sub _new_instance {
    return shift->_init( @_, spans => $spans );
}



1;

