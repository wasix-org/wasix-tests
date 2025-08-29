include ../lib/common.mk.inc

MAIN_LDFLAGS+=-L$(shell pwd) -Wl,--no-as-needed -lside

SIDE_LDFLAGS+=-shared -L$(shell pwd) -Wl,--no-as-needed -lside

all: libside.so main

main: main.o libside.so
	$(CXX) main.o $(LDFLAGS) $(MAIN_LDFLAGS) -o $@

lib%.so: %.o
	$(CXX) $< $(LDFLAGS) $(SIDE_LDFLAGS) -o $@