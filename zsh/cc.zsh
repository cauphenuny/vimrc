alias builtin-clang='/usr/bin/clang'
alias builtin-clang++='/usr/bin/clang++'
gxx="g++-14"
cxx="clang++"

alias gcc="gcc-14"
alias g++="${gxx}"
alias c++="${cxx}"
alias g++11="${gxx} -std=c++11"
alias g++14="${gxx} -std=c++14"
alias g++17="${gxx} -std=c++17"
alias g++20="${gxx} -std=c++20"
alias g++23="${gxx} -std=c++2b"
alias c++11="${cxx} -std=c++11"
alias c++14="${cxx} -std=c++14"
alias c++17="${cxx} -std=c++17"
alias c++20="${cxx} -std=c++20"
alias c++23="${cxx} -std=c++23"

alias LSAN="ASAN_OPTIONS=detect_leaks=1"

export CPPFRONT_INCLUDE="/usr/local/include/cppfront"

export CC='clang'
export CXX='clang++'
export CFLAGS='-DLOCAL '
export CXXFLAGS='-DLOCAL '

