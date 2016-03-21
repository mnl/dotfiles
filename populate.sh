#!/bin/bash
#Simple script to populate directory with symlinks
shopt -s nullglob
declare -a exclude=("README.md" "populate.sh")
declare path=".dotfiles/"
cd $HOME
mkdir -p $path
declare -a files=($path*)

#Removing files to exclude
for del in ${exclude[@]}
do
	files=(${files[@]/$path$del})
done

echo "Creating symlinks"
for f in "${files[@]}" 
do 
	#Making symlinks and verbosely and asking before overwriting
	ln -svi {$path${f#*/},."${f#*/}"}
done
