#!/bin/bash
echo "plz enter the table name"
flage=1
while [ $flage -gt 0 ] 
do
read tableName
if [[ ($tableName == 'number') || ( $tableName == 'string') || ($tableName == 'text') ]]
then
echo "plz enter correct name"
else 
touch $tableName
flage=0
fi
done
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

if [[ ("${NAMES[1]}" == 'number') || ( "${NAMES[1]}" == 'string') || ("${NAMES[1]}" == 'tex2t') ]]
then
array[i]=$str

else
echo "plz enter correct data type"
i=$i-1
fi
done
echo "${array[@]}" > student
