# CS686A Assignment 1

Done in collaboration by -
* Jaivardhan Kapoor (150300)
* Shivansh Rai (14658)

## Dependencies
The following packages need to be installed for generating the CSV file -
* `csvtool` : The use of this package has been done to take transposition of the generated CSV file.

For running the R file, the following packages are required -
* `littler`
* `r-cran-plyr`

## Instructions
**NOTE:** The beginning 5 variables in [Makefile](Makefile) need to be updated as per the local ROSE installation.

For generating the CSV file, execute -
```
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/rose_install/lib
make 				# Compilation step
make run 			# Generates the CSV file
make generate_correlations  	# Generates correlations
```
This will generate the file `output.csv`
The testcase files are placed inside the directory [testcases](testcases). In case adding new testcase files for instrumentation, their names in the [Makefile](Makefile) have to be updated appropriately (in the last line).
