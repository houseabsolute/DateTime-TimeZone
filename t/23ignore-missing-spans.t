use strict;
use warnings;

use lib 't/lib';
use T::RequireDateTime;

use Test::More;
use Test::Fatal;

use DateTime::TimeZone;
use Try::Tiny;

my $tz = DateTime::TimeZone->new( name => 'America/Denver' );

my $dt = DateTime->new(
    year      => 2018,
    month     => 3,
    day       => 11,
    hour      => 2,
    minute    => 0,
    second    => 0,
    time_zone => 'UTC',
);

{
    my $error;

    try {
        my $offset = $tz->offset_for_local_datetime($dt);
    }
    catch {
        $error = $_;
    };

    like( $error, qr/invalid local time/i, 'got correct error' );
}

{
    my $offset = $tz->offset_for_local_datetime( $dt, 1 );
    is( $offset, -25200, 'got -7 offset (even though we should be -6)' );
}

done_testing();

