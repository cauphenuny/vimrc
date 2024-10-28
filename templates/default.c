#include <ctype.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#define debugf(...) fprintf(stderr, __VA_ARGS__)
#if defined(__clang__) || defined(__GNUC__)
#define debugv(fmt, ...) \
    fprintf(stderr, "%s:%d: " fmt "\n", __func__, __LINE__, ##__VA_ARGS__)
#else
#define debugv(fmt, ...) \
    fprintf(stderr, "%s:%d: " fmt "\n", __func__, __LINE__, __VA_ARGS__)
#endif

int main(int argc, char *argv[]) {
    return 0;
}
