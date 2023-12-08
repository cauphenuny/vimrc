src = $(wildcard *.cpp)
obj = $(src:%.cpp=%.o)
target = 
CXX = 
CXXFLAGS = -Wall -Wextra -Wshadow
CPPFLAGS = 
LDFLAGS = 

%.o: %.cpp %.h
	$(CXX) -c $< -o $@ $(CXXFLAGS) $(CPPFLAGS)

$(target): $(obj)
	$(CXX) $(obj) -o $(target) $(LDFLAGS)

.PHONY: clean rebuild run all

clean:
	rm -rf $(obj) $(target) 

rebuild: clean $(target)

run: $(target)
	./$(target)

all: $(target)
