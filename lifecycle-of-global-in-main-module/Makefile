include ../lib/common.mk.inc

CFLAGS += -fPIC

all: main

main: main.o library.o
	$(CXX) main.o library.o $(LDFLAGS) $(MAIN_LDFLAGS) -o $@