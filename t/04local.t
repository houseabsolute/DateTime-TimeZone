#!/usr/bin/perl -w

use strict;

use File::Spec;
use Test::More;

use lib File::Spec->catdir( File::Spec->curdir, 't' );

BEGIN { require 'check_datetime_version.pl' }

plan tests => 12;

use DateTime::TimeZone;

SKIP:
{
    skip "/etc/localtime is not a symlink", 1
        unless -l '/etc/localtime';

    # make sure it doesn't find an /etc/localtime file
    $^W = 0;
    local *DateTime::TimeZone::Local::readlink = sub { undef };
    local *DateTime::TimeZone::Local::_read_etc_sysconfig_clock = sub { undef };
    local *DateTime::TimeZone::Local::_local_from_etc_timezone = sub { undef };
    $^W = 1;

    local $ENV{TZ} = 'this will not work';

    my $tz;
    eval { $tz = DateTime::TimeZone->new( name => 'local' ) };
    like( $@, qr/cannot determine local time zone/i,
          'invalid time zone name in $ENV{TZ} should die' );
}

{
    $^W = 0;
    local *DateTime::TimeZone::Local::readlink = sub { undef };
    local *DateTime::TimeZone::Local::_read_etc_sysconfig_clock = sub { undef };
    local *DateTime::TimeZone::Local::_local_from_etc_timezone = sub { undef };
    $^W = 1;

    local $ENV{TZ} = '123/456';

    my $tz;
    eval { $tz = DateTime::TimeZone->new( name => 'local' ) };
    like( $@, qr/cannot determine local time zone/i,
          'invalid time zone name in $ENV{TZ} and no other info available should die' );
}

{
    local $ENV{TZ} = 'America/Chicago';

    my $tz;
    eval { $tz = DateTime::TimeZone->new( name => 'local' ) };
    is( $@, '', 'valid time zone name in $ENV{TZ} should not die' );
    isa_ok( $tz, 'DateTime::TimeZone::America::Chicago' );
}

SKIP:
{
    skip "/etc/localtime is not a symlink", 2
        unless -l '/etc/localtime';

    $^W = 0;
    local *DateTime::TimeZone::Local::readlink = sub { '/usr/share/zoneinfo/US/Eastern' };
    local *DateTime::TimeZone::Local::_read_etc_sysconfig_clock = sub { undef };
    $^W = 1;

    local $ENV{TZ} = '';

    my $tz;
    eval { $tz = DateTime::TimeZone->new( name => 'local' ) };
    is( $@, '', 'valid time zone name in /etc/localtime should not die' );
    isa_ok( $tz, 'DateTime::TimeZone::America::New_York' );
}

SKIP:
{
    skip "cannot read /etc/sysconfig/clock", 2
        unless -r '/etc/sysconfig/clock' && -f _;

    $^W = 0;
    local *DateTime::TimeZone::Local::readlink = sub { undef };
    local *DateTime::TimeZone::Local::_local_from_etc_timezone = sub { undef };
    local *DateTime::TimeZone::Local::_read_etc_sysconfig_clock = sub { 'US/Eastern' };
    $^W = 1;

    local $ENV{TZ} = '';

    my $tz;
    eval { $tz = DateTime::TimeZone->new( name => 'local' ) };
    is( $@, '', 'valid time zone name in /etc/sysconfig/clock should not die' );
    isa_ok( $tz, 'DateTime::TimeZone::America::New_York' );
}

SKIP:
{
    use Sys::Hostname;

    skip "Cannot run these tests without explicitly knowing local time zone first (only runs on developers' machine)", 4
        unless hostname =~ /houseabsolute/ && -d 'CVS';

    local $ENV{TZ} = '';

    my $tz;
    eval { $tz = DateTime::TimeZone->new( name => 'local' ) };
    is( $@, '', 'valid time zone name in /etc/localtime should not die' );
    isa_ok( $tz, 'DateTime::TimeZone::America::Chicago' );

    $^W = 0;
    local *DateTime::TimeZone::Local::readlink = sub { undef };
    $^W = 1;

    eval { $tz = DateTime::TimeZone->new( name => 'local' ) };
    is( $@, '', 'valid time zone name in /etc/timezone should not die' );
    isa_ok( $tz, 'DateTime::TimeZone::America::Chicago' );
}
