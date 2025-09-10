include ../lib/common.mk.inc

CFLAGS += -fPIC

all: main

main: main.o
	$(CXX) main.o $(LDFLAGS) $(MAIN_LDFLAGS) -o $@
