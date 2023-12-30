# This file is auto-generated by the Perl DateTime Suite time zone
# code generator (0.08) This code generator comes with the
# DateTime::TimeZone module distribution in the tools/ directory

#
# Generated from /tmp/x2A19lO5Xi/asia.  Olson data version 2023d
#
# Do not edit this file directly.
#
package DateTime::TimeZone::Asia::Colombo;

use strict;
use warnings;
use namespace::autoclean;

our $VERSION = '2.62';

use Class::Singleton 1.03;
use DateTime::TimeZone;
use DateTime::TimeZone::OlsonDB;

@DateTime::TimeZone::Asia::Colombo::ISA = ( 'Class::Singleton', 'DateTime::TimeZone' );

my $spans =
[
    [
DateTime::TimeZone::NEG_INFINITY, #    utc_start
59295523236, #      utc_end 1879-12-31 18:40:36 (Wed)
DateTime::TimeZone::NEG_INFINITY, #  local_start
59295542400, #    local_end 1880-01-01 00:00:00 (Thu)
19164,
0,
'LMT',
    ],
    [
59295523236, #    utc_start 1879-12-31 18:40:36 (Wed)
60115977628, #      utc_end 1905-12-31 18:40:28 (Sun)
59295542408, #  local_start 1880-01-01 00:00:08 (Thu)
60115996800, #    local_end 1906-01-01 00:00:00 (Mon)
19172,
0,
'MMT',
    ],
    [
60115977628, #    utc_start 1905-12-31 18:40:28 (Sun)
61252396200, #      utc_end 1942-01-04 18:30:00 (Sun)
60115997428, #  local_start 1906-01-01 00:10:28 (Mon)
61252416000, #    local_end 1942-01-05 00:00:00 (Mon)
19800,
0,
'+0530',
    ],
    [
61252396200, #    utc_start 1942-01-04 18:30:00 (Sun)
61273044000, #      utc_end 1942-08-31 18:00:00 (Mon)
61252417800, #  local_start 1942-01-05 00:30:00 (Mon)
61273065600, #    local_end 1942-09-01 00:00:00 (Tue)
21600,
1,
'+06',
    ],
    [
61273044000, #    utc_start 1942-08-31 18:00:00 (Mon)
61371631800, #      utc_end 1945-10-15 19:30:00 (Mon)
61273067400, #  local_start 1942-09-01 00:30:00 (Tue)
61371655200, #    local_end 1945-10-16 02:00:00 (Tue)
23400,
1,
'+0630',
    ],
    [
61371631800, #    utc_start 1945-10-15 19:30:00 (Mon)
62968645800, #      utc_end 1996-05-24 18:30:00 (Fri)
61371651600, #  local_start 1945-10-16 01:00:00 (Tue)
62968665600, #    local_end 1996-05-25 00:00:00 (Sat)
19800,
0,
'+0530',
    ],
    [
62968645800, #    utc_start 1996-05-24 18:30:00 (Fri)
62981949600, #      utc_end 1996-10-25 18:00:00 (Fri)
62968669200, #  local_start 1996-05-25 01:00:00 (Sat)
62981973000, #    local_end 1996-10-26 00:30:00 (Sat)
23400,
0,
'+0630',
    ],
    [
62981949600, #    utc_start 1996-10-25 18:00:00 (Fri)
63280722600, #      utc_end 2006-04-14 18:30:00 (Fri)
62981971200, #  local_start 1996-10-26 00:00:00 (Sat)
63280744200, #    local_end 2006-04-15 00:30:00 (Sat)
21600,
0,
'+06',
    ],
    [
63280722600, #    utc_start 2006-04-14 18:30:00 (Fri)
DateTime::TimeZone::INFINITY, #      utc_end
63280742400, #  local_start 2006-04-15 00:00:00 (Sat)
DateTime::TimeZone::INFINITY, #    local_end
19800,
0,
'+0530',
    ],
];

sub olson_version {'2023d'}

sub has_dst_changes {2}

sub _max_year {2033}

sub _new_instance {
    return shift->_init( @_, spans => $spans );
}



1;

