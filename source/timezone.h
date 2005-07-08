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

#endif