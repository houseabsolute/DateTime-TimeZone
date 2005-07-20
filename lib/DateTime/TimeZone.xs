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

    state = XS_STATE(self);
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

    state = XS_STATE(sv);
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
    state = XS_STATE(sv);
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
        state = XS_STATE(self);
        RETVAL = newSViv(sizeof(SV) + sizeof(state) + sizeof(state->spanset) * state->spanset_size);
    OUTPUT:
        RETVAL

SV *
name(self)
        SV *self;
    PREINIT:
        dtz_timezone_state *state = NULL;
    CODE:
        state = XS_STATE(self);
        RETVAL = SvREFCNT_inc(state->short_name);
    OUTPUT:
        RETVAL

SV *
is_olson(self)
        SV *self;
    PROTOTYPE: DISABLE
    PREINIT:
        dtz_timezone_state *state = NULL;
    CODE:
        state = XS_STATE(self);
        RETVAL = SvREFCNT_inc(state->is_olson);
    OUTPUT:
        RETVAL

SV *
max_year (self, ...)
        SV *self;
    PREINIT:
        dtz_timezone_state *state = NULL;
    CODE:
        state = XS_STATE(self);
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
        state = XS_STATE(self);
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
max_span(self)
        SV *self;
    PREINIT:
        dtz_timezone_state *state = NULL;
        dtz_span *span;
        AV *av;
    CODE:
        state = XS_STATE(self);
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
        state = XS_STATE(self);

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
        state = XS_STATE(self);
        RETVAL = SvREFCNT_inc(state->offset);
    OUTPUT:
        RETVAL

