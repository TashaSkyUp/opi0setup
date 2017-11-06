#!/bin/bash
$a="0"
rm log.csv -f 
cat log | while read l
do
[[ $l =~ (accepted)+.*(, )([0-9]+).([0-9]+) ]] && hr="${BASH_REMATCH[3]}${BASH_REMATCH[4]}"
echo "Hash Rate: $hr"
echo "HashRate,$hr" >> log.csv

a=$(expr $a + $hr)
echo "$a"
done


