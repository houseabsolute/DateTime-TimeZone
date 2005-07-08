use strict;

use Config qw(%Config);
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

my $no_xs;
for (@ARGV)
{
    /^--pm/ and $no_xs = 1;
    /^--xs/ and $no_xs = 0;
}

if (! $no_xs) {
    print "Testing if you have a C compiler\n";
    if (! open F, ">test.c") {
        warn "cannot write to test.c, skipping test compilation and install pure perl version.\n";
    } else {
        print F <<'EOF';
int main() { return 0; }
EOF
        close F;
        if (system("$Config{make} test$Config{obj_ext}") == 0) {
            $ENV{__HAVE_CC} = 1;
        }
        foreach ('test.c', "test$Config{obj_ext}") {
            unlink $_ or die "Cannot unlink $_: $!";
        }
    }
}

my $class = 'Module::Build';
# If we don't have C compiler, do not attempt to build the XS files.
if(!$no_xs && !$ENV{__HAVE_CC}) {
    print <<'EOF';
I cannot determine if you have a C compiler
so I will install a perl-only implementation

You can force installation of the XS version with

   perl Build.PL --xs

EOF

    $class = Module::Build->subclass(
        code => <<'        EOC',
            sub ACTION_build {
                my $self = shift;
                $self->{build_elements} = [grep { $_ ne 'xs' } @{$self->build_elements}];
                $self->SUPER::ACTION_build(@_);
            }
        EOC
    );
}


my $build = $class->new( module_name => 'DateTime::TimeZone',
                    author      => 'Dave Rolsky <autarch@urth.org>',
                    license     => 'perl',
                    requires    => { 'Params::Validate' => 0.72,
                                     'Class::Singleton' => 1.03,
                                     'Pod::Man'    => 1.14,
                                   },
        		    sign         => 1,
                    c_source     => 'source',
                    create_makefile_pl => 'traditional',
                  );

$build->create_build_script;
