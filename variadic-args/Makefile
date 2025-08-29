include ../lib/common.mk.inc

MAIN_LDFLAGS+=-L$(shell pwd)
MAIN_LDFLAGS+=-lside

SIDE_LDFLAGS+=-shared

all: libside.so main

main: libside.so main.o
	$(CXX) main.o $(LDFLAGS) $(MAIN_LDFLAGS) -o $@

lib%.so: %.o
	$(CXX) $< $(LDFLAGS) $(SIDE_LDFLAGS) -o $@