#!/bin/bash
. ~/bashProject/Metadata.sh
#functions
function Updatereco()
{
declare -a dataarr
declare -a array
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
tableName=~/DBMS/$1/$choice
echo "please enter the field you want to update"
select val in "${Data[@]}"; do
  [[ -n $val ]] || { echo "Invalid choice. Please try again." >&2; continue; }
echo $val
echo "please enter the Primary key"
read key
  Crow=$(awk 'BEGIN{FS=" "};{if(NR!=1){{if($1=="'$key'") print NR}}}' $tableName)
  if [[ $Crow == "" ]]
  then
    echo "Not Found"
    break
  else
	echo "Please enter the New value"
	read value
fnum=$(awk 'BEGIN{FS=" "};{
for(i=1;i<=NF;i++){
if($i=="'$val'"){print i}}}' $tableName)


awk 'BEGIN{FS=" "};{if(NR=="'$Crow'"){ $"'$fnum'" = "'$value'" }print $0}' $tableName > tmp && mv tmp $tableName
	for i in "${!Ctype}"; do
   IFS=':'
read -ra Types <<< "${Ctype}"
done
echo "${Types[1]}"
      	echo "Row Updated Successfully"
fi

done 
done
}
function Inserttable()
{
declare -a dataarr
declare -a array
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

if [[ ${Types[1]} == 'string'  ]]
then
tableName=~/DBMS/$1/$choice
echo "please enter the ${Types[0]}"
read dti
if [[ $index == 0 ]]
then
while [[ true ]]; do

pattern=$(awk 'BEGIN{FS=" ";ORS=" "};{if(NR!=1){{if($1=="'$dti'") print $1}}}' $tableName)
pattern=`echo $pattern | sed 's/ *$//g'` 
if [[ "$dti" == "$pattern" ]]; then
echo -e "invalid input for Primary Key !!"
	break 3;
        else
          break;
        fi
done
fi
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
if [[ $index == 0 ]]
then
while [[ true ]]; do
if [[ $dti =~ ^[`awk 'BEGIN{FS=" " ;ORS=" "}{if(NR != 1)print $1}' $tableName`]$ ]]; then
          echo -e "invalid input for Primary Key !!"
	break 3;
        else
          break;
        fi
done
fi
if [[ $dti =~ $number ]]
then
dataarr[$index]=$dti
index=$index+1
else
echo "wrong type entered"
break
fi
else
tableName=~/DBMS/$1/$choice
echo "please enter the ${Types[0]}"
read dti


if [[ $index == 0 ]]
then
while [[ true ]]; do
pattern=$(awk 'BEGIN{FS=" ";ORS=" "};{if(NR!=1){{if($1=="'$dti'") print $1}}}' $tableName)
pattern=`echo $pattern | sed 's/ *$//g'`
if [[ "$dti" == "$pattern" ]]; then
          echo -e "invalid input for Primary Key !!"
	break 3;
        else
          break;
        fi
done
fi

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

cols=$(awk 'BEGIN{FS=" "};{print NF; exit}' ~/DBMS/$1/$choice) 
if [[ "${#dataarr[@]}" == "${cols}" ]]; then
echo "${dataarr[@]}" >> ~/DBMS/$1/$choice
if [[ $? == 0 ]]
then
echo "record added"
break
fi
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
function Removetable()
{
declare -a array
cd ~/DBMS/$1
i=0
while read line
do
    array[ $i ]="$line"        
    (( i++ ))
done < <(ls)
select choice in "${array[@]}"; do

  [[ -n $choice ]] || { echo "Invalid choice. Please try again." >&2; continue; }
rm -r ~/DBMS/$1/$choice  
if [[ $? == 0 ]]
then
echo "Table Deleted"
break
else
echo "Error While Deleting table"
fi
break # valid choice was made; exit prompt.
done
read -r id sn unused <<<"$choice"
}
function listAlltables()
{

cd ~/DBMS/$1
i=1
while read line
do
    echo $i ")" "$line"        
    (( i++ ))
done < <(ls)
}
function Deletetablecontent() {
  cd ~/DBMS/$1
declare -a array
i=0
while read line
do
    array[ $i ]="$line"        
    (( i++ ))
done < <(ls)
select choice in "${array[@]}"; do

  [[ -n $choice ]] || { echo "Invalid choice. Please try again." >&2; continue; }
tableName=~/DBMS/$1/$choice
echo "please enter the Primary key"
read field
  Crow=$(awk 'BEGIN{FS=" "};{if(NR!=1){{if($1=="'$field'") print NR}}}' $tableName)
echo $Crow
  if [[ $Crow == "" ]]
  then
    echo "Not Found"
    break
  else
      sed -i ''$Crow'd' $tableName 2>> /dev/null
      echo "Row Deleted Successfully"
fi
if [[ $? == 0 ]]
then
echo "record Deleted"
break
else
echo "Error While Deleting table"
fi
break # valid choice was made; exit prompt.
done
read -r id sn unused <<<"$choice"

}
function Updaterecord(){
declare -a array
cd ~/DBMS/$1
i=0
while read line
do
    array[ $i ]="$line"        
    (( i++ ))
done < <(ls)
select choice in "${array[@]}"; do

  [[ -n $choice ]] || { echo "Invalid choice. Please try again." >&2; continue; }
tableName=~/DBMS/$1/$choice

echo "enter pk"
read pk
Crow=$(awk -v key="$pk" 'BEGIN{FS=" "};{if(NR!=1){{if($1==key) print NR}}}' $tableName)

echo "enter fieled"
read field
fnum=$(awk 'BEGIN{FS=" "};{if(NR==1){for(i=1;i<=NF;i++){if($i=='"${Types[0]}"'){print $i}}}}' $tableName)
echo "enter new value"
read  newValue
echo $Crow
echo this is $fnum
awk -v Nrow="$Crow" -v value="$newValue" -v field="$fnum"'BEGIN{FS=" "};{if(NR==Nrow){$field=value}print $0}' $tableName >> tmp && mv tmp $tableName
done
done
}
options=("Create Table" "Delete Table" "Insert Into Table" "list All Tables" "Update Value In Table" "Delete From Table" "Quit")
while true
do
select opt in "${options[@]}"
do

    case $opt in
        "Create Table")
           Createtable $1
		break
            ;;
        "Delete Table")
            Removetable $1
	    break            
        ;;
      
 	"Insert Into Table")
         Inserttable $1
	    break 
            ;;

	"Update Value In Table")
            Updaterecord $1
	    break 
            ;;
	"list All Tables")
            listAlltables $1
	    break 
            ;;
    "Delete From Table")
         Deletetablecontent $1
	   break 
            ;;
        "Quit")
            break 2
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
done


