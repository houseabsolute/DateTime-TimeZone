use strict;
use warnings;

use DateTime::TimeZone::Local;
use File::Basename qw( basename );
use File::Spec;
use Sys::Hostname qw( hostname );
use Test::More;

use lib File::Spec->catdir( File::Spec->curdir, 't' );

BEGIN { require 'check_datetime_version.pl' }

unless ( $^O =~ /win32/i ) {
    plan skip_all => 'These tests only run on Windows';
}

my $Registry;
eval <<'EOF';
use DateTime::TimeZone::Local::Win32;
use Win32::TieRegistry ( TiedRef => \$Registry, Delimiter => q{/} );
EOF

if ($@) {
    plan skip_all => 'These tests require Win32::TieRegistry';
}

my $tzi_key = $Registry->Open(
    'LMachine/SYSTEM/CurrentControlSet/Control/TimeZoneInformation/', {
        Access => Win32::TieRegistry::KEY_READ()
            | Win32::TieRegistry::KEY_WRITE()
    }
);

plan skip_all =>
    'These tests require write access to TimeZoneInformation registry key'
    unless $tzi_key;

my $WindowsTZKey;

{
    foreach my $win_tz_name ( windows_tz_names() ) {
        set_and_test_windows_tz( $win_tz_name, undef, $tzi_key );
    }

    # We test these explicitly because we want to make sure that at
    # least a few known names do work, rather than just relying on
    # looping through a list.
    for my $pair (
        [ 'Eastern Standard Time',  'America/New_York' ],
        [ 'Dateline Standard Time', '-1200' ],
        [ 'Israel Standard Time',   'Asia/Jerusalem' ],
        ) {
        set_and_test_windows_tz( @{$pair}, $tzi_key );
    }
}

done_testing();

sub windows_tz_names {
    $WindowsTZKey = $Registry->Open(
        'LMachine/SOFTWARE/Microsoft/Windows NT/CurrentVersion/Time Zones/',
        { Access => Win32::TieRegistry::KEY_READ() }
    );

    $WindowsTZKey ||= $Registry->Open(
        'LMachine/SOFTWARE/Microsoft/Windows/CurrentVersion/Time Zones/',
        { Access => Win32::TieRegistry::KEY_READ() }
    );

    return unless $WindowsTZKey;

    return $WindowsTZKey->SubKeyNames();
}

sub set_and_test_windows_tz {
    my $windows_tz_name = shift;
    my $olson_name      = shift;
    my $tzi_key         = shift;

    if (   defined $tzi_key
        && defined $tzi_key->{'/TimeZoneKeyName'}
        && $tzi_key->{'/TimeZoneKeyName'} ne '' ) {
        local $tzi_key->{'/TimeZoneKeyName'} = $windows_tz_name;

        test_windows_zone( $windows_tz_name, $olson_name );
    }
    else {
        local $tzi_key->{'/StandardName'} = (
              $WindowsTZKey->{ $windows_tz_name . q{/} }
            ? $WindowsTZKey->{ $windows_tz_name . '/Std' }
            : 'MAKE BELIEVE VALUE'
        );

        test_windows_zone( $windows_tz_name, $olson_name );
    }
}

sub test_windows_zone {
    my $windows_tz_name = shift;
    my $olson_name      = shift;

    my %KnownBad = map { $_ => 1 } 'Kamchatka Standard Time',
        'Namibia Standard Time';

    my $tz = DateTime::TimeZone::Local::Win32->FromRegistry();

    ok(
        $tz && DateTime::TimeZone->is_valid_name( $tz->name() ),
        "$windows_tz_name - found valid Olson time zone from Windows"
    );

    if ( defined $olson_name ) {
        my $desc = "$windows_tz_name was mapped to $olson_name";
        if ($tz) {
            is( $tz->name(), $olson_name, $desc );
        }
        else {
            fail($desc);
        }
    }
    else {
        my $dt = DateTime->new(
            year      => 2010,
            month     => 7,
            day       => 1,
            hour      => 12,
            time_zone => $tz->name(),
        );

        my $olson_offset = int( $dt->strftime("%z") );
        $olson_offset -= 100 if $dt->is_dst();
        my $windows_offset = $WindowsTZKey->{"${windows_tz_name}/Display"};

    SKIP: {
            if ( $windows_offset =~ /^\(GMT\).*$/ ) {
                $windows_offset = 0;
            }
            else {
                if ( $windows_offset =~ s/^\(GMT(.*?):(.*?)\).*$/$1$2/ ) {
                    $windows_offset = int($windows_offset);
                }
                else {
                    skip(
                        "Time Zone display for $windows_tz_name not testable",
                        1
                    );
                }
            }

            if ( $KnownBad{$windows_tz_name} ) {
            TODO: {
                    local $TODO
                        = "Microsoft has some out-of-date time zones relative to Olson";
                    is(
                        $olson_offset, $windows_offset,
                        "$windows_tz_name - Windows offset matches Olson offset"
                    );
                    return;
                }
            }

            is(
                $olson_offset, $windows_offset,
                "$windows_tz_name - Windows offset matches Olson offset"
            );
        }
    }
}
