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
API
AQ
Aland
BD
BG
BH
BJ
BN
BQ
BT
BW
BZ
Barthelemy
Bolivarian
Bonaire
Burkina
CN
CPAN
CX
CY
Caicos
Costa
Cunha
DK
DM
Darussalam
DateTime
EE
EG
El
Eustatius
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
KI
KZ
Kitts
LK
LV
LY
Lanka
Leone
Leste
MF
MH
MQ
MX
MZ
Maarten
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
Rica
Rolsky
SG
SL
SV
SX
SY
SZ
Saba
Sao
Sint
Sri
Storable
Subclass
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
subclasses
timezones
versa
