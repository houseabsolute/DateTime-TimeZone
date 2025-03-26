# This file is auto-generated by the Perl DateTime Suite time zone
# code generator (0.08) This code generator comes with the
# DateTime::TimeZone module distribution in the tools/ directory

#
# Generated from /tmp/nUm_LjpJ6O/northamerica.  Olson data version 2025b
#
# Do not edit this file directly.
#
package DateTime::TimeZone::America::Hermosillo;

use strict;
use warnings;
use namespace::autoclean;

our $VERSION = '2.66';

use Class::Singleton 1.03;
use DateTime::TimeZone;
use DateTime::TimeZone::OlsonDB;

@DateTime::TimeZone::America::Hermosillo::ISA = ( 'Class::Singleton', 'DateTime::TimeZone' );

my $spans =
[
    [
DateTime::TimeZone::NEG_INFINITY, #    utc_start
60620943600, #      utc_end 1922-01-01 07:00:00 (Sun)
DateTime::TimeZone::NEG_INFINITY, #  local_start
60620916968, #    local_end 1921-12-31 23:36:08 (Sat)
-26632,
0,
'LMT',
    ],
    [
60620943600, #    utc_start 1922-01-01 07:00:00 (Sun)
60792534000, #      utc_end 1927-06-10 07:00:00 (Fri)
60620918400, #  local_start 1922-01-01 00:00:00 (Sun)
60792508800, #    local_end 1927-06-10 00:00:00 (Fri)
-25200,
0,
'MST',
    ],
    [
60792534000, #    utc_start 1927-06-10 07:00:00 (Fri)
60900876000, #      utc_end 1930-11-15 06:00:00 (Sat)
60792512400, #  local_start 1927-06-10 01:00:00 (Fri)
60900854400, #    local_end 1930-11-15 00:00:00 (Sat)
-21600,
0,
'CST',
    ],
    [
60900876000, #    utc_start 1930-11-15 06:00:00 (Sat)
60915222000, #      utc_end 1931-04-30 07:00:00 (Thu)
60900850800, #  local_start 1930-11-14 23:00:00 (Fri)
60915196800, #    local_end 1931-04-30 00:00:00 (Thu)
-25200,
0,
'MST',
    ],
    [
60915222000, #    utc_start 1931-04-30 07:00:00 (Thu)
60928524000, #      utc_end 1931-10-01 06:00:00 (Thu)
60915200400, #  local_start 1931-04-30 01:00:00 (Thu)
60928502400, #    local_end 1931-10-01 00:00:00 (Thu)
-21600,
1,
'MDT',
    ],
    [
60928524000, #    utc_start 1931-10-01 06:00:00 (Thu)
60944338800, #      utc_end 1932-04-01 07:00:00 (Fri)
60928498800, #  local_start 1931-09-30 23:00:00 (Wed)
60944313600, #    local_end 1932-04-01 00:00:00 (Fri)
-25200,
0,
'MST',
    ],
    [
60944338800, #    utc_start 1932-04-01 07:00:00 (Fri)
61261855200, #      utc_end 1942-04-24 06:00:00 (Fri)
60944317200, #  local_start 1932-04-01 01:00:00 (Fri)
61261833600, #    local_end 1942-04-24 00:00:00 (Fri)
-21600,
0,
'CST',
    ],
    [
61261855200, #    utc_start 1942-04-24 06:00:00 (Fri)
62964550800, #      utc_end 1996-04-07 09:00:00 (Sun)
61261830000, #  local_start 1942-04-23 23:00:00 (Thu)
62964525600, #    local_end 1996-04-07 02:00:00 (Sun)
-25200,
0,
'MST',
    ],
    [
62964550800, #    utc_start 1996-04-07 09:00:00 (Sun)
62982086400, #      utc_end 1996-10-27 08:00:00 (Sun)
62964529200, #  local_start 1996-04-07 03:00:00 (Sun)
62982064800, #    local_end 1996-10-27 02:00:00 (Sun)
-21600,
1,
'MDT',
    ],
    [
62982086400, #    utc_start 1996-10-27 08:00:00 (Sun)
62996000400, #      utc_end 1997-04-06 09:00:00 (Sun)
62982061200, #  local_start 1996-10-27 01:00:00 (Sun)
62995975200, #    local_end 1997-04-06 02:00:00 (Sun)
-25200,
0,
'MST',
    ],
    [
62996000400, #    utc_start 1997-04-06 09:00:00 (Sun)
63013536000, #      utc_end 1997-10-26 08:00:00 (Sun)
62995978800, #  local_start 1997-04-06 03:00:00 (Sun)
63013514400, #    local_end 1997-10-26 02:00:00 (Sun)
-21600,
1,
'MDT',
    ],
    [
63013536000, #    utc_start 1997-10-26 08:00:00 (Sun)
63027450000, #      utc_end 1998-04-05 09:00:00 (Sun)
63013510800, #  local_start 1997-10-26 01:00:00 (Sun)
63027424800, #    local_end 1998-04-05 02:00:00 (Sun)
-25200,
0,
'MST',
    ],
    [
63027450000, #    utc_start 1998-04-05 09:00:00 (Sun)
63044985600, #      utc_end 1998-10-25 08:00:00 (Sun)
63027428400, #  local_start 1998-04-05 03:00:00 (Sun)
63044964000, #    local_end 1998-10-25 02:00:00 (Sun)
-21600,
1,
'MDT',
    ],
    [
63044985600, #    utc_start 1998-10-25 08:00:00 (Sun)
DateTime::TimeZone::INFINITY, #      utc_end
63044960400, #  local_start 1998-10-25 01:00:00 (Sun)
DateTime::TimeZone::INFINITY, #    local_end
-25200,
0,
'MST',
    ],
];

sub olson_version {'2025b'}

sub has_dst_changes {4}

sub _max_year {2035}

sub _new_instance {
    return shift->_init( @_, spans => $spans );
}



1;

