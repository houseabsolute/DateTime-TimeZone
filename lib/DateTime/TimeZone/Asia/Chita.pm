# This file is auto-generated by the Perl DateTime Suite time zone
# code generator (0.08) This code generator comes with the
# DateTime::TimeZone module distribution in the tools/ directory

#
# Generated from /tmp/QmbiVitAXO/europe.  Olson data version 2022b
#
# Do not edit this file directly.
#
package DateTime::TimeZone::Asia::Chita;

use strict;
use warnings;
use namespace::autoclean;

our $VERSION = '2.53';

use Class::Singleton 1.03;
use DateTime::TimeZone;
use DateTime::TimeZone::OlsonDB;

@DateTime::TimeZone::Asia::Chita::ISA = ( 'Class::Singleton', 'DateTime::TimeZone' );

my $spans =
[
    [
DateTime::TimeZone::NEG_INFINITY, #    utc_start
60556263968, #      utc_end 1919-12-14 16:26:08 (Sun)
DateTime::TimeZone::NEG_INFINITY, #  local_start
60556291200, #    local_end 1919-12-15 00:00:00 (Mon)
27232,
0,
'LMT',
    ],
    [
60556263968, #    utc_start 1919-12-14 16:26:08 (Sun)
60888124800, #      utc_end 1930-06-20 16:00:00 (Fri)
60556292768, #  local_start 1919-12-15 00:26:08 (Mon)
60888153600, #    local_end 1930-06-21 00:00:00 (Sat)
28800,
0,
'+08',
    ],
    [
60888124800, #    utc_start 1930-06-20 16:00:00 (Fri)
62490582000, #      utc_end 1981-03-31 15:00:00 (Tue)
60888157200, #  local_start 1930-06-21 01:00:00 (Sat)
62490614400, #    local_end 1981-04-01 00:00:00 (Wed)
32400,
0,
'+09',
    ],
    [
62490582000, #    utc_start 1981-03-31 15:00:00 (Tue)
62506389600, #      utc_end 1981-09-30 14:00:00 (Wed)
62490618000, #  local_start 1981-04-01 01:00:00 (Wed)
62506425600, #    local_end 1981-10-01 00:00:00 (Thu)
36000,
1,
'+10',
    ],
    [
62506389600, #    utc_start 1981-09-30 14:00:00 (Wed)
62522118000, #      utc_end 1982-03-31 15:00:00 (Wed)
62506422000, #  local_start 1981-09-30 23:00:00 (Wed)
62522150400, #    local_end 1982-04-01 00:00:00 (Thu)
32400,
0,
'+09',
    ],
    [
62522118000, #    utc_start 1982-03-31 15:00:00 (Wed)
62537925600, #      utc_end 1982-09-30 14:00:00 (Thu)
62522154000, #  local_start 1982-04-01 01:00:00 (Thu)
62537961600, #    local_end 1982-10-01 00:00:00 (Fri)
36000,
1,
'+10',
    ],
    [
62537925600, #    utc_start 1982-09-30 14:00:00 (Thu)
62553654000, #      utc_end 1983-03-31 15:00:00 (Thu)
62537958000, #  local_start 1982-09-30 23:00:00 (Thu)
62553686400, #    local_end 1983-04-01 00:00:00 (Fri)
32400,
0,
'+09',
    ],
    [
62553654000, #    utc_start 1983-03-31 15:00:00 (Thu)
62569461600, #      utc_end 1983-09-30 14:00:00 (Fri)
62553690000, #  local_start 1983-04-01 01:00:00 (Fri)
62569497600, #    local_end 1983-10-01 00:00:00 (Sat)
36000,
1,
'+10',
    ],
    [
62569461600, #    utc_start 1983-09-30 14:00:00 (Fri)
62585276400, #      utc_end 1984-03-31 15:00:00 (Sat)
62569494000, #  local_start 1983-09-30 23:00:00 (Fri)
62585308800, #    local_end 1984-04-01 00:00:00 (Sun)
32400,
0,
'+09',
    ],
    [
62585276400, #    utc_start 1984-03-31 15:00:00 (Sat)
62601008400, #      utc_end 1984-09-29 17:00:00 (Sat)
62585312400, #  local_start 1984-04-01 01:00:00 (Sun)
62601044400, #    local_end 1984-09-30 03:00:00 (Sun)
36000,
1,
'+10',
    ],
    [
62601008400, #    utc_start 1984-09-29 17:00:00 (Sat)
62616733200, #      utc_end 1985-03-30 17:00:00 (Sat)
62601040800, #  local_start 1984-09-30 02:00:00 (Sun)
62616765600, #    local_end 1985-03-31 02:00:00 (Sun)
32400,
0,
'+09',
    ],
    [
62616733200, #    utc_start 1985-03-30 17:00:00 (Sat)
62632458000, #      utc_end 1985-09-28 17:00:00 (Sat)
62616769200, #  local_start 1985-03-31 03:00:00 (Sun)
62632494000, #    local_end 1985-09-29 03:00:00 (Sun)
36000,
1,
'+10',
    ],
    [
62632458000, #    utc_start 1985-09-28 17:00:00 (Sat)
62648182800, #      utc_end 1986-03-29 17:00:00 (Sat)
62632490400, #  local_start 1985-09-29 02:00:00 (Sun)
62648215200, #    local_end 1986-03-30 02:00:00 (Sun)
32400,
0,
'+09',
    ],
    [
62648182800, #    utc_start 1986-03-29 17:00:00 (Sat)
62663907600, #      utc_end 1986-09-27 17:00:00 (Sat)
62648218800, #  local_start 1986-03-30 03:00:00 (Sun)
62663943600, #    local_end 1986-09-28 03:00:00 (Sun)
36000,
1,
'+10',
    ],
    [
62663907600, #    utc_start 1986-09-27 17:00:00 (Sat)
62679632400, #      utc_end 1987-03-28 17:00:00 (Sat)
62663940000, #  local_start 1986-09-28 02:00:00 (Sun)
62679664800, #    local_end 1987-03-29 02:00:00 (Sun)
32400,
0,
'+09',
    ],
    [
62679632400, #    utc_start 1987-03-28 17:00:00 (Sat)
62695357200, #      utc_end 1987-09-26 17:00:00 (Sat)
62679668400, #  local_start 1987-03-29 03:00:00 (Sun)
62695393200, #    local_end 1987-09-27 03:00:00 (Sun)
36000,
1,
'+10',
    ],
    [
62695357200, #    utc_start 1987-09-26 17:00:00 (Sat)
62711082000, #      utc_end 1988-03-26 17:00:00 (Sat)
62695389600, #  local_start 1987-09-27 02:00:00 (Sun)
62711114400, #    local_end 1988-03-27 02:00:00 (Sun)
32400,
0,
'+09',
    ],
    [
62711082000, #    utc_start 1988-03-26 17:00:00 (Sat)
62726806800, #      utc_end 1988-09-24 17:00:00 (Sat)
62711118000, #  local_start 1988-03-27 03:00:00 (Sun)
62726842800, #    local_end 1988-09-25 03:00:00 (Sun)
36000,
1,
'+10',
    ],
    [
62726806800, #    utc_start 1988-09-24 17:00:00 (Sat)
62742531600, #      utc_end 1989-03-25 17:00:00 (Sat)
62726839200, #  local_start 1988-09-25 02:00:00 (Sun)
62742564000, #    local_end 1989-03-26 02:00:00 (Sun)
32400,
0,
'+09',
    ],
    [
62742531600, #    utc_start 1989-03-25 17:00:00 (Sat)
62758256400, #      utc_end 1989-09-23 17:00:00 (Sat)
62742567600, #  local_start 1989-03-26 03:00:00 (Sun)
62758292400, #    local_end 1989-09-24 03:00:00 (Sun)
36000,
1,
'+10',
    ],
    [
62758256400, #    utc_start 1989-09-23 17:00:00 (Sat)
62773981200, #      utc_end 1990-03-24 17:00:00 (Sat)
62758288800, #  local_start 1989-09-24 02:00:00 (Sun)
62774013600, #    local_end 1990-03-25 02:00:00 (Sun)
32400,
0,
'+09',
    ],
    [
62773981200, #    utc_start 1990-03-24 17:00:00 (Sat)
62790310800, #      utc_end 1990-09-29 17:00:00 (Sat)
62774017200, #  local_start 1990-03-25 03:00:00 (Sun)
62790346800, #    local_end 1990-09-30 03:00:00 (Sun)
36000,
1,
'+10',
    ],
    [
62790310800, #    utc_start 1990-09-29 17:00:00 (Sat)
62806035600, #      utc_end 1991-03-30 17:00:00 (Sat)
62790343200, #  local_start 1990-09-30 02:00:00 (Sun)
62806068000, #    local_end 1991-03-31 02:00:00 (Sun)
32400,
0,
'+09',
    ],
    [
62806035600, #    utc_start 1991-03-30 17:00:00 (Sat)
62821764000, #      utc_end 1991-09-28 18:00:00 (Sat)
62806068000, #  local_start 1991-03-31 02:00:00 (Sun)
62821796400, #    local_end 1991-09-29 03:00:00 (Sun)
32400,
1,
'+09',
    ],
    [
62821764000, #    utc_start 1991-09-28 18:00:00 (Sat)
62831440800, #      utc_end 1992-01-18 18:00:00 (Sat)
62821792800, #  local_start 1991-09-29 02:00:00 (Sun)
62831469600, #    local_end 1992-01-19 02:00:00 (Sun)
28800,
0,
'+08',
    ],
    [
62831440800, #    utc_start 1992-01-18 18:00:00 (Sat)
62837485200, #      utc_end 1992-03-28 17:00:00 (Sat)
62831473200, #  local_start 1992-01-19 03:00:00 (Sun)
62837517600, #    local_end 1992-03-29 02:00:00 (Sun)
32400,
0,
'+09',
    ],
    [
62837485200, #    utc_start 1992-03-28 17:00:00 (Sat)
62853210000, #      utc_end 1992-09-26 17:00:00 (Sat)
62837521200, #  local_start 1992-03-29 03:00:00 (Sun)
62853246000, #    local_end 1992-09-27 03:00:00 (Sun)
36000,
1,
'+10',
    ],
    [
62853210000, #    utc_start 1992-09-26 17:00:00 (Sat)
62868934800, #      utc_end 1993-03-27 17:00:00 (Sat)
62853242400, #  local_start 1992-09-27 02:00:00 (Sun)
62868967200, #    local_end 1993-03-28 02:00:00 (Sun)
32400,
0,
'+09',
    ],
    [
62868934800, #    utc_start 1993-03-27 17:00:00 (Sat)
62884659600, #      utc_end 1993-09-25 17:00:00 (Sat)
62868970800, #  local_start 1993-03-28 03:00:00 (Sun)
62884695600, #    local_end 1993-09-26 03:00:00 (Sun)
36000,
1,
'+10',
    ],
    [
62884659600, #    utc_start 1993-09-25 17:00:00 (Sat)
62900384400, #      utc_end 1994-03-26 17:00:00 (Sat)
62884692000, #  local_start 1993-09-26 02:00:00 (Sun)
62900416800, #    local_end 1994-03-27 02:00:00 (Sun)
32400,
0,
'+09',
    ],
    [
62900384400, #    utc_start 1994-03-26 17:00:00 (Sat)
62916109200, #      utc_end 1994-09-24 17:00:00 (Sat)
62900420400, #  local_start 1994-03-27 03:00:00 (Sun)
62916145200, #    local_end 1994-09-25 03:00:00 (Sun)
36000,
1,
'+10',
    ],
    [
62916109200, #    utc_start 1994-09-24 17:00:00 (Sat)
62931834000, #      utc_end 1995-03-25 17:00:00 (Sat)
62916141600, #  local_start 1994-09-25 02:00:00 (Sun)
62931866400, #    local_end 1995-03-26 02:00:00 (Sun)
32400,
0,
'+09',
    ],
    [
62931834000, #    utc_start 1995-03-25 17:00:00 (Sat)
62947558800, #      utc_end 1995-09-23 17:00:00 (Sat)
62931870000, #  local_start 1995-03-26 03:00:00 (Sun)
62947594800, #    local_end 1995-09-24 03:00:00 (Sun)
36000,
1,
'+10',
    ],
    [
62947558800, #    utc_start 1995-09-23 17:00:00 (Sat)
62963888400, #      utc_end 1996-03-30 17:00:00 (Sat)
62947591200, #  local_start 1995-09-24 02:00:00 (Sun)
62963920800, #    local_end 1996-03-31 02:00:00 (Sun)
32400,
0,
'+09',
    ],
    [
62963888400, #    utc_start 1996-03-30 17:00:00 (Sat)
62982032400, #      utc_end 1996-10-26 17:00:00 (Sat)
62963924400, #  local_start 1996-03-31 03:00:00 (Sun)
62982068400, #    local_end 1996-10-27 03:00:00 (Sun)
36000,
1,
'+10',
    ],
    [
62982032400, #    utc_start 1996-10-26 17:00:00 (Sat)
62995338000, #      utc_end 1997-03-29 17:00:00 (Sat)
62982064800, #  local_start 1996-10-27 02:00:00 (Sun)
62995370400, #    local_end 1997-03-30 02:00:00 (Sun)
32400,
0,
'+09',
    ],
    [
62995338000, #    utc_start 1997-03-29 17:00:00 (Sat)
63013482000, #      utc_end 1997-10-25 17:00:00 (Sat)
62995374000, #  local_start 1997-03-30 03:00:00 (Sun)
63013518000, #    local_end 1997-10-26 03:00:00 (Sun)
36000,
1,
'+10',
    ],
    [
63013482000, #    utc_start 1997-10-25 17:00:00 (Sat)
63026787600, #      utc_end 1998-03-28 17:00:00 (Sat)
63013514400, #  local_start 1997-10-26 02:00:00 (Sun)
63026820000, #    local_end 1998-03-29 02:00:00 (Sun)
32400,
0,
'+09',
    ],
    [
63026787600, #    utc_start 1998-03-28 17:00:00 (Sat)
63044931600, #      utc_end 1998-10-24 17:00:00 (Sat)
63026823600, #  local_start 1998-03-29 03:00:00 (Sun)
63044967600, #    local_end 1998-10-25 03:00:00 (Sun)
36000,
1,
'+10',
    ],
    [
63044931600, #    utc_start 1998-10-24 17:00:00 (Sat)
63058237200, #      utc_end 1999-03-27 17:00:00 (Sat)
63044964000, #  local_start 1998-10-25 02:00:00 (Sun)
63058269600, #    local_end 1999-03-28 02:00:00 (Sun)
32400,
0,
'+09',
    ],
    [
63058237200, #    utc_start 1999-03-27 17:00:00 (Sat)
63076986000, #      utc_end 1999-10-30 17:00:00 (Sat)
63058273200, #  local_start 1999-03-28 03:00:00 (Sun)
63077022000, #    local_end 1999-10-31 03:00:00 (Sun)
36000,
1,
'+10',
    ],
    [
63076986000, #    utc_start 1999-10-30 17:00:00 (Sat)
63089686800, #      utc_end 2000-03-25 17:00:00 (Sat)
63077018400, #  local_start 1999-10-31 02:00:00 (Sun)
63089719200, #    local_end 2000-03-26 02:00:00 (Sun)
32400,
0,
'+09',
    ],
    [
63089686800, #    utc_start 2000-03-25 17:00:00 (Sat)
63108435600, #      utc_end 2000-10-28 17:00:00 (Sat)
63089722800, #  local_start 2000-03-26 03:00:00 (Sun)
63108471600, #    local_end 2000-10-29 03:00:00 (Sun)
36000,
1,
'+10',
    ],
    [
63108435600, #    utc_start 2000-10-28 17:00:00 (Sat)
63121136400, #      utc_end 2001-03-24 17:00:00 (Sat)
63108468000, #  local_start 2000-10-29 02:00:00 (Sun)
63121168800, #    local_end 2001-03-25 02:00:00 (Sun)
32400,
0,
'+09',
    ],
    [
63121136400, #    utc_start 2001-03-24 17:00:00 (Sat)
63139885200, #      utc_end 2001-10-27 17:00:00 (Sat)
63121172400, #  local_start 2001-03-25 03:00:00 (Sun)
63139921200, #    local_end 2001-10-28 03:00:00 (Sun)
36000,
1,
'+10',
    ],
    [
63139885200, #    utc_start 2001-10-27 17:00:00 (Sat)
63153190800, #      utc_end 2002-03-30 17:00:00 (Sat)
63139917600, #  local_start 2001-10-28 02:00:00 (Sun)
63153223200, #    local_end 2002-03-31 02:00:00 (Sun)
32400,
0,
'+09',
    ],
    [
63153190800, #    utc_start 2002-03-30 17:00:00 (Sat)
63171334800, #      utc_end 2002-10-26 17:00:00 (Sat)
63153226800, #  local_start 2002-03-31 03:00:00 (Sun)
63171370800, #    local_end 2002-10-27 03:00:00 (Sun)
36000,
1,
'+10',
    ],
    [
63171334800, #    utc_start 2002-10-26 17:00:00 (Sat)
63184640400, #      utc_end 2003-03-29 17:00:00 (Sat)
63171367200, #  local_start 2002-10-27 02:00:00 (Sun)
63184672800, #    local_end 2003-03-30 02:00:00 (Sun)
32400,
0,
'+09',
    ],
    [
63184640400, #    utc_start 2003-03-29 17:00:00 (Sat)
63202784400, #      utc_end 2003-10-25 17:00:00 (Sat)
63184676400, #  local_start 2003-03-30 03:00:00 (Sun)
63202820400, #    local_end 2003-10-26 03:00:00 (Sun)
36000,
1,
'+10',
    ],
    [
63202784400, #    utc_start 2003-10-25 17:00:00 (Sat)
63216090000, #      utc_end 2004-03-27 17:00:00 (Sat)
63202816800, #  local_start 2003-10-26 02:00:00 (Sun)
63216122400, #    local_end 2004-03-28 02:00:00 (Sun)
32400,
0,
'+09',
    ],
    [
63216090000, #    utc_start 2004-03-27 17:00:00 (Sat)
63234838800, #      utc_end 2004-10-30 17:00:00 (Sat)
63216126000, #  local_start 2004-03-28 03:00:00 (Sun)
63234874800, #    local_end 2004-10-31 03:00:00 (Sun)
36000,
1,
'+10',
    ],
    [
63234838800, #    utc_start 2004-10-30 17:00:00 (Sat)
63247539600, #      utc_end 2005-03-26 17:00:00 (Sat)
63234871200, #  local_start 2004-10-31 02:00:00 (Sun)
63247572000, #    local_end 2005-03-27 02:00:00 (Sun)
32400,
0,
'+09',
    ],
    [
63247539600, #    utc_start 2005-03-26 17:00:00 (Sat)
63266288400, #      utc_end 2005-10-29 17:00:00 (Sat)
63247575600, #  local_start 2005-03-27 03:00:00 (Sun)
63266324400, #    local_end 2005-10-30 03:00:00 (Sun)
36000,
1,
'+10',
    ],
    [
63266288400, #    utc_start 2005-10-29 17:00:00 (Sat)
63278989200, #      utc_end 2006-03-25 17:00:00 (Sat)
63266320800, #  local_start 2005-10-30 02:00:00 (Sun)
63279021600, #    local_end 2006-03-26 02:00:00 (Sun)
32400,
0,
'+09',
    ],
    [
63278989200, #    utc_start 2006-03-25 17:00:00 (Sat)
63297738000, #      utc_end 2006-10-28 17:00:00 (Sat)
63279025200, #  local_start 2006-03-26 03:00:00 (Sun)
63297774000, #    local_end 2006-10-29 03:00:00 (Sun)
36000,
1,
'+10',
    ],
    [
63297738000, #    utc_start 2006-10-28 17:00:00 (Sat)
63310438800, #      utc_end 2007-03-24 17:00:00 (Sat)
63297770400, #  local_start 2006-10-29 02:00:00 (Sun)
63310471200, #    local_end 2007-03-25 02:00:00 (Sun)
32400,
0,
'+09',
    ],
    [
63310438800, #    utc_start 2007-03-24 17:00:00 (Sat)
63329187600, #      utc_end 2007-10-27 17:00:00 (Sat)
63310474800, #  local_start 2007-03-25 03:00:00 (Sun)
63329223600, #    local_end 2007-10-28 03:00:00 (Sun)
36000,
1,
'+10',
    ],
    [
63329187600, #    utc_start 2007-10-27 17:00:00 (Sat)
63342493200, #      utc_end 2008-03-29 17:00:00 (Sat)
63329220000, #  local_start 2007-10-28 02:00:00 (Sun)
63342525600, #    local_end 2008-03-30 02:00:00 (Sun)
32400,
0,
'+09',
    ],
    [
63342493200, #    utc_start 2008-03-29 17:00:00 (Sat)
63360637200, #      utc_end 2008-10-25 17:00:00 (Sat)
63342529200, #  local_start 2008-03-30 03:00:00 (Sun)
63360673200, #    local_end 2008-10-26 03:00:00 (Sun)
36000,
1,
'+10',
    ],
    [
63360637200, #    utc_start 2008-10-25 17:00:00 (Sat)
63373942800, #      utc_end 2009-03-28 17:00:00 (Sat)
63360669600, #  local_start 2008-10-26 02:00:00 (Sun)
63373975200, #    local_end 2009-03-29 02:00:00 (Sun)
32400,
0,
'+09',
    ],
    [
63373942800, #    utc_start 2009-03-28 17:00:00 (Sat)
63392086800, #      utc_end 2009-10-24 17:00:00 (Sat)
63373978800, #  local_start 2009-03-29 03:00:00 (Sun)
63392122800, #    local_end 2009-10-25 03:00:00 (Sun)
36000,
1,
'+10',
    ],
    [
63392086800, #    utc_start 2009-10-24 17:00:00 (Sat)
63405392400, #      utc_end 2010-03-27 17:00:00 (Sat)
63392119200, #  local_start 2009-10-25 02:00:00 (Sun)
63405424800, #    local_end 2010-03-28 02:00:00 (Sun)
32400,
0,
'+09',
    ],
    [
63405392400, #    utc_start 2010-03-27 17:00:00 (Sat)
63424141200, #      utc_end 2010-10-30 17:00:00 (Sat)
63405428400, #  local_start 2010-03-28 03:00:00 (Sun)
63424177200, #    local_end 2010-10-31 03:00:00 (Sun)
36000,
1,
'+10',
    ],
    [
63424141200, #    utc_start 2010-10-30 17:00:00 (Sat)
63436842000, #      utc_end 2011-03-26 17:00:00 (Sat)
63424173600, #  local_start 2010-10-31 02:00:00 (Sun)
63436874400, #    local_end 2011-03-27 02:00:00 (Sun)
32400,
0,
'+09',
    ],
    [
63436842000, #    utc_start 2011-03-26 17:00:00 (Sat)
63549936000, #      utc_end 2014-10-25 16:00:00 (Sat)
63436878000, #  local_start 2011-03-27 03:00:00 (Sun)
63549972000, #    local_end 2014-10-26 02:00:00 (Sun)
36000,
0,
'+10',
    ],
    [
63549936000, #    utc_start 2014-10-25 16:00:00 (Sat)
63594698400, #      utc_end 2016-03-26 18:00:00 (Sat)
63549964800, #  local_start 2014-10-26 00:00:00 (Sun)
63594727200, #    local_end 2016-03-27 02:00:00 (Sun)
28800,
0,
'+08',
    ],
    [
63594698400, #    utc_start 2016-03-26 18:00:00 (Sat)
DateTime::TimeZone::INFINITY, #      utc_end
63594730800, #  local_start 2016-03-27 03:00:00 (Sun)
DateTime::TimeZone::INFINITY, #    local_end
32400,
0,
'+09',
    ],
];

sub olson_version {'2022b'}

sub has_dst_changes {30}

sub _max_year {2032}

sub _new_instance {
    return shift->_init( @_, spans => $spans );
}



1;

