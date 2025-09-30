include ../lib/common.mk.inc

CFLAGS += -Wno-nonnull

all: main

main: main.o
	$(CXX) main.o $(LDFLAGS) $(MAIN_LDFLAGS) -o $@