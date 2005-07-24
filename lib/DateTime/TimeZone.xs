/************************************************************************
 *
 * DateTime::TimeZone
 *
 ************************************************************************/
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#define NEED_newCONSTSUB_GLOBAL
#define NEED_newRV_noinc_GLOBAL
#define NEED_sv_2pv_nolen_GLOBAL
#include "ppport.h"
#define NEED_allocTIMEZONE
#include "timezone.h"

#define SPAN_UTC_START    0
#define SPAN_UTC_END      1
#define SPAN_LOCAL_START  2
#define SPAN_LOCAL_END    3
#define SPAN_OFFSET       4
#define SPAN_IS_DST       5
#define SPAN_SHORT_NAME   6

#define MAX_ON_LEN 15
#define AT_LEN 6
#define SAVE_LEN 6

typedef struct _dtz_olsondb_rule {
    char name[MAX_NAME_LEN];
    int  from;  /* 1974 */
    char to[4]; /* max */
    int  type;  /* ???? */
    char in[4]; /* Oct */
    char on[MAX_ON_LEN + 1]; /* lastSun, Sun>=1, etc */
    char at[AT_LEN + 1]; /* 23:00 */
    char save[SAVE_LEN + 1]; /* 1:00, or \0 */
    char letter;
    SV *offset_from_std; /* seconds */
    int freed;
} dtz_olsondb_rule;

typedef struct _dtz_olsondb_change {
    SV *utc_start_datetime;
    SV *local_start_datetime;
    SV *observance;
    SV *rule;
    char short_name[MAX_NAME_LEN];
    double offset_from_std;
    double offset_from_utc;
    int is_dst;
    int freed;
} dtz_olsondb_change;

static int
magic_free_olsondb_rule_state(pTHX_ SV *sv, MAGIC *mg)
{
    dtz_olsondb_rule *state = XS_STATE(dtz_olsondb_rule *, sv);
    if (!state->freed && state != NULL) {
        state->freed++;
        Safefree(state);
    }
    return 1;
}

MGVTBL vtbl_free_olsondb_rule_state = { 0, 0, 0, 0, MEMBER_TO_FPTR(magic_free_olsondb_rule_state) };
    
static int
magic_free_olsondb_change_state(pTHX_ SV *sv, MAGIC *mg)
{
    dtz_olsondb_change *state = XS_STATE(dtz_olsondb_change *, sv);

    if (!state->freed && state != NULL) {
        state->freed++;
        Safefree(state);
    }
    return 1;
}

MGVTBL vtbl_free_olsondb_change_state = { 0, 0, 0, 0, MEMBER_TO_FPTR(magic_free_olsondb_change_state) };
    
static dtz_span *
_real_spans_binary_search(pTHX_ SV *self, int use_utc, NV v)
{
    int min;
    int max;
    int i;
    int c;
    double start;
    double end;
    dtz_span *span = NULL;
    dtz_span *s = NULL;
    dtz_span *next = NULL;
    dtz_timezone_state *state = NULL;

    dSP;

    state = XS_STATE(dtz_timezone_state *, self);
    min = 0;
    max = SvIV(state->spanset_count) + 1;

    i   = (int) (max / 2);
    if (max % 2 && max != 3)
        i++;
    if (SvIV(state->spanset_count) == 1)
        i = 0;

    while (span == NULL) {
        s     = state->spanset[i];
        start = SPAN_START(use_utc, s);
        end   = SPAN_END(use_utc, s);
        if (v < start) {
            max = i;
            c = (int) ( (i - min) / 2);
            if (c == 0)
                c = 1;
            i -= c;

            if (i < min)
                return NULL;
        } else if (v >= end) {
            min = i;
            c = (int) ( (max - i) / 2 );
            if (c == 0)
                c = 1;
            i += c;

            if (i >= max)
                return NULL;
        } else {
            /* Special case for overlapping ranges because of DST and
             * other weirdness (like Alaska's change when bought from
             * Russia by the US). Always prefer latest span.
             */
            if (s->is_dst && !use_utc) {
                /* Sometimes we will get here and the span we're
                 * looking at is the last that's been generated so far.
                 * We need to try to generate one more or else we run out.
                 */
                if (i >= max) {
                    ENTER;
                    SAVETMPS;
                    PUSHMARK(SP);
                    XPUSHs(self);
                    PUTBACK;

                    call_method("_generate_next_span", G_VOID);

                    FREETMPS;
                    LEAVE;
                }
                next = state->spanset[i + 1];
                if (! next->is_dst && 
                      SPAN_START(use_utc, next) <= v &&
                      v <= SPAN_END(use_utc, next)) {
                    span = next;
                }
            }

            if (!span)
                span = s;
        }
    }

    return span;
}

static SV *
_span_for_datetime(pTHX_ SV *sv, int use_utc, SV *dt)
{
    char *as_seconds_method = NULL;
    SV *ret = NULL;
    AV *av = NULL;
    I32 count;
    NV seconds;
    IV until;
    dtz_span *span;
    dtz_timezone_state *state;

    state = XS_STATE(dtz_timezone_state *, sv);
    as_seconds_method = use_utc ?
        "utc_rd_as_seconds" : "local_rd_as_seconds";

    dSP;
    ENTER;
    SAVETMPS;
    PUSHMARK(SP);
    XPUSHs(dt);
    PUTBACK;

    count = call_method(as_seconds_method, G_SCALAR);
    SPAGAIN;

    seconds = POPn;

    PUTBACK;
    FREETMPS;
    LEAVE;

    span = state->spanset[SvIV(state->spanset_count) - 1];
    if (seconds < SPAN_END(use_utc, span)) {
        span = _real_spans_binary_search(aTHX_ sv, use_utc, seconds);
        if (span != NULL) {
            SPAN2AV(span, av);
            ret = newRV_noinc((SV *) av);
        }
    } else {
        SPAGAIN;

        ENTER;
        SAVETMPS;
        PUSHMARK(SP);
        XPUSHs(dt);
        PUTBACK;

        count = call_method("utc_year", G_SCALAR);
        SPAGAIN;

        until = POPi;

        PUTBACK;
        FREETMPS;
        LEAVE;

        SPAGAIN;

        ENTER;
        SAVETMPS;
        PUSHMARK(SP);
        XPUSHs(sv);
        XPUSHs(sv_2mortal(newSViv(until + 1)));
        XPUSHs(sv_2mortal(newSVnv(seconds)));
        XPUSHs(sv_2mortal(use_utc ? newSVpv("utc", 3) : newSVpv("local", 5)));
        PUTBACK;

        count = call_method("_generate_spans_until_match", G_SCALAR|G_EVAL);
        SPAGAIN;

        if (! SvTRUE(ERRSV)) {
            ret = POPs;
            if (SvOK(ret))
                ret = newSVsv(ret);
            else 
                ret = NULL;
        }

        PUTBACK;
        FREETMPS;
        LEAVE;
    }

    if (ret == NULL) {
        SPAN_ERR(sv, dt, state->short_name, use_utc);
        THROW_ERR(sv);
    }

    return ret;
}

static int
magic_free_timezone_state(pTHX_ SV *sv, MAGIC *mg)
{
    dtz_timezone_state *state = NULL;
    state = XS_STATE(dtz_timezone_state *, sv);
    if (!state->freed && state != NULL) {
        state->freed++;
        if (SvOK(state->max_span))
            SvREFCNT_dec(state->max_span);

        if (SvOK(state->short_name))
            SvREFCNT_dec(state->short_name);

        if (state->spanset != NULL)
            Safefree(state->spanset);
    }
    return 1;
}

MGVTBL vtbl_free_timezone_state = { 0, 0, 0, 0, MEMBER_TO_FPTR(magic_free_timezone_state) };
    
static void
bootinit()
{
    HV *stash;

    stash = gv_stashpv("DateTime::TimeZone", 1);
    newCONSTSUB(stash, "is_floating", newSViv(0));
    newCONSTSUB(stash, "is_utc", newSViv(0));
    newCONSTSUB(stash, "LOADED_XS", newSViv(1));
    newCONSTSUB(stash, "UTC_START", newSViv(SPAN_UTC_START));
    newCONSTSUB(stash, "UTC_END", newSViv(SPAN_UTC_END));
    newCONSTSUB(stash, "LOCAL_START", newSViv(SPAN_LOCAL_START));
    newCONSTSUB(stash, "LOCAL_END", newSViv(SPAN_LOCAL_END));
    newCONSTSUB(stash, "OFFSET", newSViv(SPAN_OFFSET));
    newCONSTSUB(stash, "IS_DST", newSViv(SPAN_IS_DST));
    newCONSTSUB(stash, "SHORT_NAME", newSViv(SPAN_SHORT_NAME));

    /* load destructor into stash, because subclasses which are implemented
     * in XS (in other files) cannot reach it without duplicating it
     */
    hv_store(stash, "_xs_magic_free", 14, newSViv(PTR2IV(&vtbl_free_timezone_state)), 0);

    stash = gv_stashpv("DateTime::TimeZone::UTC", 1);
    newCONSTSUB(stash, "is_dst_for_datetime", newSViv(0));
    newCONSTSUB(stash, "offset_for_datetime", newSViv(0));
    newCONSTSUB(stash, "offset_for_local_datetime", newSViv(0));
    newCONSTSUB(stash, "short_name_for_datetime", newSVpv("UTC", 3));
    newCONSTSUB(stash, "category", &PL_sv_undef);
    newCONSTSUB(stash, "is_olson", newSViv(0));
    newCONSTSUB(stash, "is_utc", newSViv(1));
    newCONSTSUB(stash, "name", newSVpv("UTC", 3));

    stash = gv_stashpv("DateTime::TimeZone::OffsetOnly", 1);
    newCONSTSUB(stash, "is_dst_for_datetime", newSViv(0));
    newCONSTSUB(stash, "is_olson", newSViv(0));
    newCONSTSUB(stash, "category", &PL_sv_undef);

    stash = gv_stashpv("DateTime::TimeZone::Floating", 1);
    newCONSTSUB(stash, "is_floating", newSViv(1));

    stash = gv_stashpv("DateTime::TimeZone::OlsonDB", 1);
    newCONSTSUB(stash, "LOADED_XS", newSViv(1));
}

MODULE = DateTime::TimeZone     PACKAGE = DateTime::TimeZone

PROTOTYPES: ENABLE

BOOT:
    bootinit();

SV *
_init(class, psv)
        SV *class;
        SV *psv;
    PREINIT:
        allocTIMEZONE_PREP;
        SV *sv;
    CODE:
        allocTIMEZONE(sv, class, psv);
        RETVAL = sv;
    OUTPUT:
        RETVAL

SV *
total_size(self)
        SV *self;
    PREINIT:
        dtz_timezone_state *state = NULL;
    CODE:
        state = XS_STATE(dtz_timezone_state *, self);
        RETVAL = newSViv(sizeof(SV) + sizeof(state) + sizeof(state->spanset) * state->spanset_size);
    OUTPUT:
        RETVAL

SV *
name(self)
        SV *self;
    PREINIT:
        dtz_timezone_state *state = NULL;
    CODE:
        state = XS_STATE(dtz_timezone_state *, self);
        RETVAL = SvREFCNT_inc(state->short_name);
    OUTPUT:
        RETVAL

SV *
category(self)
        SV *self;
    PREINIT:
        dtz_timezone_state *state = NULL;
        char *p;
        char *n;
        STRLEN len;
    CODE:
        state = XS_STATE(dtz_timezone_state *, self);
        n = p = SvPV(state->short_name, len);
        while ( p - n <= len && *p != '/') p++;

        if (p - n < len)
            RETVAL = newSVpv(n, p - n);
        else 
            RETVAL = &PL_sv_undef;
    OUTPUT:
        RETVAL

SV *
is_olson(self)
        SV *self;
    PROTOTYPE: DISABLE
    PREINIT:
        dtz_timezone_state *state = NULL;
    CODE:
        state = XS_STATE(dtz_timezone_state *, self);
        RETVAL = SvREFCNT_inc(state->is_olson);
    OUTPUT:
        RETVAL

SV *
max_year (self, ...)
        SV *self;
    PREINIT:
        dtz_timezone_state *state = NULL;
    CODE:
        state = XS_STATE(dtz_timezone_state *, self);
        RETVAL = SvREFCNT_inc(state->max_year);
        if (items > 1) 
            state->max_year = newSVsv(ST(1));
    OUTPUT:
        RETVAL

SV *
last_offset (self)
        SV *self;
    PREINIT:
        dtz_timezone_state *state = NULL;
    CODE:
        state = XS_STATE(dtz_timezone_state *, self);
        RETVAL = SvREFCNT_inc(state->last_offset);
    OUTPUT:
        RETVAL

SV *
short_name_for_datetime(self, dt)
        SV *self;
        SV *dt;
    PREINIT:
        SV *ret;
    CODE:
        ret = _span_for_datetime(aTHX_ self, 1, dt);
        RETVAL = newSVsv(*(av_fetch((AV *) SvRV(ret), SPAN_SHORT_NAME, 0)));
    OUTPUT:
        RETVAL

SV *
is_dst_for_datetime(self, dt)
        SV *self;
        SV *dt;
    PREINIT:
        SV *ret;
    CODE:
        ret = _span_for_datetime(aTHX_ self, 1, dt);
        RETVAL = newSVsv(*(av_fetch((AV *) SvRV(ret), SPAN_IS_DST, 0)));
    OUTPUT:
        RETVAL

SV *
offset_for_datetime(self, dt)
        SV *self;
        SV *dt;
    PREINIT:
        SV *ret;
    CODE:
        ret = _span_for_datetime(aTHX_ self, 1, dt);
        RETVAL = newSVsv(*(av_fetch((AV *) SvRV(ret), SPAN_OFFSET, 0)));
    OUTPUT:
        RETVAL

SV *
offset_for_local_datetime(self, dt)
        SV *self;
        SV *dt;
    PREINIT:
        SV *ret;
    CODE:
        ret = _span_for_datetime(aTHX_ self, 0, dt);
        RETVAL = newSVsv(*(av_fetch((AV *) SvRV(ret), SPAN_OFFSET, 0)));
    OUTPUT:
        RETVAL

SV *
_span_for_datetime(self, type, dt)
        SV *self;
        SV *type;
        SV *dt;
    PREINIT:
        SV *ret;
    CODE:
        ret = _span_for_datetime(aTHX_ self, strEQ(SvPV_nolen(type), "utc"), dt);
        if (ret == NULL) {
            croak("Invalid local time for date");
        }

        RETVAL = SvREFCNT_inc(ret);
    OUTPUT:
        RETVAL

SV *
_spans_binary_search(self, type, seconds)
        SV *self;
        SV *type;
        SV *seconds;
    PREINIT:
        int use_utc;
        double v;
        AV *ret;
        dtz_span *span;
    CODE:
        use_utc = strEQ(SvPV_nolen(type), "utc");
        v = SvNV(seconds);

        span = _real_spans_binary_search(aTHX_ self, use_utc, v);
        if (span == NULL) {
            RETVAL = &PL_sv_undef;
        } else {
            SPAN2AV(span, ret);
            RETVAL = newRV_noinc((SV *) ret);
        }
    OUTPUT:
        RETVAL

SV *
offset_as_string(offset)
        SV *offset;
    PREINIT:
        int offset_x;
        char sign;
        int hours;
        int mins;
        int secs;
    CODE:
        if (! SvOK(offset))
            XSRETURN_UNDEF;

        offset_x = SvIV(offset);
        if (offset_x < -359999 || offset_x > 359999)
            XSRETURN_UNDEF;

        sign = offset_x >= 0 ? '+' : '-';

        offset_x  = abs(offset_x);
        hours     = (int) (offset_x / 3600);
        offset_x %= 3600;
        mins      = (int) (offset_x / 60);
        offset_x %= 60;
        secs      = (int) offset_x;

        RETVAL = secs ?
            newSVpvf("%c%02d%02d%02d", sign, hours, mins, secs) :
            newSVpvf("%c%02d%02d", sign, hours, mins);
    OUTPUT:
        RETVAL

SV *
offset_as_seconds(offset)
        SV *offset;
    PREINIT:
        char *p;
        char *ptr;
        char *ph;
        char o_comp[3];
        STRLEN o_len;
        STRLEN len;
        IV h, m, s, sign, has_colon;
    CODE:
        if (! SvOK(offset))
            XSRETURN_UNDEF;

        p = SvPV(offset, len);
        if (len == 1 && *p == '0')
            XSRETURN_IV(0);

        sign = 1;
        if (*p == '+') {
            sign = 1;
            p++;
            len--;
        } else if (*p == '-') {
            sign = -1;
            p++;
            len--;
        }
        h = m = -1;
        s = 0;

        ph = ptr = p;

        has_colon = 0;
        while (*ptr != '\0') {
            if (*ptr != ':' && !isDIGIT(*ptr))
                XSRETURN_UNDEF;

            if (*ptr == ':') {
                has_colon = 1;
            }
            ptr++;
        }
        ptr = p;

        if (! has_colon) {
            if (len != 4 && len != 6) 
                XSRETURN_UNDEF;

            Copy(ptr, o_comp, 2, char);
            *(o_comp + 2) = '\0';
            h = Strtol(o_comp, NULL, 10);
    
            ptr += 2;
            Copy(ptr, o_comp, 2, char);
            *(o_comp + 2) = '\0';
            m = Strtol(o_comp, NULL, 10);

            if (len == 6) {
                ptr += 2;
                Copy(ptr, o_comp, 2, char);
                *(o_comp + 2) = '\0';
                s = Strtol(o_comp, NULL, 10);
            }
        } else {
            while (*ptr != '\0' && *ptr != ':') ptr++;
            /* make sure 1 <= ptr - p <= 2. */
            o_len = ptr - p;

            if (o_len < 1 || o_len > 2)
                XSRETURN_UNDEF;

            Copy(p, o_comp, o_len, char);
            *(o_comp + o_len) = '\0';

            h = Strtol(o_comp, NULL, 10);
            p = ++ptr;
            while (*ptr != '\0' && *ptr != ':') ptr++;

            /* make sure p - ptr == 2 */
            if (ptr - p != 2)
                XSRETURN_UNDEF;

            Copy(p, o_comp, 2, char);
            *(o_comp + 2) = '\0';
            m = Strtol(o_comp, NULL, 10);
            /* seconds is optional here. however, if left, we MUST
             * have 3 characters left
             */
            if (ptr - ph + 3 == len) {
                if (*ptr != ':')
                    XSRETURN_UNDEF;

                p = ptr + 1;
                while (*ptr != '\0') ptr++;
                if (ptr - p != 2)
                    XSRETURN_UNDEF;

                Copy(p, o_comp, 2, char);
                *(o_comp + 2) = '\0';
                s = Strtol(o_comp, NULL, 10);
            } else if (ptr - ph != len) {
                return XSRETURN_UNDEF;
            }
        }

        if (h < 0 || h > 99 || m < 0 || m > 59 || s < 0 || s > 59)
            XSRETURN_UNDEF;

        RETVAL = newSVnv(( (double) h * 3600 + m * 60 + s ) * sign);
    OUTPUT:
        RETVAL

SV *
max_span(self)
        SV *self;
    PREINIT:
        dtz_timezone_state *state = NULL;
        dtz_span *span;
        AV *av;
    CODE:
        state = XS_STATE(dtz_timezone_state *, self);
        if (state->max_span == NULL) {
            span = state->spanset[SvIV(state->spanset_count) - 1];
            SPAN2AV(span, av);
            state->max_span = newRV_noinc((SV *) av);
        }
        RETVAL = SvREFCNT_inc(state->max_span);
    OUTPUT:
        RETVAL

void
push_span(self, span_data)
        SV *self;
        AV *span_data;
    PREINIT:
        dtz_timezone_state *state = NULL;
        dtz_span  *span;
        SV       **svp;
        STRLEN     len;
        char      *short_name;
    CODE:
        state = XS_STATE(dtz_timezone_state *, self);

        Newz(1234, span, 1, dtz_span);

        svp = av_fetch(span_data, 0, 0);
        span->utc_start   = svp ? SvNV(*svp) : 0;

        svp = av_fetch(span_data, 1, 0);
        span->utc_end     = svp ? SvNV(*svp) : 0;

        svp = av_fetch(span_data, 2, 0);
        span->local_start = svp ? SvNV(*svp) : 0;

        svp = av_fetch(span_data, 3, 0);
        span->local_end   = svp ? SvNV(*svp) : 0;

        svp = av_fetch(span_data, 4, 0);
        span->offset      = svp ? SvNV(*svp) : 0;

        svp = av_fetch(span_data, 5, 0);
        span->is_dst      = svp && SvOK(*svp) ? SvTRUE(*svp) : 0;

        svp = av_fetch(span_data, 6, 0);
        if (!svp) 
            croak("No name supplied");
        short_name = SvPV(*svp, len);
        Copy(short_name, span->short_name, len, char);

        if (state->spanset_size <= SvIV(state->spanset_count)) {
            state->spanset_size += 8;
            Renew(state->spanset, state->spanset_size, dtz_span *);
        }

        state->spanset[SvIV(state->spanset_count)] = span;
        sv_setiv(state->spanset_count, SvIV(state->spanset_count) + 1);
        SvREFCNT_dec(state->max_span);
        state->max_span = NULL;

MODULE = DateTime::TimeZone   PACKAGE = DateTime::TimeZone::OffsetOnly

PROTOTYPES: ENABLE

SV *
_init(class, psv)
        SV *class;
        SV *psv;
    PREINIT:
        allocTIMEZONE_PREP;
        SV *sv;
    CODE:
        allocTIMEZONE_OFFSETONLY(sv, class, psv);
        RETVAL = sv;
    OUTPUT:
        RETVAL

SV *
offset(self)
        SV *self;
    PREINIT:
        dtz_timezone_state *state = NULL;
    CODE:
        state = XS_STATE(dtz_timezone_state *, self);
        RETVAL = SvREFCNT_inc(state->offset);
    OUTPUT:
        RETVAL

MODULE = DateTime::TimeZone   PACKAGE = DateTime::TimeZone::OlsonDB::Rule

PROTOTYPES: ENABLE

SV *
_init(class, psv);
        SV *class;
        SV *psv;
    PREINIT:
        SV **svp;
        dtz_olsondb_rule *state;
        SV *sv;
        MAGIC *mg;
        HV *p;
        HV *stash;
        STRLEN len;
        char *v;
    CODE:
        sv = SvRV(psv);
        if (!sv || SvTYPE(sv) != SVt_PVHV) {
            croak("Not a reference to a hash");
        }
        p = (HV *) sv;

        Newz(1234, state, 1, dtz_olsondb_rule);
        *(state->name) = '\0';
        *(state->to) = '\0';
        *(state->in) = '\0';
        *(state->on) = '\0';
        *(state->at) = '\0';
        *(state->save) = '\0';

        svp = hv_fetch(p, "name", 4, 0);
        if (svp != NULL && SvOK(*svp))
            Copy(SvPV(*svp, len), state->name, len, char);

        svp = hv_fetch(p, "to", 2, 0);
        if (svp != NULL && SvOK(*svp))
            Copy(SvPV(*svp, len), state->to, len, char);

        svp = hv_fetch(p, "in", 2, 0);
        if (svp != NULL && SvOK(*svp))
            Copy(SvPV(*svp, len), state->in, len, char);

        svp = hv_fetch(p, "on", 2, 0);
        if (svp != NULL && SvOK(*svp))
            Copy(SvPV(*svp, len), state->on, len, char);

        svp = hv_fetch(p, "at", 2, 0);
        if (svp != NULL && SvOK(*svp))
            Copy(SvPV(*svp, len), state->at, len, char);

        svp = hv_fetch(p, "save", 4, 0);
        if (svp != NULL && SvOK(*svp))
            Copy(SvPV(*svp, len), state->save, len, char);

        svp = hv_fetch(p, "from", 4, 0);
        if (svp != NULL && SvOK(*svp))
            state->from = SvIV(*svp);

        svp = hv_fetch(p, "letter", 6, 0);
        if (svp != NULL && SvOK(*svp))
            state->letter = *(SvPV(*svp, len));

        svp = hv_fetch(p, "offset_from_std", 15, 0);
        if (svp != NULL && SvOK(*svp))
            state->offset_from_std = SvREFCNT_inc(newSVsv(*svp));

        state->type = 0;
        state->freed = 0;

        sv = newSViv(PTR2IV(state));
        sv_magic(sv, 0, '~', 0, 0);
        mg = mg_find(sv, '~');
        assert(mg);
        mg->mg_virtual = &vtbl_free_olsondb_rule_state;

        stash = gv_stashpv(SvPV_nolen(class), 1);
        sv = newRV_inc(sv);
        sv_bless(sv, stash);

        SvREADONLY_on(sv);

        RETVAL = sv;
    OUTPUT:
        RETVAL

SV *
name(self)
        SV *self;
    PREINIT:
        dtz_olsondb_rule *state = XS_STATE(dtz_olsondb_rule *,self);
    CODE:
        RETVAL = newSVpv(state->name, strlen(state->name));
    OUTPUT:
        RETVAL

SV *
to(self)
        SV *self;
    PREINIT:
        dtz_olsondb_rule *state = XS_STATE(dtz_olsondb_rule *,self);
    CODE:
        RETVAL = newSVpv(state->to, strlen(state->to));
    OUTPUT:
        RETVAL

SV *
on(self)
        SV *self;
    PREINIT:
        dtz_olsondb_rule *state = XS_STATE(dtz_olsondb_rule *,self);
    CODE:
        RETVAL = newSVpv(state->on, strlen(state->on));
    OUTPUT:
        RETVAL

SV *
in(self)
        SV *self;
    PREINIT:
        dtz_olsondb_rule *state = XS_STATE(dtz_olsondb_rule *,self);
    CODE:
        RETVAL = newSVpv(state->in, strlen(state->in));
    OUTPUT:
        RETVAL


SV *
at(self)
        SV *self;
    PREINIT:
        dtz_olsondb_rule *state = XS_STATE(dtz_olsondb_rule *,self);
    CODE:
        RETVAL = newSVpv(state->at, strlen(state->at));
    OUTPUT:
        RETVAL

SV *
from(self)
        SV *self;
    PREINIT:
        dtz_olsondb_rule *state = XS_STATE(dtz_olsondb_rule *,self);
    CODE:
        RETVAL = newSViv(state->from);
    OUTPUT:
        RETVAL

SV *
min_year(self);
        SV *self;
    PREINIT:
        dtz_olsondb_rule *state = XS_STATE(dtz_olsondb_rule *,self);
    CODE:
        RETVAL = newSViv(state->from);
    OUTPUT:
        RETVAL

SV *
letter(self)
        SV *self;
    PREINIT:
        dtz_olsondb_rule *state = XS_STATE(dtz_olsondb_rule *,self);
    CODE:
        RETVAL = newSVpv(&state->letter, 1);
    OUTPUT:
        RETVAL

SV *
offset_from_std(self)
        SV *self;
    PREINIT:
        dtz_olsondb_rule *state = XS_STATE(dtz_olsondb_rule *,self);
    CODE:
        RETVAL = SvREFCNT_inc(state->offset_from_std); 
    OUTPUT:
        RETVAL

SV *
is_infinite(self)
        SV *self;
    PREINIT:
        dtz_olsondb_rule *state = XS_STATE(dtz_olsondb_rule *,self);
    CODE:
        RETVAL = strEQ("max", state->to) ? &PL_sv_yes : &PL_sv_undef;;
    OUTPUT:
        RETVAL

SV *
max_year(self)
        SV *self;
    PREINIT:
        dtz_olsondb_rule *state = XS_STATE(dtz_olsondb_rule *,self);
    CODE:
        RETVAL = strEQ("only", state->to) ? newSViv(state->from) :
            strEQ("max", state->to) ? &PL_sv_undef :
            newSVpv(state->to, strlen(state->to));
    OUTPUT:
        RETVAL

MODULE = DateTime::TimeZone    PACKAGE = DateTime::TimeZone::OlsonDB::Change

PROTOTYPES: ENABLE

SV *
_init(class, psv)
        SV *class;
        SV *psv;
    PREINIT:
        SV *sv;
        SV **svp;
        HV *p;
        HV *stash;
        MAGIC *mg;
        STRLEN len;
        dtz_olsondb_change *state;
    CODE:
        sv = SvRV(psv);
        if (!sv || SvTYPE(sv) != SVt_PVHV) {
            croak("Not a reference to a hash");
        }
        p = (HV *) sv;

        Newz(1234, state, 1, dtz_olsondb_change);
        state->utc_start_datetime = NULL;
        state->local_start_datetime = NULL;
        state->observance = NULL;
        state->rule = NULL;
        state->freed = 0;
        *(state->short_name) = '\0';

        svp = hv_fetch(p, "utc_start_datetime", 18, 0);
        if (svp != NULL && SvROK(*svp) && sv_derived_from(*svp, "DateTime"))
            state->utc_start_datetime = SvREFCNT_inc(*svp);

        svp = hv_fetch(p, "local_start_datetime", 20, 0);
        if (svp != NULL && SvROK(*svp) && sv_derived_from(*svp, "DateTime"))
            state->local_start_datetime = SvREFCNT_inc(*svp);

        svp = hv_fetch(p, "short_name", 10, 0);
        if (svp != NULL && SvOK(*svp))
            Copy(SvPV(*svp, len), state->short_name, len, char);

        svp = hv_fetch(p, "observance", 10, 0);
        if (svp != NULL && SvOK(*svp)) 
            state->observance = SvREFCNT_inc(*svp);

        svp = hv_fetch(p, "rule", 4, 0);
        if (svp != NULL && SvOK(*svp)) 
            state->rule = SvREFCNT_inc(*svp);

        svp = hv_fetch(p, "is_dst", 6, 0);
        if (svp != NULL && SvOK(*svp))
            state->is_dst = SvTRUE(*svp);

        svp = hv_fetch(p, "offset_from_std", 15, 0);
        if (svp != NULL && SvOK(*svp))
            state->offset_from_std = SvNV(*svp);

        svp = hv_fetch(p, "offset_from_utc", 15, 0);
        if (svp != NULL && SvOK(*svp))
            state->offset_from_utc = SvNV(*svp);

        sv = newSViv(PTR2IV(state));
        sv_magic(sv, 0, '~', 0, 0);
        mg = mg_find(sv, '~');
        assert(mg);
        mg->mg_virtual = &vtbl_free_olsondb_change_state;

        sv = newRV_inc(sv);
        stash = gv_stashpv("DateTime::TimeZone::OlsonDB::Change", 1);
        sv_bless(sv, stash);
        SvREADONLY_on(sv);

        RETVAL = sv;
    OUTPUT:
        RETVAL

SV *
utc_start_datetime (self)
        SV *self;
    PREINIT:
        dtz_olsondb_change *state = NULL;
    CODE:
        state = XS_STATE(dtz_olsondb_change *, self);
        RETVAL = SvREFCNT_inc(state->utc_start_datetime);
    OUTPUT:
        RETVAL

SV *
local_start_datetime (self)
        SV *self;
    PREINIT:
        dtz_olsondb_change *state = NULL;
    CODE:
        state = XS_STATE(dtz_olsondb_change *, self);
        RETVAL = SvREFCNT_inc(state->local_start_datetime);
    OUTPUT:
        RETVAL

SV *
short_name (self)
        SV *self;
    PREINIT:
        dtz_olsondb_change *state = NULL;
    CODE:
        state = XS_STATE(dtz_olsondb_change *, self);
        RETVAL = newSVpv(state->short_name, strlen(state->short_name));
    OUTPUT:
        RETVAL

SV *
observance (self)
        SV *self;
    PREINIT:
        dtz_olsondb_change *state = NULL;
    CODE:
        state = XS_STATE(dtz_olsondb_change *, self);
        RETVAL = SvREFCNT_inc(state->observance);
    OUTPUT:
        RETVAL

SV *
rule (self)
        SV *self;
    PREINIT:
        dtz_olsondb_change *state = NULL;
    CODE:
        state = XS_STATE(dtz_olsondb_change *, self);
        RETVAL = SvREFCNT_inc(state->rule);
    OUTPUT:
        RETVAL

SV *
is_dst (self)
        SV *self;
    PREINIT:
        dtz_olsondb_change *state = NULL;
    CODE:
        state = XS_STATE(dtz_olsondb_change *, self);
        RETVAL = state->is_dst ? &PL_sv_yes : &PL_sv_no;
    OUTPUT:
        RETVAL

SV *
offset_from_std (self)
        SV *self;
    PREINIT:
        dtz_olsondb_change *state = NULL;
    CODE:
        state = XS_STATE(dtz_olsondb_change *, self);
        RETVAL = newSVnv(state->offset_from_std);
    OUTPUT:
        RETVAL

SV *
offset_from_utc (self)
        SV *self;
    PREINIT:
        dtz_olsondb_change *state = NULL;
    CODE:
        state = XS_STATE(dtz_olsondb_change *, self);
        RETVAL = newSVnv(state->offset_from_utc);
    OUTPUT:
        RETVAL

SV *
total_offset (self)
        SV *self;
    PREINIT:
        dtz_olsondb_change *state = NULL;
    CODE:
        state = XS_STATE(dtz_olsondb_change *, self);
        RETVAL = newSVnv(state->offset_from_utc + state->offset_from_std);
    OUTPUT:
        RETVAL

SV *
two_changes_as_span (c1, c2, last_total_offset)
        SV *c1;
        SV *c2;
        SV *last_total_offset;
    PROTOTYPE: DISABLE
    PREINIT:
        HV *hv;
        SV *utc_start;
        SV *utc_end;
        SV *local_start;
        SV *local_end;
        double offset;
        dtz_olsondb_change *c1state;
        dtz_olsondb_change *c2state;
        SV *utc_start_datetime;
        SV *dt;
        double t;
    CODE:
        dSP;

        hv = newHV();

        c1state = XS_STATE(dtz_olsondb_change *, c1);
        c2state = XS_STATE(dtz_olsondb_change *, c2);

        utc_start_datetime = c1state->utc_start_datetime;
        if (SvROK(utc_start_datetime) && sv_derived_from(utc_start_datetime, "DateTime")) {
            dt = c1state->utc_start_datetime;

            ENTER;
            SAVETMPS;
            PUSHMARK(SP);
            XPUSHs(dt);
            PUTBACK;
        
            call_method("utc_rd_as_seconds", G_SCALAR);
            utc_start = newSVnv(POPn);

            FREETMPS;
            LEAVE;
        
            dt = c1state->local_start_datetime;

            ENTER;
            SAVETMPS;
            PUSHMARK(SP);
            XPUSHs(dt);
            PUTBACK;
        
            call_method("utc_rd_as_seconds", G_SCALAR);
            local_start = newSVnv(POPn);
        
            FREETMPS;
            LEAVE;
        } else {
            utc_start = newSVpv("-inf", 4);
            local_start = newSVpv("-inf", 4);
        }

        dt = c2state->utc_start_datetime;

        ENTER;
        SAVETMPS;
        PUSHMARK(SP);
        XPUSHs(dt);
        PUTBACK;
    
        call_method("utc_rd_as_seconds", G_SCALAR);
        utc_end = newSVnv(POPn);

        SPAGAIN;
    
        FREETMPS;
        LEAVE;

        offset  = c1state->offset_from_utc + c1state->offset_from_std;
        t       = SvNV(utc_end);
        t      += offset;
        local_end = newSVnv(t);

        hv_store(hv, "utc_start", 9, SvREFCNT_inc(utc_start), 0);
        hv_store(hv, "utc_end", 7, SvREFCNT_inc(utc_end), 0);
        hv_store(hv, "local_start", 11, SvREFCNT_inc(local_start), 0);
        hv_store(hv, "local_end", 9, SvREFCNT_inc(local_end), 0);
        hv_store(hv, "short_name", 10, SvREFCNT_inc(newSVpv(c1state->short_name, strlen(c1state->short_name))), 0);
        hv_store(hv, "offset", 6, SvREFCNT_inc(newSVnv(offset)), 0);
        hv_store(hv, "is_dst", 6, c1state->is_dst ? &PL_sv_yes : &PL_sv_no, 0);
        RETVAL = newRV_noinc((SV *) hv);
    OUTPUT:
        RETVAL


