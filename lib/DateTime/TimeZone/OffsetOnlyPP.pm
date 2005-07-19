package DateTime::TimeZone::OffsetOnly;
use strict;

sub _init
{
    my $class = shift;
    my $p     = shift;
    return bless { %$p }, $class;
}

sub is_dst_for_datetime { 0 }
sub is_olson { 0 }
sub offset { $_[0]->{offset} }

sub name { $_[0]->{name} }

sub category { undef }

1;
