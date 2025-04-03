#include <algorithm>
#include <cstdio>
#include <cstring>
#include <iostream>
using namespace std;
#define debugf(...)      fprintf(stderr, __VA_ARGS__)
#define debugv(fmt, ...) debugf("%s:%d: " fmt, __FILE__, __LINE__, ##__VA_ARGS__)
#define debug(...)       debugv(), debug_exp(#__VA_ARGS__, __VA_ARGS__)
void debug_exp(const char*) {}
template <class T, class... Args>
void debug_exp(const char* keys, const T& value, const Args&... rest) {
    const char* p = strchr(keys, ',');
    cerr.write(keys, p ? p - keys : strlen(keys)) << " = " << value << (p ? "," : "\n");
    debug_exp(p ? p + 1 : "", rest...);
}
template <class T1, class T2> bool cmax(T1& a, const T2& b) { return b > a ? (a = b, 1) : 0; }
template <class T1, class T2> bool cmin(T1& a, const T2& b) { return b < a ? (a = b, 1) : 0; }

int main() { return 0; }
