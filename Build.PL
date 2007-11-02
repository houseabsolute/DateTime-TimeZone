use strict;

use Module::Build;
use File::Spec;

unless ( -e File::Spec->catfile( qw( lib DateTime TimeZone America Chicago.pm ) ) )
{
    warn <<'EOF';

It looks like you haven't run tools/parse_olson to generate the time
zone modules yet.

This script needs the Olson database files to run, which can be found
at ftp://elsie.nci.nih.gov/pub/ in a file called tzdata*.tar.gz.

Once you've run this script you will be able to test and install this
distribution.

EOF

    exit;
}

my %requires = ( 'Class::Singleton' => 1.03,
                 'Cwd'              => 3,
                 'Params::Validate' => 0.72,
                 'Pod::Man'    => 1.14,
               );

my %IsWin32 = map { $_ => 1 } qw( MSWin32 NetWare symbian );
$requires{'Win32::TieRegistry'} = 1
    if $IsWin32{ $^O };

Module::Build->new( module_name => 'DateTime::TimeZone',
                    dist_author => 'Dave Rolsky <autarch@urth.org>',
                    license     => 'perl',
                    requires    => \%requires,
                    build_requires => { 'Module::Build' => 0 },
		    sign        => 1,
                    create_makefile_pl => 'passthrough',
                  )->create_build_script;
