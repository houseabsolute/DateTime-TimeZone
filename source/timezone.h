#ifndef __TIMEZONE_H__
#define __TIMEZONE_H__

typedef struct _dtz_span {
    struct _dtz_span *next;
    double            utc_start;
    double            utc_end;
    double            local_start;
    double            local_end;
    double            offset;
    int               is_dst;
    char              short_name[255];
} dtz_span;

#define MAX_NAME_LEN 256

typedef struct _dtz_timezone_state {
    dtz_span **spanset;
    SV        *spanset_count;
    int        spanset_size;
    SV        *max_year;
    SV        *short_name;
    SV        *last_offset;
    SV        *is_olson;
    SV        *max_span;
    int        freed;
    SV *offset; /* Used only for offsetonly */
} dtz_timezone_state;

#ifndef INFINITY
#define INFINITY 1e50f
#endif

#ifndef NEG_INFINITY
#define NEG_INFINITY -1 * INFINITY
#endif

#ifdef NEED_allocTIMEZONE
#define allocTIMEZONE_PREP \
        dtz_timezone_state *state; \
        HV *p; \
        MAGIC *mg; \
        HV *stash; \
        SV **svp;

#define allocTIMEZONE(sv, class, psv) \
        Newz(1234, state, 1, dtz_timezone_state); \
        state->short_name = NULL; \
        \
        sv = newSViv(PTR2IV(state)); \
        sv_magic(sv, 0, '~', 0, 0); \
        mg = mg_find(sv, '~'); \
        assert(mg); \
        stash = gv_stashpv("DateTime::TimeZone", 1); \
        svp = hv_fetch(stash, "_xs_magic_free", 17, 0); \
        if (svp != NULL && SvOK(*svp)) \
            mg->mg_virtual = INT2PTR(MGVTBL *, SvIV(*svp)); \
        \
        sv = newRV_noinc(sv); \
        sv_bless(sv, gv_stashpv(SvPV_nolen(class), 1)); \
        \
        p = (HV *) SvRV(psv); \
        svp = hv_fetch(p, "name", 4, 0); \
        if (svp != NULL && SvOK(*svp)) \
            state->short_name = newSVsv(*svp); \
        \
        svp = hv_fetch(p, "is_olson", 8, 0); \
        if (svp != NULL && SvOK(*svp)) \
            state->is_olson = newSVsv(*svp); \
        \
        SvREADONLY_on(sv);

#define allocTIMEZONE_OFFSETONLY_PREP \
        dtz_timezone_offsetonly_state *state; \
        HV *p; \
        MAGIC *mg; \
        HV *stash; \
        SV **svp;

#define allocTIMEZONE_OFFSETONLY(sv, class, psv) \
        Newz(1234, state, 1, dtz_timezone_state); \
        state->short_name = NULL; \
        sv = newSViv(PTR2IV(state)); \
        sv = newRV_noinc(sv); \
        sv_bless(sv, gv_stashpv(SvPV_nolen(class), 1)); \
        \
        p = (HV *) SvRV(psv); \
        svp = hv_fetch(p, "name", 4, 0); \
        if (svp != NULL && SvOK(*svp)) \
            state->short_name = newSVsv(*svp); \
        \
        svp = hv_fetch(p, "offset", 8, 0); \
        if (svp != NULL && SvOK(*svp)) \
            state->offset = newSVsv(*svp); \
        \
        SvREADONLY_on(sv);

#endif

#define SPAN_START(x, y)   (x ? y->utc_start : y->local_start)
#define SPAN_END(x, y)     (x ? y->utc_end : y->local_end)
#define SPAN2AV(span, av) \
    av = newAV(); \
    if (span) { \
        av_push(av, newSVnv(span->utc_start)); \
        av_push(av, newSVnv(span->utc_end)); \
        av_push(av, newSVnv(span->local_start)); \
        av_push(av, newSVnv(span->local_end)); \
        av_push(av, newSVnv(span->offset)); \
        av_push(av, newSViv(span->is_dst)); \
        av_push(av, newSVpv(span->short_name, strlen(span->short_name))); \
    }

#define INIT_SPAN(span, us, ue, ls, le, o, d, n, n_len) \
    Newz(1234, span, 1, dtz_span); \
    span->utc_start   = us; \
    span->utc_end     = ue; \
    span->local_start = ls; \
    span->local_end   = le; \
    span->offset      = o; \
    span->is_dst      = d; \
    Copy(n, span->short_name, n_len, char);

#define XS_STATE(x) \
    INT2PTR(dtz_timezone_state *, SvROK(x) ? SvIV(SvRV(x)) : SvIV(x))

#define SPAN_ERR(sv, dt, name, use_utc) \
    sv = newSVpv("Invalid local time for date", 27); \
    if (use_utc) { \
        sv_catpv(sv, " ");  \
        \
        dSP;  \
        ENTER;  \
        SAVETMPS;  \
        PUSHMARK(SP);  \
        XPUSHs(dt);  \
        PUTBACK;  \
        \
        call_method("iso8601", G_SCALAR);  \
        \
        SPAGAIN;  \
        \
        sv_catpv(sv, (const char *) SvPV_nolen(POPs));  \
        \
        FREETMPS;  \
        LEAVE;  \
    } \
    sv_catpv(sv, " in time zone: ");  \
    sv_catpv(sv, SvPV_nolen(state->short_name));  \
    sv_catpv(sv, "\n");

#define THROW_ERR(x) \
    sv_setsv(get_sv("@", TRUE), x); \
    croak(Nullch);


#endif
