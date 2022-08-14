# This file is auto-generated by the Perl DateTime Suite time zone
# code generator (0.08) This code generator comes with the
# DateTime::TimeZone module distribution in the tools/ directory

#
# Generated from /tmp/QmbiVitAXO/australasia.  Olson data version 2022b
#
# Do not edit this file directly.
#
package DateTime::TimeZone::Pacific::Noumea;

use strict;
use warnings;
use namespace::autoclean;

our $VERSION = '2.53';

use Class::Singleton 1.03;
use DateTime::TimeZone;
use DateTime::TimeZone::OlsonDB;

@DateTime::TimeZone::Pacific::Noumea::ISA = ( 'Class::Singleton', 'DateTime::TimeZone' );

my $spans =
[
    [
DateTime::TimeZone::NEG_INFINITY, #    utc_start
60306296052, #      utc_end 1912-01-12 12:54:12 (Fri)
DateTime::TimeZone::NEG_INFINITY, #  local_start
60306336000, #    local_end 1912-01-13 00:00:00 (Sat)
39948,
0,
'LMT',
    ],
    [
60306296052, #    utc_start 1912-01-12 12:54:12 (Fri)
62385685200, #      utc_end 1977-12-03 13:00:00 (Sat)
60306335652, #  local_start 1912-01-12 23:54:12 (Fri)
62385724800, #    local_end 1977-12-04 00:00:00 (Sun)
39600,
0,
'+11',
    ],
    [
62385685200, #    utc_start 1977-12-03 13:00:00 (Sat)
62393025600, #      utc_end 1978-02-26 12:00:00 (Sun)
62385728400, #  local_start 1977-12-04 01:00:00 (Sun)
62393068800, #    local_end 1978-02-27 00:00:00 (Mon)
43200,
1,
'+12',
    ],
    [
62393025600, #    utc_start 1978-02-26 12:00:00 (Sun)
62417134800, #      utc_end 1978-12-02 13:00:00 (Sat)
62393065200, #  local_start 1978-02-26 23:00:00 (Sun)
62417174400, #    local_end 1978-12-03 00:00:00 (Sun)
39600,
0,
'+11',
    ],
    [
62417134800, #    utc_start 1978-12-02 13:00:00 (Sat)
62424561600, #      utc_end 1979-02-26 12:00:00 (Mon)
62417178000, #  local_start 1978-12-03 01:00:00 (Sun)
62424604800, #    local_end 1979-02-27 00:00:00 (Tue)
43200,
1,
'+12',
    ],
    [
62424561600, #    utc_start 1979-02-26 12:00:00 (Mon)
62985049200, #      utc_end 1996-11-30 15:00:00 (Sat)
62424601200, #  local_start 1979-02-26 23:00:00 (Mon)
62985088800, #    local_end 1996-12-01 02:00:00 (Sun)
39600,
0,
'+11',
    ],
    [
62985049200, #    utc_start 1996-11-30 15:00:00 (Sat)
62992911600, #      utc_end 1997-03-01 15:00:00 (Sat)
62985092400, #  local_start 1996-12-01 03:00:00 (Sun)
62992954800, #    local_end 1997-03-02 03:00:00 (Sun)
43200,
1,
'+12',
    ],
    [
62992911600, #    utc_start 1997-03-01 15:00:00 (Sat)
DateTime::TimeZone::INFINITY, #      utc_end
62992951200, #  local_start 1997-03-02 02:00:00 (Sun)
DateTime::TimeZone::INFINITY, #    local_end
39600,
0,
'+11',
    ],
];

sub olson_version {'2022b'}

sub has_dst_changes {3}

sub _max_year {2032}

sub _new_instance {
    return shift->_init( @_, spans => $spans );
}



1;

