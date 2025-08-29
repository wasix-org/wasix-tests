include ../lib/common.mk.inc

LDFLAGS+=-lffi
CFLAGS += -O0 -g

all: main

main: main.o
	$(CXX) main.o $(LDFLAGS) $(MAIN_LDFLAGS) -o $@