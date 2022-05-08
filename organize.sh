#!/bin/bash

# getting argument options
while getopts "t:o:" arg; do
 case $arg in
 t)
 targetDir=$OPTARG
 ;;
 o)
 organizedDir=$OPTARG
 ;;
 esac
done
argumentList=$@

# solution functions for 4 cases
case1 () {
   if [[ ! -d "organized" ]]
 then
 mkdir organized
 fi
 for i in ${argumentList[@]:0}
 do
 fileList=`find "." -name "*.${i}"` 
 for j in $fileList
 do
 tar rf "organized/$i.tar" "$j"
 done
 done
}
case2 () {
   for i in ${argumentList[@]:3}
 do
 fileList=`find $targetDir -name "*.${i}"` 
 mkdir organized
 chmod +x organized
 for j in $fileList
 do
 tar rf "organized/$i.tar" $j 
 done
 done
}
case3 () {
   if [[ ! -d "organized" ]]
 then
 mkdir $organizedDir
 echo "Created Directory: $organizedDir"
 fi
 chmod +x $organizedDir
 for i in ${argumentList[@]:3}
 do
 fileList=`find "." -name "*.${i}"` 
 for j in $fileList
 do
 tar rf "$organizedDir/$i.tar" $j 
 done
 done
}
case4 () {
  if [[ ! -d "organized" ]]
 then
 mkdir $organizedDir
 echo "Created Directory: $organizedDir"
 elif [[ ! -w "$organizedDir" ]]
 then
 echo "No permission to write on the directory"
 fi
 chmod +x $organizedDir
 for i in ${argumentList[@]:5}
 do
 fileList=`find $targetDir -name "*.${i}"` 
 for j in $fileList
 do
 tar rf "$organizedDir/$i.tar" $j -C $targetDir
 done
 done 
}

# conditions for 4 cases to call functions
if [[ -z "$targetDir" && -z "$organizedDir" ]]
then 
 case1
elif [[ -z "$organizedDir" ]]
then
 case2
elif [[ -z "$targetDir" ]]
then
 case3
elif [[ ! -z "$targetDir" && ! -z "$organizedDir" ]]
then
 case4
fi