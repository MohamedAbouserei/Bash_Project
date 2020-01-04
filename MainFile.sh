#!/bin/bash
options=("Create DB" "Delete DB" "Select DB" "list All DataBases" "Quit")
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
            echo "you chose choice $REPLY which is $opt"
            ;;
 	"list All DataBases")
            echo "you chose choice $REPLY which is $opt"
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
