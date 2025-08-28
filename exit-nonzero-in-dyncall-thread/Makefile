include ../lib/common.mk.inc

CFLAGS+=-fPIC
LDFLAGS+=-pthread

all: main

main: main.o
	$(CXX) main.o $(LDFLAGS) $(MAIN_LDFLAGS) -o $@