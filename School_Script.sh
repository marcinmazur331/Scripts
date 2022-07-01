#!/bin/bash
path="C:\Users\ $USER}";
if [ -z "$path" ]
then
    echo "Bedna sciezka do pliku.";
    exit 1;
fi
if [  "$EUID" == 0 ]
then
    echo "Posiadasz uprawnienia uprzywilejowane";
    exit 2;
fi
mapfile -t array < <( find $path |sort )
n=${#array[@]};
for((i=1;i<n;i++)); do
    if [ -d ${array[i]} ]
    then
        if [ -r ${array[i]} ]
        then
            echo -n "r"
        else
            echo -n "-"
        fi
        if [ -w ${array[i]} ]
        then
            echo -n "w"
        else
            echo -n "-"
        fi
        if [ -x ${array[i]} ]
        then
            echo -n "x"
        else
            echo -n "-"
        fi
        echo " ${array[i]}"
    fi
done
exit 0;