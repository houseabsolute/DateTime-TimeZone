#ifndef __DTZ_UTIL_C__
#define __DTZ_UTIL_C__

#include "util.h"

AV *
util_spans_binary_search(
    SV *self, 
    SV *type,
    SV *seconds,
    dtz_span **spanset,
    int spanset_count
) {
    dtz_span *span = NULL;
    dtz_span *s = NULL;
    dtz_span *next = NULL;
    double start;
    double end;
    int i;
    int c;
    int min;
    int max;
    int use_utc;
    double v;
    AV *ret;

    dSP;

    use_utc = strEQ(SvPV_nolen(type), "utc");
    v = SvNV(seconds);

    min = 0;
    max = spanset_count + 1;
    i   = (int) (max / 2);
    if (max % 2 && max != 3)
        i++;
    if (spanset_count == 1) 
        i = 0;

    while (span == NULL) {
        s     = spanset[i];
        start = use_utc ? s->utc_start : s->local_start;
        end   = use_utc ? s->utc_end   : s->local_end;
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
                next = spanset[i + 1];
                if (! next->is_dst &&
                      (use_utc ? next->utc_start : next->local_start) <= v &&
                      v <= (use_utc ? next->utc_end : next->local_end)) {
                    span = next;
                }
            }

            if (!span)
                span = s;
        }
    }

    ret = newAV();
    if (span) {
        av_push(ret, newSVnv(span->utc_start));
        av_push(ret, newSVnv(span->utc_end));
        av_push(ret, newSVnv(span->local_start));
        av_push(ret, newSVnv(span->local_end));
        av_push(ret, newSVnv(span->offset));
        av_push(ret, newSViv(span->is_dst));
        av_push(ret, newSVpv(span->short_name, strlen(span->short_name)));
    }
    return ret;
}

#endif
