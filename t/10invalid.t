#!/usr/bin/perl -w

use strict;

use DateTime::TimeZone;

use Test::More tests => 1;


my $tz;
eval { $tz = DateTime::TimeZone->new( name => 'Foo/Bar' ) };

like( $@, qr:Foo/Bar.*could not be loaded.*invalid:,
      "Bad timezone name gives useful error" );
