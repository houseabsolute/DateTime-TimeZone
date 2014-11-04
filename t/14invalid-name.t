use strict;
use warnings;

use Test::More;
use Test::Fatal;

use File::Spec;

use lib File::Spec->catdir( File::Spec->curdir, 't' );

BEGIN { require 'check_datetime_version.pl' }

{
    like(
        exception {
            DateTime::TimeZone->new(
                name => 'America/Chicago; print "hello, world\n";' );
        },
        qr/invalid name/,
        'make sure potentially malicious code cannot sneak into eval'
    );
}

{
    like(
        exception { DateTime::TimeZone->new( name => 'Bad/Name' ) },
        qr/invalid name/,
        'make sure bad names are reported'
    );
}

done_testing();
