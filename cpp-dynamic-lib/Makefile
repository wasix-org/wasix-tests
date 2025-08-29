include ../lib/common.mk.inc

# Position independent code needed for shared library with TLS
CFLAGS += -fPIC
LIBRARY_LDFLAGS += -shared

all: liblibrary.so main

main: main.o
	$(CC) main.o $(LDFLAGS) $(MAIN_LDFLAGS) -o $@

lib%.so: %.o
	$(CXX) $< $(LDFLAGS) $(LIBRARY_LDFLAGS) -o $@
