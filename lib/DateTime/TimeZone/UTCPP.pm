package DateTime::TimeZone::UTC;
use strict;

sub is_dst_for_datetime { 0 }

sub offset_for_datetime { 0 }
sub offset_for_local_datetime { 0 }

sub short_name_for_datetime { 'UTC' }

sub category { undef }

sub is_floating { 0 }
sub is_olson { 0 }
sub is_utc { 1 }
sub name { 'UTC' }

1;
