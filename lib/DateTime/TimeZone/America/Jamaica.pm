# This file is auto-generated by the Perl DateTime Suite time zone
# code generator (0.08) This code generator comes with the
# DateTime::TimeZone module distribution in the tools/ directory

#
# Generated from /tmp/tdH5qujOqq/northamerica.  Olson data version 2022g
#
# Do not edit this file directly.
#
package DateTime::TimeZone::America::Jamaica;

use strict;
use warnings;
use namespace::autoclean;

our $VERSION = '2.58';

use Class::Singleton 1.03;
use DateTime::TimeZone;
use DateTime::TimeZone::OlsonDB;

@DateTime::TimeZone::America::Jamaica::ISA = ( 'Class::Singleton', 'DateTime::TimeZone' );

my $spans =
[
    [
DateTime::TimeZone::NEG_INFINITY, #    utc_start
59611180030, #      utc_end 1890-01-01 05:07:10 (Wed)
DateTime::TimeZone::NEG_INFINITY, #  local_start
59611161600, #    local_end 1890-01-01 00:00:00 (Wed)
-18430,
0,
'LMT',
    ],
    [
59611180030, #    utc_start 1890-01-01 05:07:10 (Wed)
60307996030, #      utc_end 1912-02-01 05:07:10 (Thu)
59611161600, #  local_start 1890-01-01 00:00:00 (Wed)
60307977600, #    local_end 1912-02-01 00:00:00 (Thu)
-18430,
0,
'KMT',
    ],
    [
60307996030, #    utc_start 1912-02-01 05:07:10 (Thu)
62262370800, #      utc_end 1974-01-06 07:00:00 (Sun)
60307978030, #  local_start 1912-02-01 00:07:10 (Thu)
62262352800, #    local_end 1974-01-06 02:00:00 (Sun)
-18000,
0,
'EST',
    ],
    [
62262370800, #    utc_start 1974-01-06 07:00:00 (Sun)
62287768800, #      utc_end 1974-10-27 06:00:00 (Sun)
62262356400, #  local_start 1974-01-06 03:00:00 (Sun)
62287754400, #    local_end 1974-10-27 02:00:00 (Sun)
-14400,
1,
'EDT',
    ],
    [
62287768800, #    utc_start 1974-10-27 06:00:00 (Sun)
62298054000, #      utc_end 1975-02-23 07:00:00 (Sun)
62287750800, #  local_start 1974-10-27 01:00:00 (Sun)
62298036000, #    local_end 1975-02-23 02:00:00 (Sun)
-18000,
0,
'EST',
    ],
    [
62298054000, #    utc_start 1975-02-23 07:00:00 (Sun)
62319218400, #      utc_end 1975-10-26 06:00:00 (Sun)
62298039600, #  local_start 1975-02-23 03:00:00 (Sun)
62319204000, #    local_end 1975-10-26 02:00:00 (Sun)
-14400,
1,
'EDT',
    ],
    [
62319218400, #    utc_start 1975-10-26 06:00:00 (Sun)
62334946800, #      utc_end 1976-04-25 07:00:00 (Sun)
62319200400, #  local_start 1975-10-26 01:00:00 (Sun)
62334928800, #    local_end 1976-04-25 02:00:00 (Sun)
-18000,
0,
'EST',
    ],
    [
62334946800, #    utc_start 1976-04-25 07:00:00 (Sun)
62351272800, #      utc_end 1976-10-31 06:00:00 (Sun)
62334932400, #  local_start 1976-04-25 03:00:00 (Sun)
62351258400, #    local_end 1976-10-31 02:00:00 (Sun)
-14400,
1,
'EDT',
    ],
    [
62351272800, #    utc_start 1976-10-31 06:00:00 (Sun)
62366396400, #      utc_end 1977-04-24 07:00:00 (Sun)
62351254800, #  local_start 1976-10-31 01:00:00 (Sun)
62366378400, #    local_end 1977-04-24 02:00:00 (Sun)
-18000,
0,
'EST',
    ],
    [
62366396400, #    utc_start 1977-04-24 07:00:00 (Sun)
62382722400, #      utc_end 1977-10-30 06:00:00 (Sun)
62366382000, #  local_start 1977-04-24 03:00:00 (Sun)
62382708000, #    local_end 1977-10-30 02:00:00 (Sun)
-14400,
1,
'EDT',
    ],
    [
62382722400, #    utc_start 1977-10-30 06:00:00 (Sun)
62398450800, #      utc_end 1978-04-30 07:00:00 (Sun)
62382704400, #  local_start 1977-10-30 01:00:00 (Sun)
62398432800, #    local_end 1978-04-30 02:00:00 (Sun)
-18000,
0,
'EST',
    ],
    [
62398450800, #    utc_start 1978-04-30 07:00:00 (Sun)
62414172000, #      utc_end 1978-10-29 06:00:00 (Sun)
62398436400, #  local_start 1978-04-30 03:00:00 (Sun)
62414157600, #    local_end 1978-10-29 02:00:00 (Sun)
-14400,
1,
'EDT',
    ],
    [
62414172000, #    utc_start 1978-10-29 06:00:00 (Sun)
62429900400, #      utc_end 1979-04-29 07:00:00 (Sun)
62414154000, #  local_start 1978-10-29 01:00:00 (Sun)
62429882400, #    local_end 1979-04-29 02:00:00 (Sun)
-18000,
0,
'EST',
    ],
    [
62429900400, #    utc_start 1979-04-29 07:00:00 (Sun)
62445621600, #      utc_end 1979-10-28 06:00:00 (Sun)
62429886000, #  local_start 1979-04-29 03:00:00 (Sun)
62445607200, #    local_end 1979-10-28 02:00:00 (Sun)
-14400,
1,
'EDT',
    ],
    [
62445621600, #    utc_start 1979-10-28 06:00:00 (Sun)
62461350000, #      utc_end 1980-04-27 07:00:00 (Sun)
62445603600, #  local_start 1979-10-28 01:00:00 (Sun)
62461332000, #    local_end 1980-04-27 02:00:00 (Sun)
-18000,
0,
'EST',
    ],
    [
62461350000, #    utc_start 1980-04-27 07:00:00 (Sun)
62477071200, #      utc_end 1980-10-26 06:00:00 (Sun)
62461335600, #  local_start 1980-04-27 03:00:00 (Sun)
62477056800, #    local_end 1980-10-26 02:00:00 (Sun)
-14400,
1,
'EDT',
    ],
    [
62477071200, #    utc_start 1980-10-26 06:00:00 (Sun)
62492799600, #      utc_end 1981-04-26 07:00:00 (Sun)
62477053200, #  local_start 1980-10-26 01:00:00 (Sun)
62492781600, #    local_end 1981-04-26 02:00:00 (Sun)
-18000,
0,
'EST',
    ],
    [
62492799600, #    utc_start 1981-04-26 07:00:00 (Sun)
62508520800, #      utc_end 1981-10-25 06:00:00 (Sun)
62492785200, #  local_start 1981-04-26 03:00:00 (Sun)
62508506400, #    local_end 1981-10-25 02:00:00 (Sun)
-14400,
1,
'EDT',
    ],
    [
62508520800, #    utc_start 1981-10-25 06:00:00 (Sun)
62524249200, #      utc_end 1982-04-25 07:00:00 (Sun)
62508502800, #  local_start 1981-10-25 01:00:00 (Sun)
62524231200, #    local_end 1982-04-25 02:00:00 (Sun)
-18000,
0,
'EST',
    ],
    [
62524249200, #    utc_start 1982-04-25 07:00:00 (Sun)
62540575200, #      utc_end 1982-10-31 06:00:00 (Sun)
62524234800, #  local_start 1982-04-25 03:00:00 (Sun)
62540560800, #    local_end 1982-10-31 02:00:00 (Sun)
-14400,
1,
'EDT',
    ],
    [
62540575200, #    utc_start 1982-10-31 06:00:00 (Sun)
62555698800, #      utc_end 1983-04-24 07:00:00 (Sun)
62540557200, #  local_start 1982-10-31 01:00:00 (Sun)
62555680800, #    local_end 1983-04-24 02:00:00 (Sun)
-18000,
0,
'EST',
    ],
    [
62555698800, #    utc_start 1983-04-24 07:00:00 (Sun)
62572024800, #      utc_end 1983-10-30 06:00:00 (Sun)
62555684400, #  local_start 1983-04-24 03:00:00 (Sun)
62572010400, #    local_end 1983-10-30 02:00:00 (Sun)
-14400,
1,
'EDT',
    ],
    [
62572024800, #    utc_start 1983-10-30 06:00:00 (Sun)
DateTime::TimeZone::INFINITY, #      utc_end
62572006800, #  local_start 1983-10-30 01:00:00 (Sun)
DateTime::TimeZone::INFINITY, #    local_end
-18000,
0,
'EST',
    ],
];

sub olson_version {'2022g'}

sub has_dst_changes {10}

sub _max_year {2032}

sub _new_instance {
    return shift->_init( @_, spans => $spans );
}



1;

