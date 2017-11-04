# [CS686A] Evaluating branch correlations

Done as a part of the course - [Data driven program analysis](http://web.cse.iitk.ac.in/users/cs686/).  
The aim of this assignment is to evaluate correlations between *all the branches* in a given C program. A strong correlation between two branches `(b1, b2)` is directly proportional to the probablity of both the branches behaving similarly.

### [Project Report](report.pdf)

Done in collaboration by -
* Jaivardhan Kapoor (150300)
* Shivansh Rai (14658)

## Dependencies
The following package is required for generating the CSV file -
* `csvtool` : The use of this package has been done to take transposition of the generated CSV file.

For running the R file, the following packages are required -
* `littler`
* `r-cran-plyr`

## Instructions

The shared library path needs to be appropriately updated -
```
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$rose_dir/lib
```
**NOTE 1:** `$rose_dir` should be updated with path to the local Rose installation directory.  
**NOTE 2:** Intances of `~/rose_install` in [Makefile](Makefile) needs to be updated with path to the local Rose installation directory.

For generating the CSV file, execute -
```
make 				# Compilation step
make run 			# Generates the CSV file
```
This will generate the file `output.csv`.

To produce the correlation matrix between branches, execute -
```
make generate_correlations
```
A sample of the generated output is available at [correlations_demo.txt](correlations_demo.txt).

The testcase files are placed inside the directory [testcases](testcases). In case adding new testcase files for instrumentation, their names in the [Makefile](Makefile) have to be updated appropriately (in the last line).
