CPPC=g++
CPPFLAGS=-Wall -Wextra -Weffc++ -pipe -O3 -std=c++11 -march=native -Wl,-O1 -Wl,-z,relro -Wl,-z,now -flto

all: solve

.PHONY: clean

solve: solve.cpp
	$(CPPC) $(CPPFLAGS) $< -o $@

clean: 
	$(RM) solve
	$(RM) *.o
