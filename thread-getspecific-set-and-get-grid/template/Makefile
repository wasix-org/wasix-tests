include ../../lib/common.mk.inc

SET_DATA=DIRECT
GET_DATA=DIRECT
SET_DATA_PROXY=DIRECT
GET_DATA_PROXY=DIRECT

CFLAGS += -fPIC -DSET_DATA_$(SET_DATA) -DGET_DATA_$(GET_DATA) -DSET_DATA_PROXY_$(SET_DATA_PROXY) -DGET_DATA_PROXY_$(GET_DATA_PROXY)
LDFLAGS += -Wl,-rpath='$$ORIGIN' -L$(shell pwd)

ifeq ($(SET_DATA_PROXY),DIRECT)

main: set-data-proxy.o
ifeq ($(SET_DATA),DIRECT)
main: set-data.o
else ifeq ($(SET_DATA),SHARED)
main: libset-data.so
main: MAIN_LDFLAGS += -lset-data
else ifeq ($(SET_DATA),DYNAMIC)
main: libset-data.so
endif

else ifeq ($(SET_DATA_PROXY),SHARED)

main: MAIN_LDFLAGS += -lset-data-proxy
main: libset-data-proxy.so
ifeq ($(SET_DATA),DIRECT)
libset-data-proxy.so: set-data.o
else ifeq ($(SET_DATA),SHARED)
libset-data-proxy.so: libset-data.so
libset-data-proxy.so: SET_DATA_PROXY_LDFLAGS += -lset-data
else ifeq ($(SET_DATA),DYNAMIC)
libset-data-proxy.so: libset-data.so
endif

else ifeq ($(SET_DATA_PROXY),DYNAMIC)

main: libset-data-proxy.so
ifeq ($(SET_DATA),DIRECT)
libset-data-proxy.so: set-data.o
else ifeq ($(SET_DATA),SHARED)
libset-data-proxy.so: libset-data.so
libset-data-proxy.so: SET_DATA_PROXY_LDFLAGS += -lset-data
else ifeq ($(SET_DATA),DYNAMIC)
libset-data-proxy.so: libset-data.so
endif

endif



ifeq ($(GET_DATA_PROXY),DIRECT)

main: get-data-proxy.o
ifeq ($(GET_DATA),DIRECT)
main: get-data.o
else ifeq ($(GET_DATA),SHARED)
main: libget-data.so
main: MAIN_LDFLAGS += -lget-data
else ifeq ($(GET_DATA),DYNAMIC)
main: libget-data.so
endif

else ifeq ($(GET_DATA_PROXY),SHARED)

main: MAIN_LDFLAGS += -lget-data-proxy
main: libget-data-proxy.so
ifeq ($(GET_DATA),DIRECT)
libget-data-proxy.so: get-data.o
else ifeq ($(GET_DATA),SHARED)
libget-data-proxy.so: libget-data.so
libget-data-proxy.so: GET_DATA_PROXY_LDFLAGS += -lget-data
else ifeq ($(GET_DATA),DYNAMIC)
libget-data-proxy.so: libget-data.so
endif

else ifeq ($(GET_DATA_PROXY),DYNAMIC)

main: libget-data-proxy.so
ifeq ($(GET_DATA),DIRECT)
libget-data-proxy.so: get-data.o
else ifeq ($(GET_DATA),SHARED)
libget-data-proxy.so: libget-data.so
libget-data-proxy.so: GET_DATA_PROXY_LDFLAGS += -lget-data
else ifeq ($(GET_DATA),DYNAMIC)
libget-data-proxy.so: libget-data.so
endif

endif


all: main

main: main.o
	$(CXX) $(filter %.o,$^) $(LDFLAGS) $(MAIN_LDFLAGS) -o $@

MAIN_LDFLAGS += -L$(shell pwd) -rdynamic
CFLAGS += -fPIC
LIBRARY_LDFLAGS += -shared

libget-data.so: get-data.o
	$(CXX) $(filter %.o,$^) $(LDFLAGS) $(LIBRARY_LDFLAGS) $(GET_DATA_LDFLAGS) -o $@
libget-data-proxy.so: get-data-proxy.o
	$(CXX) $(filter %.o,$^) $(LDFLAGS) $(LIBRARY_LDFLAGS) $(GET_DATA_PROXY_LDFLAGS) -o $@
libset-data.so: set-data.o
	$(CXX) $(filter %.o,$^) $(LDFLAGS) $(LIBRARY_LDFLAGS) $(SET_DATA_LDFLAGS) -o $@
libset-data-proxy.so: set-data-proxy.o
	$(CXX) $(filter %.o,$^) $(LDFLAGS) $(LIBRARY_LDFLAGS) $(SET_DATA_PROXY_LDFLAGS) -o $@
