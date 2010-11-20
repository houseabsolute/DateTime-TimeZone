package MyModuleBuild;

use strict;
use warnings;

use base 'Module::Build';

sub new {
    my $class = shift;
    my %args  = @_;

    my %is_win32 = map { $_ => 1 } qw( MSWin32 NetWare symbian );

    $args{requires}{'Win32::TieRegistry'} = '0'
        if $is_win32{$^O};

    $args{requires}{'DateTime::TimeZone::HPUX'} = '0'
        if $^O eq 'hpux';

    $args{dynamic_config} = 1;

    return $class->SUPER::new(%args);
}

1;
