#!/bin/bash
#functions
function Createtable()
{
echo "please enter the table Name:" 
read tableName
while true 
do
if [[ -z "$tableName" ]];
then
echo "Please enter A Valid Name"
read tableName
else
touch ~/DBMS/$1/$tableName
if [[ $? == 0 ]]
then
echo "table Created"
break
else
echo "Error While Creating table enter other name"
read tableName
fi
fi
done 
}

if [[ $1 == 1 ]]
then
Createtable $2  
else 
echo "Something went wrong"
fi

