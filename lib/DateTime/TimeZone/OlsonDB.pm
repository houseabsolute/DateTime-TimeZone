package DateTime::TimeZone::OlsonDB;

use strict;

use vars qw( %MONTHS %DAYS $PLUS_ONE_DAY_DUR $MINUS_ONE_DAY_DUR );

use Params::Validate qw( validate SCALAR );

my $x = 1;
%MONTHS = map { $_ => $x++ }
          qw( Jan Feb Mar Apr May Jun
	      Jul Aug Sep Oct Nov Dec);

$x = 1;
%DAYS = map { $_ => $x++ }
        qw( Mon Tue Wed Thu Fri Sat Sun );

$PLUS_ONE_DAY_DUR =  DateTime::Duration->new( days => 1 );
$MINUS_ONE_DAY_DUR = DateTime::Duration->new( days => -1 );

sub new
{
    my $class = shift;

    return bless { rules => {},
                   zones => {},
                   links => {},
                 }, $class;
}

sub parse_file
{
    my $self = shift;
    my $file = shift;

    open my $fh, "<$file"
        or die "Cannot read $file: $!";

    while (<$fh>)
    {
        chomp;
        $self->_parse_line($_);
    }
}

sub _parse_line
{
    my $self = shift;
    my $line = shift;

    return if $line =~ /^\s+$/;
    return if $line =~ /^#/;

    # remove any comments at the end of the line
    $line =~ s/\s*#.+$//;

    if ( $self->{in_zone} && $line =~ /^\t/ )
    {
        $self->_parse_zone( $line, $self->{in_zone} );
        return;
    }

    foreach ( qw( Rule Zone Link ) )
    {
        if ( substr( $line, 0, 4 ) eq $_ )
        {
            my $m = '_parse_' . lc $_;
            $self->$m($line);
        }
    }
}

sub _parse_rule
{
    my $self = shift;
    my $rule = shift;

    my @items = split /\s+/, $rule, 10;

    shift @items;
    my $name = shift @items;

    my %rule;
    @rule{ qw( from to type in on at save letter ) } = @items;
    delete $rule{letter} if $rule{letter} eq '-';

    delete $rule{type} if $rule{type} eq '-';

    push @{ $self->{rules}{$name} },
        DateTime::TimeZone::OlsonDB::Rule->new(%rule);

    undef $self->{in_zone};
}

sub _parse_zone
{
    my $self = shift;
    my $zone = shift;
    my $name = shift;

    my $expect = $name ? 5 : 6;
    my @items = grep { defined && length } split /\s+/, $zone, $expect;

    my %obs;
    unless ($name)
    {
        shift @items; # remove "Zone"
        $name = shift @items;
    }

    return if $name =~ /[WCME]ET/ && ! $self->{backwards_compat};

    @obs{ qw( gmtoff rules format until ) } = @items;

    # an anonymous add offset rule
    if ( $obs{rules} =~ /\d\d?:\d\d/ )
    {
        $obs{extra_offset} = delete $obs{rules};
    }
    else
    {
        delete $obs{rules} if $obs{rules} eq '-';
    }

    push @{ $self->{zones}{$name} }, \%obs;

    $self->{in_zone} = $name;
}

sub _parse_link
{
    my $self = shift;
    my $link = shift;

    my @items = split /\s+/, $link, 3;

    $self->{links}{ $items[2] } = $items[1];

    undef $self->{in_zone};
}

sub links { %{ $_[0]->{links} } }

sub zone_names { keys %{ $_[0]->{zones} } }

sub zone
{
    my $self = shift;
    my $name = shift;

    die "Invalid zone name $name"
        unless exists $self->{zones}{$name};

    return
        DateTime::TimeZone::OlsonDB::Zone->new
            ( name => $name,
              observances => $self->{zones}{$name},
            );
}

sub expanded_zone
{
    my $self = shift;
    my %p = validate( @_, { name => { type => SCALAR },
                            expand_to_year => { type => SCALAR,
                                                default => (localtime)[5] + 1910 },
                          } );

    my $zone = $self->zone( $p{name} );

    $zone->expand_observances( $self, $p{expand_to_year} );

    return $zone;
}

sub rule
{
    my $self = shift;
    my $name = shift;

    die "Invalid rule name $name"
        unless exists $self->{rules}{$name};

    return @{ $self->{rules}{$name} };
}

sub parse_day_spec
{
    my ( $day, $month, $year ) = @_;

    return $day if $day =~ /^\d+$/;

    if ( $day =~ /^last(\w\w\w)$/ )
    {
        my $dow = $DateTime::TimeZone::OlsonDB::DAYS{$1};

        my $last_day = DateTime->last_day_of_month( year  => $year,
                                                    month => $month );

        my $dt =
            DateTime->new( year   => $year,
                           month  => $month,
                           day    => $last_day->day,
                           time_zone => 'UTC',
                         );

        while ( $dt->day_of_week != $dow )
        {
            $dt -= $PLUS_ONE_DAY_DUR;
        }

        return $dt->day;
    }
    elsif ( $day =~ /^(\w\w\w)([><])=(\d\d?)$/ )
    {
        my $dow = $DateTime::TimeZone::OlsonDB::DAYS{$1};

        my $dt = DateTime->new( year   => $year,
                                month  => $month,
                                day    => $3,
                                time_zone => 'UTC',
                              );

        my $dur = $2 eq '<' ? $MINUS_ONE_DAY_DUR : $PLUS_ONE_DAY_DUR;

        while ( $dt->day_of_week != $dow )
        {
            $dt += $dur;
        }

        return $dt->day;
    }
    else
    {
        die "Invalid on spec for rule: $day\n";
    }
}

sub parse_time_spec
{
    my $time = shift;
    my $base_offset = shift;
    my $extra_offset = shift;

    # 'w'all - ignore
    $time =~ s/w$//;

    # 'g'reenwich, 'u'tc, or 'z'ulu
    $base_offset = 0 if $time =~ s/[guz]$//;

    # 's'tandard time - ignore DS offset
    unless ( $time =~ s/s$// )
    {
        $base_offset -= $extra_offset if defined $extra_offset;
    }

    my ($hour, $minute, $second) = split /:/, $time;
    $minute = 0 unless defined $minute;
    $second = 0 unless defined $second;

    return ( $hour, $minute, $second, $base_offset );
}


package DateTime::TimeZone::OlsonDB::Zone;

use DateTime::TimeZone;

use Params::Validate qw( validate SCALAR ARRAYREF );

sub new
{
    my $class = shift;
    my %p = validate( @_, { name => { type => SCALAR },
                            observances => { type => ARRAYREF },
                          }
                    );

    my $self = { name => $p{name},
                 observances => [],
                 changes => [],
                 infinite_rules => {},
               };

    my $last_until;
    for ( my $x = 0; $x < @{ $p{observances} }; $x++ )
    {
        my $obs =
            DateTime::TimeZone::OlsonDB::Observance->new
                ( %{ $p{observances}[$x] },
                  start => $last_until->{local},
                );

        $last_until = $obs->until;

        push @{ $self->{observances} }, $obs;
    }

    return bless $self, $class;
}

sub expand_observances
{
    my $self = shift;
    my $odb = shift;
    my $max_year = shift;

    foreach my $obs ( @{ $self->{observances} } )
    {
        my $change =
            DateTime::TimeZone::OlsonDB::Change->new
                ( start_date => $obs->start,
                  short_name => sprintf( $obs->format, '' ),
                  observance => $obs,
                );

        $self->add_change($change);

        if ( defined $obs->rules )
        {
            $obs->expand_from_rules( $odb, $self, $max_year );
        }
    }
}

sub add_change
{
    my $self = shift;
    my $change = shift;

    if ( defined $change->start_date )
    {
        push @{ $self->{changes} }, $change;
    }
    else
    {
        if ( $self->{earliest} )
        {
            die "There can only be one earliest time zone change!";
        }
        else
        {
            $self->{earliest} = $change;
        }
    }
}

sub add_infinite_rule
{
    $_[0]->{infinite_rules}{ $_[1] } = $_[1];
}

sub sorted_changes { ( ( defined $_[0]->{earliest} ? $_[0]->{earliest} : () ),
                       sort { $a->start_date <=> $b->start_date }
                       @{ $_[0]->{changes} } ) }

sub infinite_rules { values %{ $_[0]->{infinite_rules} } }


package DateTime::TimeZone::OlsonDB::Observance;

use DateTime;

use Params::Validate qw( validate SCALAR UNDEF OBJECT );

sub new
{
    my $class = shift;
    my %p = validate( @_, { gmtoff => { type => SCALAR },
                            rules  => { type => SCALAR, default => undef },
                            format => { type => SCALAR },
                            until  => { type => SCALAR | UNDEF },
                            start  => { type => OBJECT | UNDEF },
                            extra_offset => { type => SCALAR, optional => 1 },
                          }
                    );

    my $offset = DateTime::TimeZone::offset_as_seconds( $p{gmtoff} );

    if ( $p{extra_offset} )
    {
        $offset += DateTime::TimeZone::offset_as_seconds( $p{extra_offset} );
    }

    return bless { %p,
                   offset => $offset,
                 }, $class;
}

sub offset{ $_[0]->{offset} }

sub rules { $_[0]->{rules} }

sub expand_from_rules
{
    my $self = shift;
    my $odb  = shift;

    foreach my $rule ( $odb->rule( $self->{rules} ) )
    {
        $self->_expand_one_rule( $rule, @_ );
    }
}

sub _expand_one_rule
{
    my $self = shift;
    my $rule = shift;
    my $zone = shift;
    # real max is year + 1 so we include max year
    my $max_year = (shift) + 1;

    my $min_year = $rule->min_year;
    $max_year = $rule->max_year if defined $rule->max_year;

    my $min_dt = $self->start;
    my $max_dt;

    if ( my $until = $self->until( $rule->offset ) )
    {
        $max_dt = $until->{utc};
    }
    else
    {
        $max_dt = DateTime->new( year   => $max_year,
                                 month  => 1,
                                 day    => 1,
                                 time_zone => 'UTC',
                               );
    }

    my $date;
    my $month = $rule->month;

    foreach my $year ( $min_year .. $max_year )
    {
        my $day;

        $date = $rule->date_for_year( $year, $self->{offset} );

        next if $min_dt && $date->{utc} < $min_dt;
        last if $date->{utc} >= $max_dt;

        my $change =
            DateTime::TimeZone::OlsonDB::Change->new
                ( start_date => $date->{local},
                  short_name => sprintf( $self->{format}, $rule->letter ),
                  observance => $self,
                  rule       => $rule,
                );

        $zone->add_change($change);
    }

    unless ( $rule->is_finite )
    {
        $zone->add_infinite_rule($rule);
    }
}

sub format { $_[0]->{format} }

sub start { $_[0]->{start} }

sub until
{
    my $self = shift;
    my $extra_offset = shift;

    return unless defined $self->{until};

    my ( $year, $mon_name, $day, $time ) = split /\s+/, $self->{until};

    my $month =
        defined $mon_name ? $DateTime::TimeZone::OlsonDB::MONTHS{$mon_name} : 1;

    $day =
        ( defined $day ?
          DateTime::TimeZone::OlsonDB::parse_day_spec( $day, $month, $year ) :
          1
        );

    my ( $hour, $minute, $second, $offset );

    if ( defined $time )
    {
        ( $hour, $minute, $second, $offset ) =
            DateTime::TimeZone::OlsonDB::parse_time_spec
                ( $time, $self->{offset}, $extra_offset );
    }
    else
    {
        ( $hour, $minute, $second, $offset ) = ( 0, 0, 0, $self->{offset} );
    }

    my $local = DateTime->new( year   => $year,
                               month  => $month,
                               day    => $day,
                               hour   => $hour,
                               minute => $minute,
                               second => $second,
                               time_zone => 'UTC',
                             );

    return { local => $local,
             utc   => $local - DateTime::Duration->new( seconds => $offset ),
           };
}

package DateTime::TimeZone::OlsonDB::Rule;

use DateTime;
use DateTime::Duration;

use Params::Validate qw( validate SCALAR );

sub new
{
    my $class = shift;
    my %p = validate( @_, { from => { type => SCALAR },
                            to   => { type => SCALAR },
                            type => { type => SCALAR, default => undef },
                            in   => { type => SCALAR },
                            on   => { type => SCALAR },
                            at   => { type => SCALAR },
                            save => { type => SCALAR },
                            letter => { type => SCALAR, default => '' },
                          },
                    );

    my $save = $p{save};

    if ($save)
    {
        $p{offset} = DateTime::TimeZone::offset_as_seconds($save);
    }
    else
    {
        $p{offset} = 0;
    }

    return bless \%p, $class;
}

sub offset { $_[0]->{offset} }

sub is_finite { $_[0]->{to} eq 'max' ? 0 : 1 }

sub min_year { $_[0]->{from} }

sub max_year { $_[0]->{to} eq 'only' ? $_[0]->min_year :
               $_[0]->{to} eq 'max' ? undef : $_[0]->{to} }

sub letter { $_[0]->{letter} }

sub month { $DateTime::TimeZone::OlsonDB::MONTHS{ $_[0]->{in} } }

sub date_for_year
{
    my $self   = shift;
    my $year   = shift;
    my $offset = shift;

    my $day =
        DateTime::TimeZone::OlsonDB::parse_day_spec( $self->{on}, $self->month, $year );

    my ( $hour, $minute, $second, $real_offset ) =
        DateTime::TimeZone::OlsonDB::parse_time_spec
            ( $self->{at}, $offset, $self->{offset} );

    my $local = DateTime->new( year   => $year,
                               month  => $self->month,
                               day    => $day,
                               hour   => $hour,
                               minute => $minute,
                               second => $second,
                               time_zone => 'UTC',
                             );

    return { local => $local,
             utc   => $local - DateTime::Duration->new( seconds => $real_offset ),
           };
}


package DateTime::TimeZone::OlsonDB::Change;

use Params::Validate qw( validate SCALAR UNDEF OBJECT );

sub new
{
    my $class = shift;
    my %p = validate( @_, { start_date => { type => UNDEF | OBJECT },
                            short_name => { type => SCALAR },
                            observance => { type => OBJECT },
                            rule       => { type => OBJECT, default => undef },
                          }
                    );

    $p{offset}  = $p{observance}->offset;
    $p{offset} += $p{rule}->offset if defined $p{rule};

#    $p{last_offset} = $p{last_observance}->offset;

    return bless \%p, $class;
}

sub start_date { $_[0]->{start_date} }
sub short_name { $_[0]->{short_name} }
sub observance { $_[0]->{observance} }
sub rule       { $_[0]->{rule} }
sub offset     { $_[0]->{offset} }

sub two_changes_as_span
{
    my ( $c1, $c2, $last_offset ) = @_;

    my ( $utc_start, $local_start );

    if ( defined $c1->start_date )
    {
        $local_start = $c1->start_date->utc_rd_as_seconds;
        $local_start += $c1->offset - $last_offset;

        # UTC start is local minus the offset when we start, plus the
        # difference in offset between the current offste and the
        # previous offset
        $utc_start = $local_start - $c1->offset;
    }
    else
    {
        $utc_start = $local_start = '-inf';
    }

    my $local_end = $c2->start_date->utc_rd_as_seconds;

    my $utc_end = $local_end - $c2->offset;
    $utc_end -= $c1->offset - $c2->offset;

    return { utc_start   => $utc_start,
             utc_end     => $utc_end,
             local_start => $local_start,
             local_end   => $local_end,
             short_name  => $c1->short_name,
             offset      => $c1->offset,
           };
}

1;

__END__

=head1 NAME

DateTime::TimeZone::OlsonDB - An object to represent an Olson time zone database

=head1 SYNOPSIS


=head1 DESCRIPTION


=cut
