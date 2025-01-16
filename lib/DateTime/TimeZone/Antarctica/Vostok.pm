# This file is auto-generated by the Perl DateTime Suite time zone
# code generator (0.08) This code generator comes with the
# DateTime::TimeZone module distribution in the tools/ directory

#
# Generated from /tmp/u7OXIWSGdF/antarctica.  Olson data version 2025a
#
# Do not edit this file directly.
#
package DateTime::TimeZone::Antarctica::Vostok;

use strict;
use warnings;
use namespace::autoclean;

our $VERSION = '2.64';

use Class::Singleton 1.03;
use DateTime::TimeZone;
use DateTime::TimeZone::OlsonDB;

@DateTime::TimeZone::Antarctica::Vostok::ISA = ( 'Class::Singleton', 'DateTime::TimeZone' );

my $spans =
[
    [
DateTime::TimeZone::NEG_INFINITY, #    utc_start
61755609600, #      utc_end 1957-12-16 00:00:00 (Mon)
DateTime::TimeZone::NEG_INFINITY, #  local_start
61755609600, #    local_end 1957-12-16 00:00:00 (Mon)
0,
0,
'-00',
    ],
    [
61755609600, #    utc_start 1957-12-16 00:00:00 (Mon)
62895718800, #      utc_end 1994-01-31 17:00:00 (Mon)
61755634800, #  local_start 1957-12-16 07:00:00 (Mon)
62895744000, #    local_end 1994-02-01 00:00:00 (Tue)
25200,
0,
'+07',
    ],
    [
62895718800, #    utc_start 1994-01-31 17:00:00 (Mon)
62919331200, #      utc_end 1994-11-01 00:00:00 (Tue)
62895718800, #  local_start 1994-01-31 17:00:00 (Mon)
62919331200, #    local_end 1994-11-01 00:00:00 (Tue)
0,
0,
'-00',
    ],
    [
62919331200, #    utc_start 1994-11-01 00:00:00 (Tue)
63838522800, #      utc_end 2023-12-17 19:00:00 (Sun)
62919356400, #  local_start 1994-11-01 07:00:00 (Tue)
63838548000, #    local_end 2023-12-18 02:00:00 (Mon)
25200,
0,
'+07',
    ],
    [
63838522800, #    utc_start 2023-12-17 19:00:00 (Sun)
DateTime::TimeZone::INFINITY, #      utc_end
63838540800, #  local_start 2023-12-18 00:00:00 (Mon)
DateTime::TimeZone::INFINITY, #    local_end
18000,
0,
'+05',
    ],
];

sub olson_version {'2025a'}

sub has_dst_changes {0}

sub _max_year {2035}

sub _new_instance {
    return shift->_init( @_, spans => $spans );
}



1;

