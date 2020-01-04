#!/bin/bash

#functions
function CreateDB(){

echo "please enter the Database Name:" 
read DBName
while true 
do
if [[ -z "$DBName" ]];
then
echo "Please enter A Valid Name"
read DBName
else
mkdir ~/DBMS/$DBName 2> ~/DBMS/error.log
if [[ $? == 0 ]]
then
echo "DataBase Created"
break
else
echo "Error While Creating DB enter other name"
read DBName
fi
fi
done 
}
function DeleteDB()
{
`cd ~/DBMS`
i=0
while read line
do
    array[ $i ]="$line"        
    (( i++ ))
done < <(ls -d)

echo ${array[1]} 
}
function listAllDB()
{
echo "3"
}

function usedb ()
{
echo "4"
}


if [[ $1 == 1 ]]
then
CreateDB
elif [[ $1 == 2 ]]
then
DeleteDB
elif [[ $1 == 3 ]]
then
listAllDB
elif [[ $1 == 4 ]]
then
usedb
else 
echo "Something went wrong"
fi

