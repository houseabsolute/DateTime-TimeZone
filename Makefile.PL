use strict;

use ExtUtils::MakeMaker;
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

WriteMakefile( NAME         => 'DateTime::TimeZone',
               VERSION_FROM => 'lib/DateTime/TimeZone.pm',
               AUTHOR       => 'Dave Rolsky <autarch@urth.org>',
               PREREQ_PM => { 'Params::Validate' => 0,
                              'Class::Singleton' => 1.03,
                            },
               MAN3PODS     =>
               { 'lib/DateTime/TimeZone.pm' =>
                 '$(INST_MAN3DIR)/DateTime::TimeZone.$(MAN3EXT)',

                 'lib/DateTime/TimeZoneCatalog.pm' =>
                 '$(INST_MAN3DIR)/DateTime::TimeZoneCatalog.$(MAN3EXT)',

                 'lib/DateTime/TimeZone/Floating.pm' =>
                 '$(INST_MAN3DIR)/DateTime::TimeZone::Floating.$(MAN3EXT)',

                 'lib/DateTime/TimeZone/OffsetOnly.pm' =>
                 '$(INST_MAN3DIR)/DateTime::TimeZone::OffsetOnly.$(MAN3EXT)',

                 'lib/DateTime/TimeZone/OffsetOnly.pm' =>
                 '$(INST_MAN3DIR)/DateTime::TimeZone::OlsonDB.$(MAN3EXT)',

                 'lib/DateTime/TimeZone/UTC.pm' =>
                 '$(INST_MAN3DIR)/DateTime::TimeZone::UTC.$(MAN3EXT)',
               },
             );

package MY;

sub libscan
{
    my $self = shift;
    my $file = shift;

    return $file =~ /\.cvsignore$/ ? 0 : $self->SUPER::libscan($file);
}
