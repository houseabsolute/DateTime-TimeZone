# This file is auto-generated by the Perl DateTime Suite time zone
# code generator (0.08) This code generator comes with the
# DateTime::TimeZone module distribution in the tools/ directory

#
# Generated from /tmp/t4I0HCM0fO/asia.  Olson data version 2021d
#
# Do not edit this file directly.
#
package DateTime::TimeZone::Asia::Kabul;

use strict;
use warnings;
use namespace::autoclean;

our $VERSION = '2.51';

use Class::Singleton 1.03;
use DateTime::TimeZone;
use DateTime::TimeZone::OlsonDB;

@DateTime::TimeZone::Asia::Kabul::ISA = ( 'Class::Singleton', 'DateTime::TimeZone' );

my $spans =
[
    [
DateTime::TimeZone::NEG_INFINITY, #    utc_start
59611144992, #      utc_end 1889-12-31 19:23:12 (Tue)
DateTime::TimeZone::NEG_INFINITY, #  local_start
59611161600, #    local_end 1890-01-01 00:00:00 (Wed)
16608,
0,
'LMT',
    ],
    [
59611144992, #    utc_start 1889-12-31 19:23:12 (Tue)
61346750400, #      utc_end 1944-12-31 20:00:00 (Sun)
59611159392, #  local_start 1889-12-31 23:23:12 (Tue)
61346764800, #    local_end 1945-01-01 00:00:00 (Mon)
14400,
0,
'+04',
    ],
    [
61346750400, #    utc_start 1944-12-31 20:00:00 (Sun)
DateTime::TimeZone::INFINITY, #      utc_end
61346766600, #  local_start 1945-01-01 00:30:00 (Mon)
DateTime::TimeZone::INFINITY, #    local_end
16200,
0,
'+0430',
    ],
];

sub olson_version {'2021d'}

sub has_dst_changes {0}

sub _max_year {2031}

sub _new_instance {
    return shift->_init( @_, spans => $spans );
}



1;

