#include <algorithm>
#include <cstdio>
#include <cstring>
#include <iostream>
using namespace std;
// clang-format off
#define debugf(...) fprintf(stderr, __VA_ARGS__)
#if defined(__clang__) || defined(__GNUC__)
#define debugv(fmt, ...) fprintf(stderr, "%s:%d: " fmt, __func__, __LINE__, ##__VA_ARGS__)
#else
#define debugv(fmt, ...) fprintf(stderr, "%s:%d: " fmt, __func__, __LINE__, __VA_ARGS__)
#endif
#define debug(...) debugv(), debug_exp(#__VA_ARGS__, __VA_ARGS__)
void debug_exp(const char*) { std::cerr << std::endl; }
template <typename T, typename... Args>
void debug_exp(const char* names, const T& var, const Args&... args) {
    const char* comma = strchr(names, ',');
    if (comma != nullptr) std::cerr.write(names, comma - names) << " = " << var << ",";
    else std::cerr.write(names, strlen(names)) << " = " << var;
    debug_exp(comma == nullptr? "" : comma + 1, args...);
}
template <typename T1, typename T2> 
bool cmax(T1& a, const T2& b) { return b > a ? (a = b, 1) : 0; }
template <typename T1, typename T2> 
bool cmin(T1& a, const T2& b) { return b < a ? (a = b, 1) : 0; }
// clang-format on
int main() {
    return 0;
}
