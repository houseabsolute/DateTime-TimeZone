# This file is auto-generated by the Perl DateTime Suite time zone
# code generator (0.08) This code generator comes with the
# DateTime::TimeZone module distribution in the tools/ directory

#
# Generated from /tmp/I058DLAWvC/asia.  Olson data version 2021e
#
# Do not edit this file directly.
#
package DateTime::TimeZone::Asia::Riyadh;

use strict;
use warnings;
use namespace::autoclean;

our $VERSION = '2.51';

use Class::Singleton 1.03;
use DateTime::TimeZone;
use DateTime::TimeZone::OlsonDB;

@DateTime::TimeZone::Asia::Riyadh::ISA = ( 'Class::Singleton', 'DateTime::TimeZone' );

my $spans =
[
    [
DateTime::TimeZone::NEG_INFINITY, #    utc_start
61416046388, #      utc_end 1947-03-13 20:53:08 (Thu)
DateTime::TimeZone::NEG_INFINITY, #  local_start
61416057600, #    local_end 1947-03-14 00:00:00 (Fri)
11212,
0,
'LMT',
    ],
    [
61416046388, #    utc_start 1947-03-13 20:53:08 (Thu)
DateTime::TimeZone::INFINITY, #      utc_end
61416057188, #  local_start 1947-03-13 23:53:08 (Thu)
DateTime::TimeZone::INFINITY, #    local_end
10800,
0,
'+03',
    ],
];

sub olson_version {'2021e'}

sub has_dst_changes {0}

sub _max_year {2031}

sub _new_instance {
    return shift->_init( @_, spans => $spans );
}



1;

