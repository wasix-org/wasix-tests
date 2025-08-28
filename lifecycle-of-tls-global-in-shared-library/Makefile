include ../lib/common.mk.inc

MAIN_LDFLAGS += -L$(shell pwd) -Wl,--no-as-needed -llibrary

CFLAGS += -fPIC
LIBRARY_LDFLAGS += -shared

all: main

main: main.o liblibrary.so
	$(CXX) main.o $(LDFLAGS) $(MAIN_LDFLAGS) -o $@

lib%.so: %.o
	$(CXX) $< $(LDFLAGS) $(LIBRARY_LDFLAGS) -o $@
