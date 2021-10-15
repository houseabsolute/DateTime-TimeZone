# This file is auto-generated by the Perl DateTime Suite time zone
# code generator (0.08) This code generator comes with the
# DateTime::TimeZone module distribution in the tools/ directory

#
# Generated from /tmp/t4I0HCM0fO/southamerica.  Olson data version 2021d
#
# Do not edit this file directly.
#
package DateTime::TimeZone::America::Bogota;

use strict;
use warnings;
use namespace::autoclean;

our $VERSION = '2.51';

use Class::Singleton 1.03;
use DateTime::TimeZone;
use DateTime::TimeZone::OlsonDB;

@DateTime::TimeZone::America::Bogota::ISA = ( 'Class::Singleton', 'DateTime::TimeZone' );

my $spans =
[
    [
DateTime::TimeZone::NEG_INFINITY, #    utc_start
59428011376, #      utc_end 1884-03-13 04:56:16 (Thu)
DateTime::TimeZone::NEG_INFINITY, #  local_start
59427993600, #    local_end 1884-03-13 00:00:00 (Thu)
-17776,
0,
'LMT',
    ],
    [
59428011376, #    utc_start 1884-03-13 04:56:16 (Thu)
60396641776, #      utc_end 1914-11-23 04:56:16 (Mon)
59427993600, #  local_start 1884-03-13 00:00:00 (Thu)
60396624000, #    local_end 1914-11-23 00:00:00 (Mon)
-17776,
0,
'BMT',
    ],
    [
60396641776, #    utc_start 1914-11-23 04:56:16 (Mon)
62840552400, #      utc_end 1992-05-03 05:00:00 (Sun)
60396623776, #  local_start 1914-11-22 23:56:16 (Sun)
62840534400, #    local_end 1992-05-03 00:00:00 (Sun)
-18000,
0,
'-05',
    ],
    [
62840552400, #    utc_start 1992-05-03 05:00:00 (Sun)
62869579200, #      utc_end 1993-04-04 04:00:00 (Sun)
62840538000, #  local_start 1992-05-03 01:00:00 (Sun)
62869564800, #    local_end 1993-04-04 00:00:00 (Sun)
-14400,
1,
'-04',
    ],
    [
62869579200, #    utc_start 1993-04-04 04:00:00 (Sun)
DateTime::TimeZone::INFINITY, #      utc_end
62869561200, #  local_start 1993-04-03 23:00:00 (Sat)
DateTime::TimeZone::INFINITY, #    local_end
-18000,
0,
'-05',
    ],
];

sub olson_version {'2021d'}

sub has_dst_changes {1}

sub _max_year {2031}

sub _new_instance {
    return shift->_init( @_, spans => $spans );
}



1;

