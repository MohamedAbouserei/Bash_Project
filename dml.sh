#!/bin/bash
. ~/bashProject/Metadata.sh
#functions
function Createtable()
{
echo "please enter the table Name:" 
read tableName
while true 
do
if [[ -z "$tableName" || ! "$tableName" =~ $string || -f "$tableName" ]];
then
echo "enter A Valid Name or table already found "
read tableName
else
echo "plz enter the number of columns "
read num
if ! [[ "$num" =~ $num ]]
then
echo "plz number correctly"
read num
fi
echo "plz enter name of columns with datatype sperated with :"
declare -a array
declare -a checkarr
for (( i=1 ; i <= num ; i++ ))
do 
read str
if [[ $str != *":"* ]]
then
echo "types must be seprated by :"
break 2
fi
IFS=':'
read -ra NAMES <<< "$str"
echo "${NAMES[0]}"
if [[ ("${NAMES[1]}" == 'number') || ( "${NAMES[1]}" == 'string' ) || ( "${NAMES[1]}" == 'text' ) ]]
then
array[i]=$str
checkarr[i]=${NAMES[0]}
else
echo "plz enter correct data type"
i=$i-1
fi
done
uniqueNum=$(printf '%s\n' "${checkarr[@]}"|awk '!($0 in seen){seen[$0];c++} END {print c}')
(( uniqueNum != ${#checkarr[@]} )) && flag=1
if [[ $flag == 1 ]]
then
echo "dublicates found try again"
break
fi
echo "please enter the Primary key"
select choice in "${array[@]}"; 
do
 [[ -n $choice ]] || { echo "Invalid choice. Please try again." >&2; continue; }
for i in "${!array[@]}"; do
   if [[ "${array[$i]}" == $choice ]]; then
       let data="${i}";
   fi
done
tmp=${array[$data]}
array[$data]=${array[0]}
array[0]=$tmp
break
done
touch ~/DBMS/$1/$tableName
echo "${array[@]}" > ~/DBMS/$1/$tableName
if [[ $? == 0 ]]
then
echo "table created"
break
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

