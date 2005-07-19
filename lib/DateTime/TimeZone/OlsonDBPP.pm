package DateTime::TimeZone::OlsonDB;
use strict;

sub LOADED_XS { 0 }

package DateTime::TimeZone::OlsonDB::Rule;

sub _init
{
    my $class = shift;
    my $p = shift;
    return bless { %$p }, $class;
}

sub name { $_[0]->{name} }
sub offset_from_std { $_[0]->{offset_from_std} }
sub letter { $_[0]->{letter} }
sub min_year { $_[0]->{from} }
sub max_year { $_[0]->{to} eq 'only' ? $_[0]->min_year :
               $_[0]->{to} eq 'max' ? undef : $_[0]->{to} }

sub is_infinite { $_[0]->{to} eq 'max' ? 1 : 0 }
sub save { $_[0]->{save} }
sub type { $_[0]->{type} }
sub in { $_[0]->{in} }
sub on { $_[0]->{on} }
sub at { $_[0]->{at} }
sub to { $_[0]->{to} }
*from = \&min_year;

package DateTime::TimeZone::OlsonDB::Change;

sub _init
{
    my $class = shift;
    my $p = shift;
    return bless { %$p }, $class;
}
sub utc_start_datetime   { $_[0]->{utc_start_datetime} }
sub local_start_datetime { $_[0]->{local_start_datetime} }
sub short_name { $_[0]->{short_name} }
sub is_dst     { $_[0]->{is_dst} }
sub observance { $_[0]->{observance} }
sub rule       { $_[0]->{rule} }
sub offset_from_utc { $_[0]->{offset_from_utc} }
sub offset_from_std { $_[0]->{offset_from_std} }
sub total_offset { $_[0]->offset_from_utc + $_[0]->offset_from_std }

sub two_changes_as_span
{
    my ( $c1, $c2, $last_total_offset ) = @_;

    my ( $utc_start, $local_start );

    if ( defined $c1->utc_start_datetime )
    {
        $utc_start = $c1->utc_start_datetime->utc_rd_as_seconds;
        $local_start = $c1->local_start_datetime->utc_rd_as_seconds;
    }
    else
    {
        $utc_start = $local_start = '-inf';
    }

    my $utc_end = $c2->utc_start_datetime->utc_rd_as_seconds;
    my $local_end = $utc_end + $c1->total_offset;

    return { utc_start   => $utc_start,
             utc_end     => $utc_end,
             local_start => $local_start,
             local_end   => $local_end,
             short_name  => $c1->short_name,
             offset      => $c1->total_offset,
             is_dst      => $c1->is_dst,
           };
}

1;
