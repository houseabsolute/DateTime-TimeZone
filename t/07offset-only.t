use strict;

use File::Spec;
use Test::More;

use lib File::Spec->catdir( File::Spec->curdir, 't' );

BEGIN { require 'check_datetime_version.pl' }

plan tests => 2;

eval { DateTime::TimeZone::OffsetOnly->new( offset => 'bad' ) };
is( $@, "Invalid offset: bad\n",
    'test that OffsetOnly does not allow invalid offsets' );

my $off = DateTime::TimeZone::OffsetOnly->new( offset => '-0100' );
is( $off->name, '-0100', 'name is -0100' );
