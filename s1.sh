#!/bin/bash
echo "plz enter the number of columns "
read num
echo "plz enter name of columns with datatype sperated with :"
declare -a array
for (( i=1 ; i <= num ; i++ ))
do 
read str
IFS=':'
read -ra NAMES <<< "$str"
echo ${NAMES[1]}

if [[ ("${NAMES[1]}" == 'number') || ( "${NAMES[1]}" == 'string') || ("${NAMES[1]}" == 'text') ]]
then
array[i]=$str
else
echo "plz enter correct data type"
fi
done
for (( i=1 ; i <= num ; i++))
do 
echo "success"
echo "${array[@]}" > student
done


