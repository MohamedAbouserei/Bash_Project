#!/bin/bash
. ~/bashProject/Metadata.sh
#functions
function Inserttable()
{
declare -a dataarr
cd ~/DBMS/$1
i=0
while read line
do
    array[ $i ]="$line"        
    (( i++ ))
done < <(ls)

select choice in "${array[@]}"; do

  [[ -n $choice ]] || { echo "Invalid choice. Please try again." >&2; continue; }
while IFS= read -r line; do
IFS=' '
read -ra Data <<< "$line"    
break
done < ~/DBMS/$1/$choice
index=0

for i in "${!Data[@]}"; do
   IFS=':'
read -ra Types <<< "${Data[i]}"

if [[ ${Types[1]} == 'string' ]]
then
echo "please enter the ${Types[0]}"
read dti
if [[ $dti =~ $string ]]
then
dataarr[$index]=$dti
index=$index+1
else
echo "wrong type entered"
break
fi
elif [[ ${Types[1]} == 'number' ]]
then
tableName=~/DBMS/$1/$choice

echo "please enter the ${Types[0]}"
read dti

while [[ true ]]; do
if [[ $dti =~ ^[`awk 'BEGIN{FS=" " ;ORS=" "}{if(NR != 1)print $1}' $tableName`]$ ]]; then
          echo -e "invalid input for Primary Key !!"
	break 3;
        else
          break;
        fi
done

if [[ $dti =~ $number ]]
then
dataarr[$index]=$dti
index=$index+1
else
echo "wrong type entered"
break
fi
else
echo "please enter the ${Types[0]}"
read dti
if [[ $dti =~ $text ]]
then
dataarr[$index]=$dti
index=$index+1
else
echo "wrong type entered"
break
fi
fi
done
echo "${dataarr[@]}" >> ~/DBMS/$1/$choice
if [[ $? == 0 ]]
then
echo "record added"
break
fi
break
done
read -r id sn unused <<<"$choice"

}
function Createtable()
{
flag=0
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
if [[ ! "$num" =~ $number ]]
then
echo "plz number correctly"
break
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



options=("Create Table" "Delete Table" "Insert Into Table" "list All Table Content" "Update Value In Table" "Quit")
while true
do
select opt in "${options[@]}"
do

    case $opt in
        "Create Table")
           Createtable $1
		break
            ;;
        "Delete DB")
            
	break            
;;
      
 	"Insert Into Table")
         Inserttable $1   
	break 
            ;;

	"Update Value In Table")
            
	break 
            ;;
        "Quit")
            break 2
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
done


