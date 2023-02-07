#Question3. Write a scipt to Lock down the file or directory permission for folder1 files as per following requirement  [8]
#mkdir folder1
#touch f_{1..3}
#.file.sh folder1/
#Remove all permissions for groups and others.
#Provide directory name through command-line.
#After running script all files in the given directory, Only should have all the permissions.
#But remember dont add any permission to user only change to others and groups.

#Code starts from next line here >>>>>>

#!usr/bin/bash

mkdir folder1
cd folder1
touch f_{1..3}
cd ..

chmod -R og-rwx folder1 


