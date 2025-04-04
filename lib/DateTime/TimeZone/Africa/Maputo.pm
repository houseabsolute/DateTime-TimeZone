# This file is auto-generated by the Perl DateTime Suite time zone
# code generator (0.08) This code generator comes with the
# DateTime::TimeZone module distribution in the tools/ directory

#
# Generated from /tmp/nUm_LjpJ6O/africa.  Olson data version 2025b
#
# Do not edit this file directly.
#
package DateTime::TimeZone::Africa::Maputo;

use strict;
use warnings;
use namespace::autoclean;

our $VERSION = '2.66';

use Class::Singleton 1.03;
use DateTime::TimeZone;
use DateTime::TimeZone::OlsonDB;

@DateTime::TimeZone::Africa::Maputo::ISA = ( 'Class::Singleton', 'DateTime::TimeZone' );

my $spans =
[
    [
DateTime::TimeZone::NEG_INFINITY, #    utc_start
60210683382, #      utc_end 1908-12-31 21:49:42 (Thu)
DateTime::TimeZone::NEG_INFINITY, #  local_start
60210691200, #    local_end 1909-01-01 00:00:00 (Fri)
7818,
0,
'LMT',
    ],
    [
60210683382, #    utc_start 1908-12-31 21:49:42 (Thu)
DateTime::TimeZone::INFINITY, #      utc_end
60210690582, #  local_start 1908-12-31 23:49:42 (Thu)
DateTime::TimeZone::INFINITY, #    local_end
7200,
0,
'CAT',
    ],
];

sub olson_version {'2025b'}

sub has_dst_changes {0}

sub _max_year {2035}

sub _new_instance {
    return shift->_init( @_, spans => $spans );
}



1;

