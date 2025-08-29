include ../lib/common.mk.inc

SIDE_LDFLAGS+=-shared

all: main lib/a/libside.so lib/b/libside.so

main: main.o lib/a/libside.so lib/b/libside.so
	$(CXX) main.o $(LDFLAGS) $(MAIN_LDFLAGS) -o $@

lib/a/lib%.so: a/%.o
	mkdir -p lib/a
	$(CXX) $< $(LDFLAGS) $(SIDE_LDFLAGS) -o $@

lib/b/lib%.so: b/%.o
	mkdir -p lib/b
	$(CXX) $< $(LDFLAGS) $(SIDE_LDFLAGS) -o $@