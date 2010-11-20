package inc::MetaDynamicConfig;

use Moose;
with 'Dist::Zilla::Role::MetaProvider';

sub metadata {
    return { dynamic_config => 1 };
}

no Moose;

__PACKAGE__->meta->make_immutable();

1;
