# This file is auto-generated by the Perl DateTime Suite time zone
# code generator (0.08) This code generator comes with the
# DateTime::TimeZone module distribution in the tools/ directory

#
# Generated from /tmp/nUm_LjpJ6O/asia.  Olson data version 2025b
#
# Do not edit this file directly.
#
package DateTime::TimeZone::Asia::Bangkok;

use strict;
use warnings;
use namespace::autoclean;

our $VERSION = '2.66';

use Class::Singleton 1.03;
use DateTime::TimeZone;
use DateTime::TimeZone::OlsonDB;

@DateTime::TimeZone::Asia::Bangkok::ISA = ( 'Class::Singleton', 'DateTime::TimeZone' );

my $spans =
[
    [
DateTime::TimeZone::NEG_INFINITY, #    utc_start
59295518276, #      utc_end 1879-12-31 17:17:56 (Wed)
DateTime::TimeZone::NEG_INFINITY, #  local_start
59295542400, #    local_end 1880-01-01 00:00:00 (Thu)
24124,
0,
'LMT',
    ],
    [
59295518276, #    utc_start 1879-12-31 17:17:56 (Wed)
60565598276, #      utc_end 1920-03-31 17:17:56 (Wed)
59295542400, #  local_start 1880-01-01 00:00:00 (Thu)
60565622400, #    local_end 1920-04-01 00:00:00 (Thu)
24124,
0,
'BMT',
    ],
    [
60565598276, #    utc_start 1920-03-31 17:17:56 (Wed)
DateTime::TimeZone::INFINITY, #      utc_end
60565623476, #  local_start 1920-04-01 00:17:56 (Thu)
DateTime::TimeZone::INFINITY, #    local_end
25200,
0,
'+07',
    ],
];

sub olson_version {'2025b'}

sub has_dst_changes {0}

sub _max_year {2035}

sub _new_instance {
    return shift->_init( @_, spans => $spans );
}



1;

