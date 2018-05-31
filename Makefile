# NOTE: '~/rose_install' should be updated with
# path to the local Rose installation directory.
CXX      = $(shell ~/rose_install/bin/rose-config cxx)
CPPFLAGS = $(shell ~/rose_install/bin/rose-config cppflags)
CXXFLAGS = $(shell ~/rose_install/bin/rose-config cxxflags)
LDFLAGS  = $(shell ~/rose_install/bin/rose-config ldflags)
LIBDIRS  = $(shell ~/rose_install/bin/rose-config libdirs)
SRC      = ./src
OBJ      = ./obj

all:
	mkdir -p $(OBJ)
	make gen_line_num
	make count_true_branch

gen_line_num.o: $(SRC)/gen_line_num.cpp
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -o $(OBJ)/$@ -c $^
gen_line_num: gen_line_num.o
	$(CXX) $(CXXFLAGS) -o $@ $(OBJ)/$^ $(LDFLAGS)

count_true_branch.o: $(SRC)/count_true_branch.cpp
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -o $(OBJ)/$@ -c $^
count_true_branch: count_true_branch.o
	$(CXX) $(CXXFLAGS) -o $@ $(OBJ)/$^ $(LDFLAGS)

.PHONY: clean run generate_correlations

clean:
	rm -f gen_line_num gen_line_num.o \
	      count_true_branch count_true_branch.o \
	      a.out rose_tcas.c
	rm -f *.o

generate_correlations:
	Rscript correlations.R

run:
	./process_csv.sh testcases/testcase testcases/tcas.c
