#!usr/bin/bash

fun1(){
	echo "executing function 1 >>>>"
read -p "Enter the name of the file or directory:" name
if [ -f $name ]
then
	echo "It is a text file."
	echo "Here is the 'ls' output for this file"
        ls -la $name
elif [ -d $name ]
then
	echo "It is a directory."
	echo "Here is the 'ls' output for this directory"
	ls -la $name
else
	echo "The file doesn't exists."
fi
}

fun1


file_count(){
	echo "executing file_count function >>>>"

	echo "Total number of files in this directory are:"
	find -type f | wc -l
	echo "Total number of directories in this directory are:"
	find -type d | wc -l
}
file_count
