use strict;
use warnings;

use Test::More;

eval "use Test::Spelling";
plan skip_all => "Test::Spelling required for testing POD coverage"
    if $@;

my @stopwords;
for (<DATA>) {
    chomp;
    push @stopwords, $_
        unless /\A (?: \# | \s* \z)/msx;    # skip comments, whitespace
}

add_stopwords(@stopwords);
set_spell_cmd('aspell list -l en');

# This prevents a weird segfault from the aspell command - see
# https://bugs.launchpad.net/ubuntu/+source/aspell/+bug/71322
local $ENV{LC_ALL} = 'C';
all_pod_files_spelling_ok();

__DATA__
AE
AO
AQ
BD
BG
BH
BJ
BN
BT
BW
BZ
Barthelemy
Bolivarian
Burkina
CN
CX
Caicos
Cunha
DK
DM
Darussalam
EE
EG
FI
FJ
FK
FO
Faroe
Faso
FromEnv
Futuna
GF
GG
GH
GL
GN
GQ
GW
GY
HK
HN
HU
Hong
IM
JE
JM
Jamahiriya
KE
KH
KZ
Kitts
LK
LV
Lanka
Leste
MF
MH
MQ
MX
MZ
Malvinas
Marino
Mayen
Mayotte
Millenium
Miquelon
NG
NL
Niue
PN
PY
Palau
Papua
PayPal
Plurinational
Puerto
QA
RO
RW
Rata
SG
SL
SV
SY
SZ
Sao
Sri
Storable
TF
TG
TJ
TK
TT
TW
TZ
TZ
Timor
Tokelau
UA
UG
UIs
UTC
UY
UZ
VC
VE
VMS
VN
VU
Viet
WF
WS
XP
ZA
ZM
ZW
Zealand
d'Ivoire
da
datetime
env
pre
versa
