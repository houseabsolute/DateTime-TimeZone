# This file is auto-generated by the Perl DateTime Suite time zone
# code generator (0.08) This code generator comes with the
# DateTime::TimeZone module distribution in the tools/ directory

#
# Generated from /tmp/nUm_LjpJ6O/southamerica.  Olson data version 2025b
#
# Do not edit this file directly.
#
package DateTime::TimeZone::America::Noronha;

use strict;
use warnings;
use namespace::autoclean;

our $VERSION = '2.66';

use Class::Singleton 1.03;
use DateTime::TimeZone;
use DateTime::TimeZone::OlsonDB;

@DateTime::TimeZone::America::Noronha::ISA = ( 'Class::Singleton', 'DateTime::TimeZone' );

my $spans =
[
    [
DateTime::TimeZone::NEG_INFINITY, #    utc_start
60368465380, #      utc_end 1914-01-01 02:09:40 (Thu)
DateTime::TimeZone::NEG_INFINITY, #  local_start
60368457600, #    local_end 1914-01-01 00:00:00 (Thu)
-7780,
0,
'LMT',
    ],
    [
60368465380, #    utc_start 1914-01-01 02:09:40 (Thu)
60928722000, #      utc_end 1931-10-03 13:00:00 (Sat)
60368458180, #  local_start 1914-01-01 00:09:40 (Thu)
60928714800, #    local_end 1931-10-03 11:00:00 (Sat)
-7200,
0,
'-02',
    ],
    [
60928722000, #    utc_start 1931-10-03 13:00:00 (Sat)
60944317200, #      utc_end 1932-04-01 01:00:00 (Fri)
60928718400, #  local_start 1931-10-03 12:00:00 (Sat)
60944313600, #    local_end 1932-04-01 00:00:00 (Fri)
-3600,
1,
'-01',
    ],
    [
60944317200, #    utc_start 1932-04-01 01:00:00 (Fri)
60960304800, #      utc_end 1932-10-03 02:00:00 (Mon)
60944310000, #  local_start 1932-03-31 23:00:00 (Thu)
60960297600, #    local_end 1932-10-03 00:00:00 (Mon)
-7200,
0,
'-02',
    ],
    [
60960304800, #    utc_start 1932-10-03 02:00:00 (Mon)
60975853200, #      utc_end 1933-04-01 01:00:00 (Sat)
60960301200, #  local_start 1932-10-03 01:00:00 (Mon)
60975849600, #    local_end 1933-04-01 00:00:00 (Sat)
-3600,
1,
'-01',
    ],
    [
60975853200, #    utc_start 1933-04-01 01:00:00 (Sat)
61501860000, #      utc_end 1949-12-01 02:00:00 (Thu)
60975846000, #  local_start 1933-03-31 23:00:00 (Fri)
61501852800, #    local_end 1949-12-01 00:00:00 (Thu)
-7200,
0,
'-02',
    ],
    [
61501860000, #    utc_start 1949-12-01 02:00:00 (Thu)
61513610400, #      utc_end 1950-04-16 02:00:00 (Sun)
61501856400, #  local_start 1949-12-01 01:00:00 (Thu)
61513606800, #    local_end 1950-04-16 01:00:00 (Sun)
-3600,
1,
'-01',
    ],
    [
61513610400, #    utc_start 1950-04-16 02:00:00 (Sun)
61533396000, #      utc_end 1950-12-01 02:00:00 (Fri)
61513603200, #  local_start 1950-04-16 00:00:00 (Sun)
61533388800, #    local_end 1950-12-01 00:00:00 (Fri)
-7200,
0,
'-02',
    ],
    [
61533396000, #    utc_start 1950-12-01 02:00:00 (Fri)
61543846800, #      utc_end 1951-04-01 01:00:00 (Sun)
61533392400, #  local_start 1950-12-01 01:00:00 (Fri)
61543843200, #    local_end 1951-04-01 00:00:00 (Sun)
-3600,
1,
'-01',
    ],
    [
61543846800, #    utc_start 1951-04-01 01:00:00 (Sun)
61564932000, #      utc_end 1951-12-01 02:00:00 (Sat)
61543839600, #  local_start 1951-03-31 23:00:00 (Sat)
61564924800, #    local_end 1951-12-01 00:00:00 (Sat)
-7200,
0,
'-02',
    ],
    [
61564932000, #    utc_start 1951-12-01 02:00:00 (Sat)
61575469200, #      utc_end 1952-04-01 01:00:00 (Tue)
61564928400, #  local_start 1951-12-01 01:00:00 (Sat)
61575465600, #    local_end 1952-04-01 00:00:00 (Tue)
-3600,
1,
'-01',
    ],
    [
61575469200, #    utc_start 1952-04-01 01:00:00 (Tue)
61596554400, #      utc_end 1952-12-01 02:00:00 (Mon)
61575462000, #  local_start 1952-03-31 23:00:00 (Mon)
61596547200, #    local_end 1952-12-01 00:00:00 (Mon)
-7200,
0,
'-02',
    ],
    [
61596554400, #    utc_start 1952-12-01 02:00:00 (Mon)
61604326800, #      utc_end 1953-03-01 01:00:00 (Sun)
61596550800, #  local_start 1952-12-01 01:00:00 (Mon)
61604323200, #    local_end 1953-03-01 00:00:00 (Sun)
-3600,
1,
'-01',
    ],
    [
61604326800, #    utc_start 1953-03-01 01:00:00 (Sun)
61944314400, #      utc_end 1963-12-09 02:00:00 (Mon)
61604319600, #  local_start 1953-02-28 23:00:00 (Sat)
61944307200, #    local_end 1963-12-09 00:00:00 (Mon)
-7200,
0,
'-02',
    ],
    [
61944314400, #    utc_start 1963-12-09 02:00:00 (Mon)
61951482000, #      utc_end 1964-03-01 01:00:00 (Sun)
61944310800, #  local_start 1963-12-09 01:00:00 (Mon)
61951478400, #    local_end 1964-03-01 00:00:00 (Sun)
-3600,
1,
'-01',
    ],
    [
61951482000, #    utc_start 1964-03-01 01:00:00 (Sun)
61980516000, #      utc_end 1965-01-31 02:00:00 (Sun)
61951474800, #  local_start 1964-02-29 23:00:00 (Sat)
61980508800, #    local_end 1965-01-31 00:00:00 (Sun)
-7200,
0,
'-02',
    ],
    [
61980516000, #    utc_start 1965-01-31 02:00:00 (Sun)
61985610000, #      utc_end 1965-03-31 01:00:00 (Wed)
61980512400, #  local_start 1965-01-31 01:00:00 (Sun)
61985606400, #    local_end 1965-03-31 00:00:00 (Wed)
-3600,
1,
'-01',
    ],
    [
61985610000, #    utc_start 1965-03-31 01:00:00 (Wed)
62006781600, #      utc_end 1965-12-01 02:00:00 (Wed)
61985602800, #  local_start 1965-03-30 23:00:00 (Tue)
62006774400, #    local_end 1965-12-01 00:00:00 (Wed)
-7200,
0,
'-02',
    ],
    [
62006781600, #    utc_start 1965-12-01 02:00:00 (Wed)
62014554000, #      utc_end 1966-03-01 01:00:00 (Tue)
62006778000, #  local_start 1965-12-01 01:00:00 (Wed)
62014550400, #    local_end 1966-03-01 00:00:00 (Tue)
-3600,
1,
'-01',
    ],
    [
62014554000, #    utc_start 1966-03-01 01:00:00 (Tue)
62035725600, #      utc_end 1966-11-01 02:00:00 (Tue)
62014546800, #  local_start 1966-02-28 23:00:00 (Mon)
62035718400, #    local_end 1966-11-01 00:00:00 (Tue)
-7200,
0,
'-02',
    ],
    [
62035725600, #    utc_start 1966-11-01 02:00:00 (Tue)
62046090000, #      utc_end 1967-03-01 01:00:00 (Wed)
62035722000, #  local_start 1966-11-01 01:00:00 (Tue)
62046086400, #    local_end 1967-03-01 00:00:00 (Wed)
-3600,
1,
'-01',
    ],
    [
62046090000, #    utc_start 1967-03-01 01:00:00 (Wed)
62067261600, #      utc_end 1967-11-01 02:00:00 (Wed)
62046082800, #  local_start 1967-02-28 23:00:00 (Tue)
62067254400, #    local_end 1967-11-01 00:00:00 (Wed)
-7200,
0,
'-02',
    ],
    [
62067261600, #    utc_start 1967-11-01 02:00:00 (Wed)
62077712400, #      utc_end 1968-03-01 01:00:00 (Fri)
62067258000, #  local_start 1967-11-01 01:00:00 (Wed)
62077708800, #    local_end 1968-03-01 00:00:00 (Fri)
-3600,
1,
'-01',
    ],
    [
62077712400, #    utc_start 1968-03-01 01:00:00 (Fri)
62635428000, #      utc_end 1985-11-02 02:00:00 (Sat)
62077705200, #  local_start 1968-02-29 23:00:00 (Thu)
62635420800, #    local_end 1985-11-02 00:00:00 (Sat)
-7200,
0,
'-02',
    ],
    [
62635428000, #    utc_start 1985-11-02 02:00:00 (Sat)
62646915600, #      utc_end 1986-03-15 01:00:00 (Sat)
62635424400, #  local_start 1985-11-02 01:00:00 (Sat)
62646912000, #    local_end 1986-03-15 00:00:00 (Sat)
-3600,
1,
'-01',
    ],
    [
62646915600, #    utc_start 1986-03-15 01:00:00 (Sat)
62666272800, #      utc_end 1986-10-25 02:00:00 (Sat)
62646908400, #  local_start 1986-03-14 23:00:00 (Fri)
62666265600, #    local_end 1986-10-25 00:00:00 (Sat)
-7200,
0,
'-02',
    ],
    [
62666272800, #    utc_start 1986-10-25 02:00:00 (Sat)
62675946000, #      utc_end 1987-02-14 01:00:00 (Sat)
62666269200, #  local_start 1986-10-25 01:00:00 (Sat)
62675942400, #    local_end 1987-02-14 00:00:00 (Sat)
-3600,
1,
'-01',
    ],
    [
62675946000, #    utc_start 1987-02-14 01:00:00 (Sat)
62697808800, #      utc_end 1987-10-25 02:00:00 (Sun)
62675938800, #  local_start 1987-02-13 23:00:00 (Fri)
62697801600, #    local_end 1987-10-25 00:00:00 (Sun)
-7200,
0,
'-02',
    ],
    [
62697808800, #    utc_start 1987-10-25 02:00:00 (Sun)
62706877200, #      utc_end 1988-02-07 01:00:00 (Sun)
62697805200, #  local_start 1987-10-25 01:00:00 (Sun)
62706873600, #    local_end 1988-02-07 00:00:00 (Sun)
-3600,
1,
'-01',
    ],
    [
62706877200, #    utc_start 1988-02-07 01:00:00 (Sun)
62728653600, #      utc_end 1988-10-16 02:00:00 (Sun)
62706870000, #  local_start 1988-02-06 23:00:00 (Sat)
62728646400, #    local_end 1988-10-16 00:00:00 (Sun)
-7200,
0,
'-02',
    ],
    [
62728653600, #    utc_start 1988-10-16 02:00:00 (Sun)
62737722000, #      utc_end 1989-01-29 01:00:00 (Sun)
62728650000, #  local_start 1988-10-16 01:00:00 (Sun)
62737718400, #    local_end 1989-01-29 00:00:00 (Sun)
-3600,
1,
'-01',
    ],
    [
62737722000, #    utc_start 1989-01-29 01:00:00 (Sun)
62760103200, #      utc_end 1989-10-15 02:00:00 (Sun)
62737714800, #  local_start 1989-01-28 23:00:00 (Sat)
62760096000, #    local_end 1989-10-15 00:00:00 (Sun)
-7200,
0,
'-02',
    ],
    [
62760103200, #    utc_start 1989-10-15 02:00:00 (Sun)
62770381200, #      utc_end 1990-02-11 01:00:00 (Sun)
62760099600, #  local_start 1989-10-15 01:00:00 (Sun)
62770377600, #    local_end 1990-02-11 00:00:00 (Sun)
-3600,
1,
'-01',
    ],
    [
62770381200, #    utc_start 1990-02-11 01:00:00 (Sun)
63074599200, #      utc_end 1999-10-03 02:00:00 (Sun)
62770374000, #  local_start 1990-02-10 23:00:00 (Sat)
63074592000, #    local_end 1999-10-03 00:00:00 (Sun)
-7200,
0,
'-02',
    ],
    [
63074599200, #    utc_start 1999-10-03 02:00:00 (Sun)
63087296400, #      utc_end 2000-02-27 01:00:00 (Sun)
63074595600, #  local_start 1999-10-03 01:00:00 (Sun)
63087292800, #    local_end 2000-02-27 00:00:00 (Sun)
-3600,
1,
'-01',
    ],
    [
63087296400, #    utc_start 2000-02-27 01:00:00 (Sun)
63106653600, #      utc_end 2000-10-08 02:00:00 (Sun)
63087289200, #  local_start 2000-02-26 23:00:00 (Sat)
63106646400, #    local_end 2000-10-08 00:00:00 (Sun)
-7200,
0,
'-02',
    ],
    [
63106653600, #    utc_start 2000-10-08 02:00:00 (Sun)
63107254800, #      utc_end 2000-10-15 01:00:00 (Sun)
63106650000, #  local_start 2000-10-08 01:00:00 (Sun)
63107251200, #    local_end 2000-10-15 00:00:00 (Sun)
-3600,
1,
'-01',
    ],
    [
63107254800, #    utc_start 2000-10-15 01:00:00 (Sun)
63138708000, #      utc_end 2001-10-14 02:00:00 (Sun)
63107247600, #  local_start 2000-10-14 23:00:00 (Sat)
63138700800, #    local_end 2001-10-14 00:00:00 (Sun)
-7200,
0,
'-02',
    ],
    [
63138708000, #    utc_start 2001-10-14 02:00:00 (Sun)
63149590800, #      utc_end 2002-02-17 01:00:00 (Sun)
63138704400, #  local_start 2001-10-14 01:00:00 (Sun)
63149587200, #    local_end 2002-02-17 00:00:00 (Sun)
-3600,
1,
'-01',
    ],
    [
63149590800, #    utc_start 2002-02-17 01:00:00 (Sun)
DateTime::TimeZone::INFINITY, #      utc_end
63149583600, #  local_start 2002-02-16 23:00:00 (Sat)
DateTime::TimeZone::INFINITY, #    local_end
-7200,
0,
'-02',
    ],
];

sub olson_version {'2025b'}

sub has_dst_changes {19}

sub _max_year {2035}

sub _new_instance {
    return shift->_init( @_, spans => $spans );
}



1;

