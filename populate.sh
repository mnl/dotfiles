#!/bin/bash
#Simple script to populate directory with symlinks
shopt -s nullglob
#Exclude self, README.md and any files given as arguments
declare -a exclude=(${0#*/} "README.md" "$@")
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
