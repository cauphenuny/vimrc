#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define debugf(...)      fprintf(stderr, __VA_ARGS__)
#define debugv(fmt, ...) debugf("%s:%d: " fmt "\n", __FILE__, __LINE__, ##__VA_ARGS__)

int main() {
    return 0;
}
