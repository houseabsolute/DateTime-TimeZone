use strict;

use ExtUtils::MakeMaker;

WriteMakefile( NAME         => 'DateTime::TimeZone',
               VERSION_FROM => 'lib/DateTime/TimeZone.pm',
               AUTHOR       => 'Dave Rolsky <autarch@urth.org>',
               ABSTRACT     => '',
               PREREQ_PM => { 'Tree::RedBlack' => 0,
                              'Params::Validate' => 0,
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
