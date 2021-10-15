# This file is auto-generated by the Perl DateTime Suite time zone
# code generator (0.08) This code generator comes with the
# DateTime::TimeZone module distribution in the tools/ directory

#
# Generated from /tmp/t4I0HCM0fO/australasia.  Olson data version 2021d
#
# Do not edit this file directly.
#
package DateTime::TimeZone::Pacific::Chuuk;

use strict;
use warnings;
use namespace::autoclean;

our $VERSION = '2.51';

use Class::Singleton 1.03;
use DateTime::TimeZone;
use DateTime::TimeZone::OlsonDB;

@DateTime::TimeZone::Pacific::Chuuk::ISA = ( 'Class::Singleton', 'DateTime::TimeZone' );

my $spans =
[
    [
DateTime::TimeZone::NEG_INFINITY, #    utc_start
58191054772, #      utc_end 1844-12-31 13:52:52 (Tue)
DateTime::TimeZone::NEG_INFINITY, #  local_start
58191004800, #    local_end 1844-12-31 00:00:00 (Tue)
-49972,
0,
'LMT',
    ],
    [
58191054772, #    utc_start 1844-12-31 13:52:52 (Tue)
59958193972, #      utc_end 1900-12-31 13:52:52 (Mon)
58191091200, #  local_start 1845-01-01 00:00:00 (Wed)
59958230400, #    local_end 1901-01-01 00:00:00 (Tue)
36428,
0,
'LMT',
    ],
    [
59958193972, #    utc_start 1900-12-31 13:52:52 (Mon)
60392008800, #      utc_end 1914-09-30 14:00:00 (Wed)
59958229972, #  local_start 1900-12-31 23:52:52 (Mon)
60392044800, #    local_end 1914-10-01 00:00:00 (Thu)
36000,
0,
'+10',
    ],
    [
60392008800, #    utc_start 1914-09-30 14:00:00 (Wed)
60528870000, #      utc_end 1919-01-31 15:00:00 (Fri)
60392041200, #  local_start 1914-09-30 23:00:00 (Wed)
60528902400, #    local_end 1919-02-01 00:00:00 (Sat)
32400,
0,
'+09',
    ],
    [
60528870000, #    utc_start 1919-01-31 15:00:00 (Fri)
61228274400, #      utc_end 1941-03-31 14:00:00 (Mon)
60528906000, #  local_start 1919-02-01 01:00:00 (Sat)
61228310400, #    local_end 1941-04-01 00:00:00 (Tue)
36000,
0,
'+10',
    ],
    [
61228274400, #    utc_start 1941-03-31 14:00:00 (Mon)
61365049200, #      utc_end 1945-07-31 15:00:00 (Tue)
61228306800, #  local_start 1941-03-31 23:00:00 (Mon)
61365081600, #    local_end 1945-08-01 00:00:00 (Wed)
32400,
0,
'+09',
    ],
    [
61365049200, #    utc_start 1945-07-31 15:00:00 (Tue)
DateTime::TimeZone::INFINITY, #      utc_end
61365085200, #  local_start 1945-08-01 01:00:00 (Wed)
DateTime::TimeZone::INFINITY, #    local_end
36000,
0,
'+10',
    ],
];

sub olson_version {'2021d'}

sub has_dst_changes {0}

sub _max_year {2031}

sub _new_instance {
    return shift->_init( @_, spans => $spans );
}



1;

