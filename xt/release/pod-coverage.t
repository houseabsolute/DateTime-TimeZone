
use strict;
use warnings;

use Test::More;

eval "use Test::Pod::Coverage 1.04";
plan skip_all => "Test::Pod::Coverage 1.04 required for testing POD coverage"
    if $@;

my %skip = map { $_ => 1 } qw(
    DateTime::TimeZone::Catalog
    DateTime::TimeZone::Floating
    DateTime::TimeZone::OffsetOnly
    DateTime::TimeZone::UTC
);

my @modules = grep {
    !(     $skip{$_}
        || /^DateTime::TimeZone::OlsonDB/
        || /^DateTime::TimeZone::Local::.+/
        || /^DateTime::TimeZone::(?:Africa|America|Antarctica|Asia|Atlantic|Australia|Europe|Indian|Pacific)/
        || /^DateTime::TimeZone::(?:CET|CST6CDT|EET|EST5EDT|EST|HST|MET|MST7MDT|MST|PST8PDT|WET)/
        )
} all_modules();

plan tests => scalar @modules;

my %trustme = (
    'DateTime::TimeZone' =>
        [ map {qr/^$_$/} qw( STORABLE_freeze STORABLE_thaw max_span ) ],
);

for my $mod ( sort @modules ) {
    pod_coverage_ok( $mod, { trustme => $trustme{$mod} || [] } );
}
