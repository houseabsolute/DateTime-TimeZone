# This file is auto-generated by the Perl DateTime Suite time zone
# code generator (0.08) This code generator comes with the
# DateTime::TimeZone module distribution in the tools/ directory

#
# Generated from /tmp/nUm_LjpJ6O/asia.  Olson data version 2025b
#
# Do not edit this file directly.
#
package DateTime::TimeZone::Asia::Tehran;

use strict;
use warnings;
use namespace::autoclean;

our $VERSION = '2.66';

use Class::Singleton 1.03;
use DateTime::TimeZone;
use DateTime::TimeZone::OlsonDB;

@DateTime::TimeZone::Asia::Tehran::ISA = ( 'Class::Singleton', 'DateTime::TimeZone' );

my $spans =
[
    [
DateTime::TimeZone::NEG_INFINITY, #    utc_start
60431517256, #      utc_end 1915-12-31 20:34:16 (Fri)
DateTime::TimeZone::NEG_INFINITY, #  local_start
60431529600, #    local_end 1916-01-01 00:00:00 (Sat)
12344,
0,
'LMT',
    ],
    [
60431517256, #    utc_start 1915-12-31 20:34:16 (Fri)
61045216456, #      utc_end 1935-06-12 20:34:16 (Wed)
60431529600, #  local_start 1916-01-01 00:00:00 (Sat)
61045228800, #    local_end 1935-06-13 00:00:00 (Thu)
12344,
0,
'TMT',
    ],
    [
61045216456, #    utc_start 1935-06-12 20:34:16 (Wed)
62363503800, #      utc_end 1977-03-21 19:30:00 (Mon)
61045229056, #  local_start 1935-06-13 00:04:16 (Thu)
62363516400, #    local_end 1977-03-21 23:00:00 (Mon)
12600,
0,
'+0330',
    ],
    [
62363503800, #    utc_start 1977-03-21 19:30:00 (Mon)
62381907000, #      utc_end 1977-10-20 19:30:00 (Thu)
62363520000, #  local_start 1977-03-22 00:00:00 (Tue)
62381923200, #    local_end 1977-10-21 00:00:00 (Fri)
16200,
1,
'+0430',
    ],
    [
62381907000, #    utc_start 1977-10-20 19:30:00 (Thu)
62395300800, #      utc_end 1978-03-24 20:00:00 (Fri)
62381921400, #  local_start 1977-10-20 23:30:00 (Thu)
62395315200, #    local_end 1978-03-25 00:00:00 (Sat)
14400,
0,
'+04',
    ],
    [
62395300800, #    utc_start 1978-03-24 20:00:00 (Fri)
62406792000, #      utc_end 1978-08-04 20:00:00 (Fri)
62395318800, #  local_start 1978-03-25 01:00:00 (Sat)
62406810000, #    local_end 1978-08-05 01:00:00 (Sat)
18000,
1,
'+05',
    ],
    [
62406792000, #    utc_start 1978-08-04 20:00:00 (Fri)
62415259200, #      utc_end 1978-11-10 20:00:00 (Fri)
62406806400, #  local_start 1978-08-05 00:00:00 (Sat)
62415273600, #    local_end 1978-11-11 00:00:00 (Sat)
14400,
0,
'+04',
    ],
    [
62415259200, #    utc_start 1978-11-10 20:00:00 (Fri)
62432281800, #      utc_end 1979-05-26 20:30:00 (Sat)
62415271800, #  local_start 1978-11-10 23:30:00 (Fri)
62432294400, #    local_end 1979-05-27 00:00:00 (Sun)
12600,
0,
'+0330',
    ],
    [
62432281800, #    utc_start 1979-05-26 20:30:00 (Sat)
62442214200, #      utc_end 1979-09-18 19:30:00 (Tue)
62432298000, #  local_start 1979-05-27 01:00:00 (Sun)
62442230400, #    local_end 1979-09-19 00:00:00 (Wed)
16200,
1,
'+0430',
    ],
    [
62442214200, #    utc_start 1979-09-18 19:30:00 (Tue)
62458115400, #      utc_end 1980-03-20 20:30:00 (Thu)
62442226800, #  local_start 1979-09-18 23:00:00 (Tue)
62458128000, #    local_end 1980-03-21 00:00:00 (Fri)
12600,
0,
'+0330',
    ],
    [
62458115400, #    utc_start 1980-03-20 20:30:00 (Thu)
62474182200, #      utc_end 1980-09-22 19:30:00 (Mon)
62458131600, #  local_start 1980-03-21 01:00:00 (Fri)
62474198400, #    local_end 1980-09-23 00:00:00 (Tue)
16200,
1,
'+0430',
    ],
    [
62474182200, #    utc_start 1980-09-22 19:30:00 (Mon)
62808899400, #      utc_end 1991-05-02 20:30:00 (Thu)
62474194800, #  local_start 1980-09-22 23:00:00 (Mon)
62808912000, #    local_end 1991-05-03 00:00:00 (Fri)
12600,
0,
'+0330',
    ],
    [
62808899400, #    utc_start 1991-05-02 20:30:00 (Thu)
62821164600, #      utc_end 1991-09-21 19:30:00 (Sat)
62808915600, #  local_start 1991-05-03 01:00:00 (Fri)
62821180800, #    local_end 1991-09-22 00:00:00 (Sun)
16200,
1,
'+0430',
    ],
    [
62821164600, #    utc_start 1991-09-21 19:30:00 (Sat)
62836893000, #      utc_end 1992-03-21 20:30:00 (Sat)
62821177200, #  local_start 1991-09-21 23:00:00 (Sat)
62836905600, #    local_end 1992-03-22 00:00:00 (Sun)
12600,
0,
'+0330',
    ],
    [
62836893000, #    utc_start 1992-03-21 20:30:00 (Sat)
62852787000, #      utc_end 1992-09-21 19:30:00 (Mon)
62836909200, #  local_start 1992-03-22 01:00:00 (Sun)
62852803200, #    local_end 1992-09-22 00:00:00 (Tue)
16200,
1,
'+0430',
    ],
    [
62852787000, #    utc_start 1992-09-21 19:30:00 (Mon)
62868429000, #      utc_end 1993-03-21 20:30:00 (Sun)
62852799600, #  local_start 1992-09-21 23:00:00 (Mon)
62868441600, #    local_end 1993-03-22 00:00:00 (Mon)
12600,
0,
'+0330',
    ],
    [
62868429000, #    utc_start 1993-03-21 20:30:00 (Sun)
62884323000, #      utc_end 1993-09-21 19:30:00 (Tue)
62868445200, #  local_start 1993-03-22 01:00:00 (Mon)
62884339200, #    local_end 1993-09-22 00:00:00 (Wed)
16200,
1,
'+0430',
    ],
    [
62884323000, #    utc_start 1993-09-21 19:30:00 (Tue)
62899965000, #      utc_end 1994-03-21 20:30:00 (Mon)
62884335600, #  local_start 1993-09-21 23:00:00 (Tue)
62899977600, #    local_end 1994-03-22 00:00:00 (Tue)
12600,
0,
'+0330',
    ],
    [
62899965000, #    utc_start 1994-03-21 20:30:00 (Mon)
62915859000, #      utc_end 1994-09-21 19:30:00 (Wed)
62899981200, #  local_start 1994-03-22 01:00:00 (Tue)
62915875200, #    local_end 1994-09-22 00:00:00 (Thu)
16200,
1,
'+0430',
    ],
    [
62915859000, #    utc_start 1994-09-21 19:30:00 (Wed)
62931501000, #      utc_end 1995-03-21 20:30:00 (Tue)
62915871600, #  local_start 1994-09-21 23:00:00 (Wed)
62931513600, #    local_end 1995-03-22 00:00:00 (Wed)
12600,
0,
'+0330',
    ],
    [
62931501000, #    utc_start 1995-03-21 20:30:00 (Tue)
62947395000, #      utc_end 1995-09-21 19:30:00 (Thu)
62931517200, #  local_start 1995-03-22 01:00:00 (Wed)
62947411200, #    local_end 1995-09-22 00:00:00 (Fri)
16200,
1,
'+0430',
    ],
    [
62947395000, #    utc_start 1995-09-21 19:30:00 (Thu)
62963037000, #      utc_end 1996-03-20 20:30:00 (Wed)
62947407600, #  local_start 1995-09-21 23:00:00 (Thu)
62963049600, #    local_end 1996-03-21 00:00:00 (Thu)
12600,
0,
'+0330',
    ],
    [
62963037000, #    utc_start 1996-03-20 20:30:00 (Wed)
62978931000, #      utc_end 1996-09-20 19:30:00 (Fri)
62963053200, #  local_start 1996-03-21 01:00:00 (Thu)
62978947200, #    local_end 1996-09-21 00:00:00 (Sat)
16200,
1,
'+0430',
    ],
    [
62978931000, #    utc_start 1996-09-20 19:30:00 (Fri)
62994659400, #      utc_end 1997-03-21 20:30:00 (Fri)
62978943600, #  local_start 1996-09-20 23:00:00 (Fri)
62994672000, #    local_end 1997-03-22 00:00:00 (Sat)
12600,
0,
'+0330',
    ],
    [
62994659400, #    utc_start 1997-03-21 20:30:00 (Fri)
63010553400, #      utc_end 1997-09-21 19:30:00 (Sun)
62994675600, #  local_start 1997-03-22 01:00:00 (Sat)
63010569600, #    local_end 1997-09-22 00:00:00 (Mon)
16200,
1,
'+0430',
    ],
    [
63010553400, #    utc_start 1997-09-21 19:30:00 (Sun)
63026195400, #      utc_end 1998-03-21 20:30:00 (Sat)
63010566000, #  local_start 1997-09-21 23:00:00 (Sun)
63026208000, #    local_end 1998-03-22 00:00:00 (Sun)
12600,
0,
'+0330',
    ],
    [
63026195400, #    utc_start 1998-03-21 20:30:00 (Sat)
63042089400, #      utc_end 1998-09-21 19:30:00 (Mon)
63026211600, #  local_start 1998-03-22 01:00:00 (Sun)
63042105600, #    local_end 1998-09-22 00:00:00 (Tue)
16200,
1,
'+0430',
    ],
    [
63042089400, #    utc_start 1998-09-21 19:30:00 (Mon)
63057731400, #      utc_end 1999-03-21 20:30:00 (Sun)
63042102000, #  local_start 1998-09-21 23:00:00 (Mon)
63057744000, #    local_end 1999-03-22 00:00:00 (Mon)
12600,
0,
'+0330',
    ],
    [
63057731400, #    utc_start 1999-03-21 20:30:00 (Sun)
63073625400, #      utc_end 1999-09-21 19:30:00 (Tue)
63057747600, #  local_start 1999-03-22 01:00:00 (Mon)
63073641600, #    local_end 1999-09-22 00:00:00 (Wed)
16200,
1,
'+0430',
    ],
    [
63073625400, #    utc_start 1999-09-21 19:30:00 (Tue)
63089267400, #      utc_end 2000-03-20 20:30:00 (Mon)
63073638000, #  local_start 1999-09-21 23:00:00 (Tue)
63089280000, #    local_end 2000-03-21 00:00:00 (Tue)
12600,
0,
'+0330',
    ],
    [
63089267400, #    utc_start 2000-03-20 20:30:00 (Mon)
63105161400, #      utc_end 2000-09-20 19:30:00 (Wed)
63089283600, #  local_start 2000-03-21 01:00:00 (Tue)
63105177600, #    local_end 2000-09-21 00:00:00 (Thu)
16200,
1,
'+0430',
    ],
    [
63105161400, #    utc_start 2000-09-20 19:30:00 (Wed)
63120889800, #      utc_end 2001-03-21 20:30:00 (Wed)
63105174000, #  local_start 2000-09-20 23:00:00 (Wed)
63120902400, #    local_end 2001-03-22 00:00:00 (Thu)
12600,
0,
'+0330',
    ],
    [
63120889800, #    utc_start 2001-03-21 20:30:00 (Wed)
63136783800, #      utc_end 2001-09-21 19:30:00 (Fri)
63120906000, #  local_start 2001-03-22 01:00:00 (Thu)
63136800000, #    local_end 2001-09-22 00:00:00 (Sat)
16200,
1,
'+0430',
    ],
    [
63136783800, #    utc_start 2001-09-21 19:30:00 (Fri)
63152425800, #      utc_end 2002-03-21 20:30:00 (Thu)
63136796400, #  local_start 2001-09-21 23:00:00 (Fri)
63152438400, #    local_end 2002-03-22 00:00:00 (Fri)
12600,
0,
'+0330',
    ],
    [
63152425800, #    utc_start 2002-03-21 20:30:00 (Thu)
63168319800, #      utc_end 2002-09-21 19:30:00 (Sat)
63152442000, #  local_start 2002-03-22 01:00:00 (Fri)
63168336000, #    local_end 2002-09-22 00:00:00 (Sun)
16200,
1,
'+0430',
    ],
    [
63168319800, #    utc_start 2002-09-21 19:30:00 (Sat)
63183961800, #      utc_end 2003-03-21 20:30:00 (Fri)
63168332400, #  local_start 2002-09-21 23:00:00 (Sat)
63183974400, #    local_end 2003-03-22 00:00:00 (Sat)
12600,
0,
'+0330',
    ],
    [
63183961800, #    utc_start 2003-03-21 20:30:00 (Fri)
63199855800, #      utc_end 2003-09-21 19:30:00 (Sun)
63183978000, #  local_start 2003-03-22 01:00:00 (Sat)
63199872000, #    local_end 2003-09-22 00:00:00 (Mon)
16200,
1,
'+0430',
    ],
    [
63199855800, #    utc_start 2003-09-21 19:30:00 (Sun)
63215497800, #      utc_end 2004-03-20 20:30:00 (Sat)
63199868400, #  local_start 2003-09-21 23:00:00 (Sun)
63215510400, #    local_end 2004-03-21 00:00:00 (Sun)
12600,
0,
'+0330',
    ],
    [
63215497800, #    utc_start 2004-03-20 20:30:00 (Sat)
63231391800, #      utc_end 2004-09-20 19:30:00 (Mon)
63215514000, #  local_start 2004-03-21 01:00:00 (Sun)
63231408000, #    local_end 2004-09-21 00:00:00 (Tue)
16200,
1,
'+0430',
    ],
    [
63231391800, #    utc_start 2004-09-20 19:30:00 (Mon)
63247120200, #      utc_end 2005-03-21 20:30:00 (Mon)
63231404400, #  local_start 2004-09-20 23:00:00 (Mon)
63247132800, #    local_end 2005-03-22 00:00:00 (Tue)
12600,
0,
'+0330',
    ],
    [
63247120200, #    utc_start 2005-03-21 20:30:00 (Mon)
63263014200, #      utc_end 2005-09-21 19:30:00 (Wed)
63247136400, #  local_start 2005-03-22 01:00:00 (Tue)
63263030400, #    local_end 2005-09-22 00:00:00 (Thu)
16200,
1,
'+0430',
    ],
    [
63263014200, #    utc_start 2005-09-21 19:30:00 (Wed)
63341728200, #      utc_end 2008-03-20 20:30:00 (Thu)
63263026800, #  local_start 2005-09-21 23:00:00 (Wed)
63341740800, #    local_end 2008-03-21 00:00:00 (Fri)
12600,
0,
'+0330',
    ],
    [
63341728200, #    utc_start 2008-03-20 20:30:00 (Thu)
63357622200, #      utc_end 2008-09-20 19:30:00 (Sat)
63341744400, #  local_start 2008-03-21 01:00:00 (Fri)
63357638400, #    local_end 2008-09-21 00:00:00 (Sun)
16200,
1,
'+0430',
    ],
    [
63357622200, #    utc_start 2008-09-20 19:30:00 (Sat)
63373350600, #      utc_end 2009-03-21 20:30:00 (Sat)
63357634800, #  local_start 2008-09-20 23:00:00 (Sat)
63373363200, #    local_end 2009-03-22 00:00:00 (Sun)
12600,
0,
'+0330',
    ],
    [
63373350600, #    utc_start 2009-03-21 20:30:00 (Sat)
63389244600, #      utc_end 2009-09-21 19:30:00 (Mon)
63373366800, #  local_start 2009-03-22 01:00:00 (Sun)
63389260800, #    local_end 2009-09-22 00:00:00 (Tue)
16200,
1,
'+0430',
    ],
    [
63389244600, #    utc_start 2009-09-21 19:30:00 (Mon)
63404886600, #      utc_end 2010-03-21 20:30:00 (Sun)
63389257200, #  local_start 2009-09-21 23:00:00 (Mon)
63404899200, #    local_end 2010-03-22 00:00:00 (Mon)
12600,
0,
'+0330',
    ],
    [
63404886600, #    utc_start 2010-03-21 20:30:00 (Sun)
63420780600, #      utc_end 2010-09-21 19:30:00 (Tue)
63404902800, #  local_start 2010-03-22 01:00:00 (Mon)
63420796800, #    local_end 2010-09-22 00:00:00 (Wed)
16200,
1,
'+0430',
    ],
    [
63420780600, #    utc_start 2010-09-21 19:30:00 (Tue)
63436422600, #      utc_end 2011-03-21 20:30:00 (Mon)
63420793200, #  local_start 2010-09-21 23:00:00 (Tue)
63436435200, #    local_end 2011-03-22 00:00:00 (Tue)
12600,
0,
'+0330',
    ],
    [
63436422600, #    utc_start 2011-03-21 20:30:00 (Mon)
63452316600, #      utc_end 2011-09-21 19:30:00 (Wed)
63436438800, #  local_start 2011-03-22 01:00:00 (Tue)
63452332800, #    local_end 2011-09-22 00:00:00 (Thu)
16200,
1,
'+0430',
    ],
    [
63452316600, #    utc_start 2011-09-21 19:30:00 (Wed)
63467958600, #      utc_end 2012-03-20 20:30:00 (Tue)
63452329200, #  local_start 2011-09-21 23:00:00 (Wed)
63467971200, #    local_end 2012-03-21 00:00:00 (Wed)
12600,
0,
'+0330',
    ],
    [
63467958600, #    utc_start 2012-03-20 20:30:00 (Tue)
63483852600, #      utc_end 2012-09-20 19:30:00 (Thu)
63467974800, #  local_start 2012-03-21 01:00:00 (Wed)
63483868800, #    local_end 2012-09-21 00:00:00 (Fri)
16200,
1,
'+0430',
    ],
    [
63483852600, #    utc_start 2012-09-20 19:30:00 (Thu)
63499581000, #      utc_end 2013-03-21 20:30:00 (Thu)
63483865200, #  local_start 2012-09-20 23:00:00 (Thu)
63499593600, #    local_end 2013-03-22 00:00:00 (Fri)
12600,
0,
'+0330',
    ],
    [
63499581000, #    utc_start 2013-03-21 20:30:00 (Thu)
63515475000, #      utc_end 2013-09-21 19:30:00 (Sat)
63499597200, #  local_start 2013-03-22 01:00:00 (Fri)
63515491200, #    local_end 2013-09-22 00:00:00 (Sun)
16200,
1,
'+0430',
    ],
    [
63515475000, #    utc_start 2013-09-21 19:30:00 (Sat)
63531117000, #      utc_end 2014-03-21 20:30:00 (Fri)
63515487600, #  local_start 2013-09-21 23:00:00 (Sat)
63531129600, #    local_end 2014-03-22 00:00:00 (Sat)
12600,
0,
'+0330',
    ],
    [
63531117000, #    utc_start 2014-03-21 20:30:00 (Fri)
63547011000, #      utc_end 2014-09-21 19:30:00 (Sun)
63531133200, #  local_start 2014-03-22 01:00:00 (Sat)
63547027200, #    local_end 2014-09-22 00:00:00 (Mon)
16200,
1,
'+0430',
    ],
    [
63547011000, #    utc_start 2014-09-21 19:30:00 (Sun)
63562653000, #      utc_end 2015-03-21 20:30:00 (Sat)
63547023600, #  local_start 2014-09-21 23:00:00 (Sun)
63562665600, #    local_end 2015-03-22 00:00:00 (Sun)
12600,
0,
'+0330',
    ],
    [
63562653000, #    utc_start 2015-03-21 20:30:00 (Sat)
63578547000, #      utc_end 2015-09-21 19:30:00 (Mon)
63562669200, #  local_start 2015-03-22 01:00:00 (Sun)
63578563200, #    local_end 2015-09-22 00:00:00 (Tue)
16200,
1,
'+0430',
    ],
    [
63578547000, #    utc_start 2015-09-21 19:30:00 (Mon)
63594189000, #      utc_end 2016-03-20 20:30:00 (Sun)
63578559600, #  local_start 2015-09-21 23:00:00 (Mon)
63594201600, #    local_end 2016-03-21 00:00:00 (Mon)
12600,
0,
'+0330',
    ],
    [
63594189000, #    utc_start 2016-03-20 20:30:00 (Sun)
63610083000, #      utc_end 2016-09-20 19:30:00 (Tue)
63594205200, #  local_start 2016-03-21 01:00:00 (Mon)
63610099200, #    local_end 2016-09-21 00:00:00 (Wed)
16200,
1,
'+0430',
    ],
    [
63610083000, #    utc_start 2016-09-20 19:30:00 (Tue)
63625811400, #      utc_end 2017-03-21 20:30:00 (Tue)
63610095600, #  local_start 2016-09-20 23:00:00 (Tue)
63625824000, #    local_end 2017-03-22 00:00:00 (Wed)
12600,
0,
'+0330',
    ],
    [
63625811400, #    utc_start 2017-03-21 20:30:00 (Tue)
63641705400, #      utc_end 2017-09-21 19:30:00 (Thu)
63625827600, #  local_start 2017-03-22 01:00:00 (Wed)
63641721600, #    local_end 2017-09-22 00:00:00 (Fri)
16200,
1,
'+0430',
    ],
    [
63641705400, #    utc_start 2017-09-21 19:30:00 (Thu)
63657347400, #      utc_end 2018-03-21 20:30:00 (Wed)
63641718000, #  local_start 2017-09-21 23:00:00 (Thu)
63657360000, #    local_end 2018-03-22 00:00:00 (Thu)
12600,
0,
'+0330',
    ],
    [
63657347400, #    utc_start 2018-03-21 20:30:00 (Wed)
63673241400, #      utc_end 2018-09-21 19:30:00 (Fri)
63657363600, #  local_start 2018-03-22 01:00:00 (Thu)
63673257600, #    local_end 2018-09-22 00:00:00 (Sat)
16200,
1,
'+0430',
    ],
    [
63673241400, #    utc_start 2018-09-21 19:30:00 (Fri)
63688883400, #      utc_end 2019-03-21 20:30:00 (Thu)
63673254000, #  local_start 2018-09-21 23:00:00 (Fri)
63688896000, #    local_end 2019-03-22 00:00:00 (Fri)
12600,
0,
'+0330',
    ],
    [
63688883400, #    utc_start 2019-03-21 20:30:00 (Thu)
63704777400, #      utc_end 2019-09-21 19:30:00 (Sat)
63688899600, #  local_start 2019-03-22 01:00:00 (Fri)
63704793600, #    local_end 2019-09-22 00:00:00 (Sun)
16200,
1,
'+0430',
    ],
    [
63704777400, #    utc_start 2019-09-21 19:30:00 (Sat)
63720419400, #      utc_end 2020-03-20 20:30:00 (Fri)
63704790000, #  local_start 2019-09-21 23:00:00 (Sat)
63720432000, #    local_end 2020-03-21 00:00:00 (Sat)
12600,
0,
'+0330',
    ],
    [
63720419400, #    utc_start 2020-03-20 20:30:00 (Fri)
63736313400, #      utc_end 2020-09-20 19:30:00 (Sun)
63720435600, #  local_start 2020-03-21 01:00:00 (Sat)
63736329600, #    local_end 2020-09-21 00:00:00 (Mon)
16200,
1,
'+0430',
    ],
    [
63736313400, #    utc_start 2020-09-20 19:30:00 (Sun)
63752041800, #      utc_end 2021-03-21 20:30:00 (Sun)
63736326000, #  local_start 2020-09-20 23:00:00 (Sun)
63752054400, #    local_end 2021-03-22 00:00:00 (Mon)
12600,
0,
'+0330',
    ],
    [
63752041800, #    utc_start 2021-03-21 20:30:00 (Sun)
63767935800, #      utc_end 2021-09-21 19:30:00 (Tue)
63752058000, #  local_start 2021-03-22 01:00:00 (Mon)
63767952000, #    local_end 2021-09-22 00:00:00 (Wed)
16200,
1,
'+0430',
    ],
    [
63767935800, #    utc_start 2021-09-21 19:30:00 (Tue)
63783577800, #      utc_end 2022-03-21 20:30:00 (Mon)
63767948400, #  local_start 2021-09-21 23:00:00 (Tue)
63783590400, #    local_end 2022-03-22 00:00:00 (Tue)
12600,
0,
'+0330',
    ],
    [
63783577800, #    utc_start 2022-03-21 20:30:00 (Mon)
63799471800, #      utc_end 2022-09-21 19:30:00 (Wed)
63783594000, #  local_start 2022-03-22 01:00:00 (Tue)
63799488000, #    local_end 2022-09-22 00:00:00 (Thu)
16200,
1,
'+0430',
    ],
    [
63799471800, #    utc_start 2022-09-21 19:30:00 (Wed)
DateTime::TimeZone::INFINITY, #      utc_end
63799484400, #  local_start 2022-09-21 23:00:00 (Wed)
DateTime::TimeZone::INFINITY, #    local_end
12600,
0,
'+0330',
    ],
];

sub olson_version {'2025b'}

sub has_dst_changes {34}

sub _max_year {2035}

sub _new_instance {
    return shift->_init( @_, spans => $spans );
}



1;

