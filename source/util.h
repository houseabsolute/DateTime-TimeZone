#ifndef __DTZ_UTIL_H__
#define __DTZ_UTIL_H__

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "timezone.h"

AV * util_spans_binary_search( SV *self, SV *type, SV *seconds, dtz_span **spanset, int spanset_count);

#endif
