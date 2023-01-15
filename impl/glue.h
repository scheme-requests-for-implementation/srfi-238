#include <errno.h>
#include <signal.h>
#include <stdio.h>
#include <string.h>

static char *numbers(const int *vector)
{
    static char buffer[4096];
    char *append;
    size_t i;
    int number;

    memset(buffer, 0, sizeof(buffer));
    append = buffer;
    for (i = 0; ((number = vector[i]) != 0); i++) {
        snprintf(append, sizeof(buffer) - (append - buffer), "%d,", number);
        append = strchr(append, 0);
    }
    return buffer;
}

#undef XX
#define XX(name) #name ","

static char *errno_symbols(void)
{
    return
#include "errnolist.h"
        ;
}

static char *signal_symbols(void)
{
    return
#include "signallist.h"
        ;
}

#undef XX
#define XX(name) name,

static char *errno_numbers(void)
{
    static const int vector[] = {
#include "errnolist.h"
        0
    };
    return numbers(vector);
}

static char *signal_numbers(void)
{
    static const int vector[] = {
#include "signallist.h"
        0
    };
    return numbers(vector);
}
