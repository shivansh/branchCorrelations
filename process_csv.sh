#!/bin/bash

# Argument should be the name of the testcase file (not the C file)

i=1
initial_csv="initial.csv"
output_csv="output.csv"

rm -f "$initial_csv" "$output_csv"

while IFS='' read -r testcase_line || [[ -n "$testcase_line" ]]; do
    # echo "Text read from file: $testcase_line"
    output=$(./a.out $testcase_line)

    printf '%s\n' "$output" | while IFS= read -r line
    do
	if [[ "$line" =~ \  ]]; then
	    val1=$(expr substr "$line" 1 1)
	    val2=$(expr substr "$line" 2 2)

	    if [ $val1 -eq 0 ] && [ $val2 -eq 0 ]; then
	        printf "0," >> $initial_csv
	    elif [ $val1 -gt 0 ] && [ $val2 -eq 0 ]; then
	        printf "1," >> $initial_csv
	    elif [ $val1 -eq 0 ] && [ $val2 -gt 0 ]; then
	        printf "2," >> $initial_csv
	    else
	        printf "3," >> $initial_csv
	    fi

	else
	    printf "$i," >> $initial_csv
	    ((i++))
	fi
    done
    echo "" >> $initial_csv

done < "$1"

# Take a transpose of the generated csv file
# First, confirm whether all dependencies are met
apt-cache search csvtool > /dev/null
if [[ $? -eq 0 ]]; then
    csvtool transpose $initial_csv > $output_csv
else
    echo "Please install the package: csvtool"
fi
