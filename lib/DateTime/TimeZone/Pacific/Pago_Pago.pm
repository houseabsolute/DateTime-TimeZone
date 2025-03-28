# This file is auto-generated by the Perl DateTime Suite time zone
# code generator (0.08) This code generator comes with the
# DateTime::TimeZone module distribution in the tools/ directory

#
# Generated from /tmp/nUm_LjpJ6O/australasia.  Olson data version 2025b
#
# Do not edit this file directly.
#
package DateTime::TimeZone::Pacific::Pago_Pago;

use strict;
use warnings;
use namespace::autoclean;

our $VERSION = '2.66';

use Class::Singleton 1.03;
use DateTime::TimeZone;
use DateTime::TimeZone::OlsonDB;

@DateTime::TimeZone::Pacific::Pago_Pago::ISA = ( 'Class::Singleton', 'DateTime::TimeZone' );

my $spans =
[
    [
DateTime::TimeZone::NEG_INFINITY, #    utc_start
59690258568, #      utc_end 1892-07-04 11:22:48 (Mon)
DateTime::TimeZone::NEG_INFINITY, #  local_start
59690304000, #    local_end 1892-07-05 00:00:00 (Tue)
45432,
0,
'LMT',
    ],
    [
59690258568, #    utc_start 1892-07-04 11:22:48 (Mon)
60273804168, #      utc_end 1911-01-01 11:22:48 (Sun)
59690217600, #  local_start 1892-07-04 00:00:00 (Mon)
60273763200, #    local_end 1911-01-01 00:00:00 (Sun)
-40968,
0,
'LMT',
    ],
    [
60273804168, #    utc_start 1911-01-01 11:22:48 (Sun)
DateTime::TimeZone::INFINITY, #      utc_end
60273764568, #  local_start 1911-01-01 00:22:48 (Sun)
DateTime::TimeZone::INFINITY, #    local_end
-39600,
0,
'SST',
    ],
];

sub olson_version {'2025b'}

sub has_dst_changes {0}

sub _max_year {2035}

sub _new_instance {
    return shift->_init( @_, spans => $spans );
}



1;

