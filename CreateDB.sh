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
mkdir ~/DBMS/$DBName
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
cd ~/DBMS/
i=0
while read line
do
    array[ $i ]="$line"        
    (( i++ ))
done < <(ls)
select choice in "${array[@]}"; do

  [[ -n $choice ]] || { echo "Invalid choice. Please try again." >&2; continue; }
rm -r $choice  
if [[ $? == 0 ]]
then
echo "DataBase Deleted"
break
else
echo "Error While Deleting DB"
fi
break # valid choice was made; exit prompt.
done
read -r id sn unused <<<"$choice"

}
function listAllDB()
{
cd ~/DBMS/
i=1
while read line
do
    echo $i ")" "$line"        
    (( i++ ))
done < <(ls)
}

function usedb ()
{
cd ~/DBMS/
i=0
while read line
do
    array[ $i ]="$line"        
    (( i++ ))
done < <(ls)

select choice in "${array[@]}"; do

  [[ -n $choice ]] || { echo "Invalid choice. Please try again." >&2; continue; }
cd ~/DBMS/$choice

if [[ $? == 0 ]]
then

echo "DB $choice in effect"

sh ~/bashProject/dml.sh 1 $choice
break
else
echo "Error While using this  DB"
fi
break # valid choice was made; exit prompt.
done
read -r id sn unused <<<"$choice"
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

