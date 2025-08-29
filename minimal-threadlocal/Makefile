
WASMER?=wasmer
CC ?= cc
CXX ?= c++
LD ?= cc

all: main

%.o: %.cpp Makefile
	$(CXX) $(CFLAGS) -c $< -o $@

main: main.o Makefile
	$(LD) $(LDFLAGS) -o $@ main.o

%.wasm: %.o Makefile
	$(LD) $(LDFLAGS) -o $@ $<

clean:
	rm -f *.o *.wasm *.log *.a *.so