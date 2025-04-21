#include <cctype>
#include <cstdio>
#include <cstring>
// clang-format off
template<typename T> T read() {
    T a = 0, f = 0; int c = getchar();
    while (!isdigit(c)) { f ^= c == '-',  c = getchar(); }
    while (isdigit(c)) { a = a * 10 + (c ^ 48),  c = getchar(); }
    a *= f ? -1 : 1; return a;
}
struct Fastin {
    template<typename T>
    Fastin& operator >> (T &x) { x = read<T>(); return *this; }
    Fastin& operator >> (char &c) { scanf("%c", &c); return *this; }
    Fastin& operator >> (char c[]) { scanf("%s", c); return *this; }
};
// clang-format on