# This file is auto-generated by the Perl DateTime Suite time zone
# code generator (0.08) This code generator comes with the
# DateTime::TimeZone module distribution in the tools/ directory

#
# Generated from /tmp/ZXAaUsncyZ/southamerica.  Olson data version 2021b
#
# Do not edit this file directly.
#
package DateTime::TimeZone::America::Guayaquil;

use strict;
use warnings;
use namespace::autoclean;

our $VERSION = '2.48';

use Class::Singleton 1.03;
use DateTime::TimeZone;
use DateTime::TimeZone::OlsonDB;

@DateTime::TimeZone::America::Guayaquil::ISA = ( 'Class::Singleton', 'DateTime::TimeZone' );

my $spans =
[
    [
DateTime::TimeZone::NEG_INFINITY, #    utc_start
59611180760, #      utc_end 1890-01-01 05:19:20 (Wed)
DateTime::TimeZone::NEG_INFINITY, #  local_start
59611161600, #    local_end 1890-01-01 00:00:00 (Wed)
-19160,
0,
'LMT',
    ],
    [
59611180760, #    utc_start 1890-01-01 05:19:20 (Wed)
60904934040, #      utc_end 1931-01-01 05:14:00 (Thu)
59611161920, #  local_start 1890-01-01 00:05:20 (Wed)
60904915200, #    local_end 1931-01-01 00:00:00 (Thu)
-18840,
0,
'QMT',
    ],
    [
60904934040, #    utc_start 1931-01-01 05:14:00 (Thu)
62858610000, #      utc_end 1992-11-28 05:00:00 (Sat)
60904916040, #  local_start 1931-01-01 00:14:00 (Thu)
62858592000, #    local_end 1992-11-28 00:00:00 (Sat)
-18000,
0,
'-05',
    ],
    [
62858610000, #    utc_start 1992-11-28 05:00:00 (Sat)
62864568000, #      utc_end 1993-02-05 04:00:00 (Fri)
62858595600, #  local_start 1992-11-28 01:00:00 (Sat)
62864553600, #    local_end 1993-02-05 00:00:00 (Fri)
-14400,
1,
'-04',
    ],
    [
62864568000, #    utc_start 1993-02-05 04:00:00 (Fri)
DateTime::TimeZone::INFINITY, #      utc_end
62864550000, #  local_start 1993-02-04 23:00:00 (Thu)
DateTime::TimeZone::INFINITY, #    local_end
-18000,
0,
'-05',
    ],
];

sub olson_version {'2021b'}

sub has_dst_changes {1}

sub _max_year {2031}

sub _new_instance {
    return shift->_init( @_, spans => $spans );
}



1;

