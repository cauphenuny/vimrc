#pragma once
#include <cstring>
#include <filesystem>
#include <iostream>
#include <source_location>
#include <sstream>
inline std::string
locate(const std::source_location location = std::source_location::current())
{
    std::ostringstream oss;
    oss << std::filesystem::path(location.file_name()).filename().string()
        << '(' << location.line() << ':' << location.column() << ") `"
        << location.function_name() << "`";
    return oss.str();
}
#define debug_var(...)        \
    std::clog << std::format( \
        "{}: {}\n", locate(), show_var(#__VA_ARGS__, __VA_ARGS__))
#define debug(...) \
    std::clog << std::format("{}: {}\n", locate(), std::format(__VA_ARGS__))
std::string show_var(const char* names, const auto& var, const auto&... rest)
{
    std::ostringstream oss;
    const char* comma = strchr(names, ',');
    if (comma != nullptr) {
        oss.write(names, comma - names) << " = " << var << ",";
        if constexpr (sizeof...(rest)) oss << show_var(comma + 1, rest...);
    } else {
        oss.write(names, strlen(names)) << " = " << var;
    }
    return oss.str();
}
bool cmax(auto& a, const auto& b) { return b > a ? (a = b, 1) : 0; }
bool cmin(auto& a, const auto& b) { return b < a ? (a = b, 1) : 0; }