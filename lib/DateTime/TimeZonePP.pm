# This file is loaded for pure perl implementation. It adds the
# function(s) that would normally be implemented in XS
package DateTime::TimeZone;
use strict;

sub LOADED_XS() { 0 }

sub is_floating { 0 }
sub is_utc { 0 }
sub is_olson { $_[0]->{is_olson} }
sub name { $_[0]->{name} }

sub _init
{
    my $class = shift;
    my $p     = shift;
    
    return bless { %$p }, $class;
}

sub _spans_binary_search
{
    my $self = shift;
    my ( $type, $seconds ) = @_;

    my ( $start, $end ) = _keys_for_type($type);

    my $spans = $self->_spans;
    my $min = 0;
    my $max = scalar(@$spans) + 1;
    my $i = int( $max / 2 );
    # special case for when there are only 2 spans
    $i++ if $max % 2 && $max != 3;

    $i = 0 if scalar(@$spans) == 1;

    while (1)
    {
        my $current = $spans->[$i];

        if ( $seconds < $current->[$start] )
        {
            $max = $i;
            my $c = int( ( $i - $min ) / 2 );
            $c ||= 1;

            $i -= $c;

            return if $i < $min;
        }
        elsif ( $seconds >= $current->[$end] )
        {
            $min = $i;
            my $c = int( ( $max - $i ) / 2 );
            $c ||= 1;

            $i += $c;

            return if $i >= $max;
        }
        else
        {
            # Special case for overlapping ranges because of DST and
            # other weirdness (like Alaska's change when bought from
            # Russia by the US).  Always prefer latest span.
            if ( $current->[IS_DST()] && $type eq 'local' )
            {
                if ($i >= $max) {
                    $self->_generate_next_span();
                }
                my $next = $spans->[$i + 1];

                if ( ( ! $next->[IS_DST()] )
                     && $next->[$start] <= $seconds
                     && $seconds        <= $next->[$end]
                   )
                {
                    return $next;
                }
            }

            return $current;
        }
    }
}

sub offset_as_string
{
    my $offset = shift;

    return undef unless defined $offset;
    return undef unless $offset >= -359999 && $offset <= 359999;

    my $sign = $offset < 0 ? '-' : '+';

    $offset = abs($offset);

    my $hours = int( $offset / 3600 );
    $offset %= 3600;
    my $mins = int( $offset / 60 );
    $offset %= 60;
    my $secs = int( $offset );

    return ( $secs ?
             sprintf( '%s%02d%02d%02d', $sign, $hours, $mins, $secs ) :
             sprintf( '%s%02d%02d', $sign, $hours, $mins )
           );
}

1;

