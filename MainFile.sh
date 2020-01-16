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
            ;;
        "Delete DB")
            ./CreateDB.sh 2 
            ;;
        "Select DB")
           ./CreateDB.sh 4
            ;;
 	"list All DataBases")
            ./CreateDB.sh 3
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
done
