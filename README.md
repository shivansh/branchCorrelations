# CS686A Assignment 1

Done in collaboration by -
* Jaivardhan Kapoor (150300)
* Shivansh Rai (14658)

## Dependencies
The following package needs to be installed: `csvtool`. The code was successfully tested against version `1.4.2-1`.
On a ubuntu machine, this package can be installed via -
```
sudo apt-get install csvtool
```
The use of this package has been done to take transposition of the generated CSV file.

## Instructions
For generating the CSV file, execute -
```
make && make run
```
This will generate the file `output.csv`
The testcase files are placed inside the directory `TestCase`. In case adding new testcase files for instrumentation, their names in the [Makefile](Makefile) have to be updated appropriately (in the last line).
