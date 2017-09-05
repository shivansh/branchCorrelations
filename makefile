CXX      = $(shell ~/rose_install/bin/rose-config cxx)
CPPFLAGS = $(shell ~/rose_install/bin/rose-config cppflags)
CXXFLAGS = $(shell ~/rose_install/bin/rose-config cxxflags)
LDFLAGS  = $(shell ~/rose_install/bin/rose-config ldflags)
LIBDIRS  = $(shell ~/rose_install/bin/rose-config libdirs)
MOSTLYCLEANFILES =

all: demo countTrueBranch query

demo.o: demo.C
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -o $@ -c $^
demo: demo.o
	$(CXX) $(CXXFLAGS) -o $@ $^ $(LDFLAGS)

query.o: query.C
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -o $@ -c $^
query: query.o
	$(CXX) $(CXXFLAGS) -o $@ $^ $(LDFLAGS)

countTrueBranch.o: countTrueBranch.C
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -o $@ -c $^
countTrueBranch: countTrueBranch.o
	$(CXX) $(CXXFLAGS) -o $@ $^ $(LDFLAGS)

MOSTLYCLEANFILES += demo demo.o

.PHONY: clean
clean:
	rm -f $(MOSTLYCLEANFILES)
