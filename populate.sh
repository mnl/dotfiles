#!/bin/bash
#Simple script to populate directory with symlinks
shopt -s nullglob
declare -a ignore=("README.md" "populate.sh")
declare path=".dotfiles/"
cd $HOME
mkdir -p $path
declare -a files=($path*)

#Removing files to ignore
for del in ${ignore[@]}
do
	files=(${files[@]/$path$del})
done

echo "Creating symlinks"
for f in "${files[@]}" 
do 
	Making symlinks and verbosely and asking before overwriting
	#ln -svi {$path${f#*/},."${f#*/}"}
done
