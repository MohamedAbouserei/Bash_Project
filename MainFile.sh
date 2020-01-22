#!/bin/bash
mkdir -p ~/DBMS
options=("Create DB" "Delete DB" "Select DB" "list All DataBases" "Quit")
while true
do
select opt in "${options[@]}"
do

    case $opt in
        "Create DB")
           ./CreateDB.sh 1
		break
            ;;
        "Delete DB")
            ./CreateDB.sh 2 
	break            
;;
        "Select DB")
           ./CreateDB.sh 4
	break
            ;;
 	"list All DataBases")
            ./CreateDB.sh 3
	break 
            ;;
        "Quit")
            break 2
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
done
