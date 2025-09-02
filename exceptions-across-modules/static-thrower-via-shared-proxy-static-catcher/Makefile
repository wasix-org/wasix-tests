-include ../lib/common.mk.inc
-include ../../lib/common.mk.inc

THROWER=static
CATCHER=static

PROXY=yes

CFLAGS += -fPIC
LIBRARY_LDFLAGS += -shared

all: main

ifeq ($(THROWER),static)
main.o: CFLAGS += -DSTATIC_THROWER
else
main: libthrower.so
MAIN_LDFLAGS+=-L$(shell pwd) -Wl,--no-as-needed -lthrower
endif

ifeq ($(CATCHER),static)
main.o: CFLAGS += -DSTATIC_CATCHER
else
main: libcatcher.so
MAIN_LDFLAGS+=-L$(shell pwd) -Wl,--no-as-needed -lcatcher
endif

catcher.o: CFLAGS += -DTHROW_VIA_PROXY
main.o: CFLAGS += -DTHROW_VIA_PROXY
main: libproxy.so
MAIN_LDFLAGS+=-L$(shell pwd) -Wl,--no-as-needed -lproxy

main: main.o
	$(CXX) main.o $(LDFLAGS) $(MAIN_LDFLAGS) -o $@

libthrower.so: thrower.o
	rm $@ || true
	$(CXX) $< $(LDFLAGS) $(LIBRARY_LDFLAGS) $(THROWER_LDFLAGS) -o $@

libcatcher.so: catcher.o
	rm $@ || true
	$(CXX) $< $(LDFLAGS) $(LIBRARY_LDFLAGS) $(CATCHER_LDFLAGS) -o $@

libproxy.so: proxy.o
	rm $@ || true
	$(CXX) $< $(LDFLAGS) $(LIBRARY_LDFLAGS) $(PROXY_LDFLAGS) -o $@