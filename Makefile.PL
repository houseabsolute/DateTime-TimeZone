use strict;

use ExtUtils::MakeMaker;

WriteMakefile( NAME         => 'DateTime::TimeZone',
               VERSION_FROM => 'lib/DateTime/TimeZone.pm',
               AUTHOR       => 'Dave Rolsky <autarch@urth.org>',
               ABSTRACT     => '',
               PREREQ => { 'Tree::RedBlack' => 0,
                           'Params::Validate' => 0,
                         },
             );
