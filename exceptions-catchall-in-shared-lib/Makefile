include ../lib/common.mk.inc

MAIN_LDFLAGS+=-L$(shell pwd) -Wl,--no-as-needed -llibrary
CFLAGS += -fPIC
LIBRARY_LDFLAGS += -shared

all: liblibrary.so main

main: liblibrary.so main.o
	$(CXX) main.o $(LDFLAGS) $(MAIN_LDFLAGS) -o $@

liblibrary.so: library.o
	rm $@ || true
	$(CXX) $< $(LDFLAGS) $(LIBRARY_LDFLAGS) $(THROWER_LDFLAGS) -o $@
