use strict;

use File::Spec;
use Test::More;

use lib File::Spec->catdir( File::Spec->curdir, 't' );

BEGIN { require 'check_datetime_version.pl' }

plan tests => 1;

my $dt = DateTime->now;
eval { $dt->set_time_zone( 'Pacific/Tarawa' ) };
ok( ! $@, "time zone without dst change works" );
warn $@ if $@;
