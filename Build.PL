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
my $force_xs;
my $use_gdb;
my $help;
for (@ARGV)
{
    /^--pm/ and $no_xs = 1;
    /^--xs/ and $force_xs = 1;
    /^--gdb/ and $use_gdb = 1;
    /^--help/ and $help = 1;
}

if ($help) {
    print <<'EOF';
Usage:
  perl Build.PL --pm
  perl Build.PL --xs [ --gdb ]
  perl Build.PL --help

--pm: Don't compile XS
--xs: Force XS
--gdb: Use -ggdb flag when compiling

EOF
    exit 0;
}

my $have_cc = $force_xs ? 1 : 0;

unless ( $no_xs || $force_xs )
{
    print "Testing if you have a C compiler\n";

    unless ( open F, ">test.c" )
    {
        warn "cannot write to test.c, skipping test compilation and installing pure perl version.\n";
    }
    else
    {
        print F <<'EOF';
int main() { return 0; }
EOF
        close F;

        if ( system("$Config{make} test$Config{obj_ext}") == 0 )
        {
            $have_cc = 1;
        }
        else
        {
            print <<'EOF';
I cannot determine if you have a C compiler
so I will install a perl-only implementation

You can force installation of the XS version with

   perl Build.PL --xs

EOF
        }

        for ( 'test.c', "test$Config{obj_ext}" )
        {
            unlink $_ or die "Cannot unlink $_: $!";
        }
    }
}

my $class = 'Module::Build';

if ($have_cc)
{
    # hack to work around a bug when compiling multiple XS files with
    # ExtUtils::ParseXS - optimistically assume it'll be fixed in the
    # next release
    $class = Module::Build->subclass
        ( code => <<'          EOC',
            sub compile_xs {
              my ($self, $file, %args) = @_;

              $self->log_info("$file -> $args{outfile}\n");

              if (eval {require ExtUtils::ParseXS; 1} && ExtUtils::ParseXS->VERSION > 2.11) {

                ExtUtils::ParseXS::process_file(
                                                filename => $file,
                                                prototypes => 0,
                                                output => $args{outfile},
                                               );
              } else {
                my $xsubpp = Module::Build::ModuleInfo->find_module_by_name('ExtUtils::xsubpp')
                  or die "Can't find ExtUtils::xsubpp in INC (@INC)";

                my @typemaps;
                push @typemaps, Module::Build::ModuleInfo->find_module_by_name('ExtUtils::typemap', \@INC);
                my $lib_typemap = Module::Build::ModuleInfo->find_module_by_name('typemap', ['lib']);
                if (defined $lib_typemap and -e $lib_typemap) {
                  push @typemaps, 'typemap';
                }
                my $typemaps = join ' ', map qq{-typemap "$_"}, @typemaps;

                my $cf = $self->{config};
                my $perl = $self->{properties}{perl};

                my $command = (qq{$perl "-I$cf->{installarchlib}" "-I$cf->{installprivlib}" "$xsubpp" -noprototypes } .
                               qq{$typemaps "$file"});

                $self->log_info($command);
                my $fh = IO::File->new("> $args{outfile}") or die "Couldn't write $args{outfile}: $!";
                print $fh `$command`;
                close $fh;
              }
            }
          EOC
        );
}
else
{
    # If we don't have C compiler, do not attempt to build the XS files.
    $class = Module::Build->subclass
        ( code => <<'          EOC',
            sub ACTION_build {
                my $self  = shift;
                my $elems = $self->build_elements;
                for(my $i = 0; $i < scalar(@$elems); $i++) {
                    if ($elems->[$i] eq 'xs') {
                        splice(@$elems, $i, 1);
                        last;
                    }
                }
                $self->SUPER::ACTION_build(@_);
            }
          EOC
        );
}

my %build_args =
    ( module_name => 'DateTime::TimeZone',
      author      => 'Dave Rolsky <autarch@urth.org>',
      license     => 'perl',
      requires    => { 'Params::Validate' => 0.72,
                       'Class::Singleton' => 1.03,
                       'Pod::Man'         => 1.14,
                     },
      build_requires => { 'ExtUtils::CBuilder' => 0 },
      sign               => 1,
      c_source           => 'source',
      create_makefile_pl => 'passthrough', # XXX - traditional doesn't work, fix later
    );

$build_args{extra_compiler_flags} = [ '-ggdb' ]
    if $use_gdb;

my $build = $class->new(%build_args);

$build->create_build_script;

if ( -d 'CVS' )
{
    local *DIR;
    opendir DIR, "t" or die "Cannot read t: $!";

    foreach my $file ( grep { /^\d.+\.t$/ } readdir DIR )
    {
        next if $file eq '99-pod.t';

        my $real_file = File::Spec->catfile( 't', $file );

        local *F;
        open F, "<$real_file" or die "Cannot read $real_file: $!";

        my $test = do { local $/; <F> };

        close F;

        $test = "#!/usr/bin/perl -w\n\nBEGIN { \$ENV{PERL_DATETIME_TIMEZONE_PP} = 1 }\n\n$test";

        my $new_file = File::Spec->catfile( 't', "zz_$file" );
        open F, ">$new_file" or die "Cannot write $new_file: $!";

        print F $test;

        close F;

        $build->add_to_cleanup($new_file);
    }
}
