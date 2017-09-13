CXX      = $(shell ~/rose_install/bin/rose-config cxx)
CPPFLAGS = $(shell ~/rose_install/bin/rose-config cppflags)
CXXFLAGS = $(shell ~/rose_install/bin/rose-config cxxflags)
LDFLAGS  = $(shell ~/rose_install/bin/rose-config ldflags)
LIBDIRS  = $(shell ~/rose_install/bin/rose-config libdirs)

all: gen_line_num countTrueBranch

gen_line_num.o: gen_line_num.C
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -o $@ -c $^
gen_line_num: gen_line_num.o
	$(CXX) $(CXXFLAGS) -o $@ $^ $(LDFLAGS)

countTrueBranch.o: countTrueBranch.C
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -o $@ -c $^
countTrueBranch: countTrueBranch.o
	$(CXX) $(CXXFLAGS) -o $@ $^ $(LDFLAGS)

.PHONY: clean run generate_correlations

clean:
	rm -f gen_line_num gen_line_num.o \
	      countTrueBranch countTrueBranch.o

generate_correlations:
	Rscript prog.R

run:
	./process_csv.sh testcases/testcase testcases/tcas.c
