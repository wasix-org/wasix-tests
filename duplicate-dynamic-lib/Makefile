include ../lib/common.mk.inc

SIDE_LDFLAGS+=-shared

all: main a/libside.so b/libside.so

main: main.o a/libside.so b/libside.so
	$(CXX) main.o $(LDFLAGS) $(MAIN_LDFLAGS) -o $@

a/lib%.so: a/%.o
	$(CXX) $< $(LDFLAGS) $(SIDE_LDFLAGS) -o $@

b/lib%.so: b/%.o
	$(CXX) $< $(LDFLAGS) $(SIDE_LDFLAGS) -o $@