package DateTime::TimeZone::Local;

use strict;
use warnings;

use vars qw( $VERSION );
$VERSION = '0.01';

use DateTime::TimeZone;
use File::Spec;


sub TimeZone
{
    my $class = shift;

    my $subclass = $class->_load_subclass();

    for my $ meth ( $subclass->Methods() )
    {
	my $tz = $subclass->$meth();

	return $tz if $tz;
    }

    die "Cannot determine local time zone\n";
}

{
    # Stolen from File::Spec. My theory is that other folks can write
    # the non-existent modules if they feel a need, and release them
    # to CPAN separately.
    my %subclass = ( MSWin32 => 'Win32',
                     VMS     => 'VMS',
                     MacOS   => 'Mac',
                     os2     => 'OS2',
                     epoc    => 'Epoc',
                     NetWare => 'Win32',
                     symbian => 'Win32',
                     dos     => 'OS2',
                     cygwin  => 'Unix',
                   );

    sub _load_subclass
    {
        my $class = shift;

        my $subclass = $class . '::' . ( shift || $subclass{ $^O } || 'Unix' );

        return $subclass if $subclass->can('Methods');

        eval "use $subclass";
        if ($@)
        {
            if ( $@ =~ /locate/ )
            {
                $subclass = $class . '::' . 'Unix';

                eval "use $subclass";
                die $@ if $@;
            }
            else
            {
                die $@;
            }
        }

        return $subclass;
    }
}

sub _IsValidName
{
    shift;

    return 0 unless defined $_[0];
    return 0 if $_[0] eq 'local';

    return $_[0] =~ m{^[\w/\-\+]+$};
}

sub FromEnv
{
    my $class = shift;

    foreach my $var ( $class->EnvVars() )
    {
	if ( $class->_IsValidName( $ENV{$var} ) )
	{
	    my $tz = eval { DateTime::TimeZone->new( name => $ENV{$var} ) };
            return $tz if $tz;
	}
    }

    return;
}



1;

__END__

=head1 NAME

DateTime::TimeZone::Local - Determine the local system's time zone

=head1 SYNOPSIS

  my $tz = DateTime::TimeZone->new( name => 'local' );

  my $tz = DateTime::TimeZone::Local->TimeZone();

=head1 DESCRIPTION

...

=head1 METHODS/FUNCTIONS

...

=head1 AUTHOR

Dave Rolsky, <autarch@urth.org>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-datetime-timezone-local@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.  I will be notified, and then you'll automatically be
notified of progress on your bug as I make changes.

=head1 COPYRIGHT & LICENSE

Copyright 2007 Dave Rolsky, All Rights Reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
