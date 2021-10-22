# This file is auto-generated by the Perl DateTime Suite time zone
# code generator (0.08) This code generator comes with the
# DateTime::TimeZone module distribution in the tools/ directory

#
# Generated from /tmp/I058DLAWvC/australasia.  Olson data version 2021e
#
# Do not edit this file directly.
#
package DateTime::TimeZone::Pacific::Tongatapu;

use strict;
use warnings;
use namespace::autoclean;

our $VERSION = '2.51';

use Class::Singleton 1.03;
use DateTime::TimeZone;
use DateTime::TimeZone::OlsonDB;

@DateTime::TimeZone::Pacific::Tongatapu::ISA = ( 'Class::Singleton', 'DateTime::TimeZone' );

my $spans =
[
    [
DateTime::TimeZone::NEG_INFINITY, #    utc_start
61368493248, #      utc_end 1945-09-09 11:40:48 (Sun)
DateTime::TimeZone::NEG_INFINITY, #  local_start
61368537600, #    local_end 1945-09-10 00:00:00 (Mon)
44352,
0,
'LMT',
    ],
    [
61368493248, #    utc_start 1945-09-09 11:40:48 (Sun)
61851642000, #      utc_end 1960-12-31 11:40:00 (Sat)
61368537648, #  local_start 1945-09-10 00:00:48 (Mon)
61851686400, #    local_end 1961-01-01 00:00:00 (Sun)
44400,
0,
'+1220',
    ],
    [
61851642000, #    utc_start 1960-12-31 11:40:00 (Sat)
63050785200, #      utc_end 1998-12-31 11:00:00 (Thu)
61851688800, #  local_start 1961-01-01 00:40:00 (Sun)
63050832000, #    local_end 1999-01-01 00:00:00 (Fri)
46800,
0,
'+13',
    ],
    [
63050785200, #    utc_start 1998-12-31 11:00:00 (Thu)
63074898000, #      utc_end 1999-10-06 13:00:00 (Wed)
63050832000, #  local_start 1999-01-01 00:00:00 (Fri)
63074944800, #    local_end 1999-10-07 02:00:00 (Thu)
46800,
0,
'+13',
    ],
    [
63074898000, #    utc_start 1999-10-06 13:00:00 (Wed)
63089067600, #      utc_end 2000-03-18 13:00:00 (Sat)
63074948400, #  local_start 1999-10-07 03:00:00 (Thu)
63089118000, #    local_end 2000-03-19 03:00:00 (Sun)
50400,
1,
'+14',
    ],
    [
63089067600, #    utc_start 2000-03-18 13:00:00 (Sat)
63109026000, #      utc_end 2000-11-04 13:00:00 (Sat)
63089114400, #  local_start 2000-03-19 02:00:00 (Sun)
63109072800, #    local_end 2000-11-05 02:00:00 (Sun)
46800,
0,
'+13',
    ],
    [
63109026000, #    utc_start 2000-11-04 13:00:00 (Sat)
63116280000, #      utc_end 2001-01-27 12:00:00 (Sat)
63109076400, #  local_start 2000-11-05 03:00:00 (Sun)
63116330400, #    local_end 2001-01-28 02:00:00 (Sun)
50400,
1,
'+14',
    ],
    [
63116280000, #    utc_start 2001-01-27 12:00:00 (Sat)
63140475600, #      utc_end 2001-11-03 13:00:00 (Sat)
63116326800, #  local_start 2001-01-28 01:00:00 (Sun)
63140522400, #    local_end 2001-11-04 02:00:00 (Sun)
46800,
0,
'+13',
    ],
    [
63140475600, #    utc_start 2001-11-03 13:00:00 (Sat)
63147729600, #      utc_end 2002-01-26 12:00:00 (Sat)
63140526000, #  local_start 2001-11-04 03:00:00 (Sun)
63147780000, #    local_end 2002-01-27 02:00:00 (Sun)
50400,
1,
'+14',
    ],
    [
63147729600, #    utc_start 2002-01-26 12:00:00 (Sat)
63614034000, #      utc_end 2016-11-05 13:00:00 (Sat)
63147776400, #  local_start 2002-01-27 01:00:00 (Sun)
63614080800, #    local_end 2016-11-06 02:00:00 (Sun)
46800,
0,
'+13',
    ],
    [
63614034000, #    utc_start 2016-11-05 13:00:00 (Sat)
63620082000, #      utc_end 2017-01-14 13:00:00 (Sat)
63614084400, #  local_start 2016-11-06 03:00:00 (Sun)
63620132400, #    local_end 2017-01-15 03:00:00 (Sun)
50400,
1,
'+14',
    ],
    [
63620082000, #    utc_start 2017-01-14 13:00:00 (Sat)
DateTime::TimeZone::INFINITY, #      utc_end
63620128800, #  local_start 2017-01-15 02:00:00 (Sun)
DateTime::TimeZone::INFINITY, #    local_end
46800,
0,
'+13',
    ],
];

sub olson_version {'2021e'}

sub has_dst_changes {4}

sub _max_year {2031}

sub _new_instance {
    return shift->_init( @_, spans => $spans );
}



1;

