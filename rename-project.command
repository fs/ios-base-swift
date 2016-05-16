#!/bin/bash

export PATH=$PATH:~/usr/local/bin

BASE_NAME="Swift-Base"

#Renaming
transform() {
  # Rename all text entry in files which contain string from first argument
  git grep -lz "$1" | xargs -0 perl -i'' -pE "s/$1/$2/g"
  # Rename all files contains string from first argument
  find . -depth -name "*$1*" -exec bash -c 'for f; do base=${f##*/}; mv -- "$f" "${f%/*}/${base//'$1'/'$2'}"; done' _ {} +
}

DIRECTORY=$(dirname "${0}")
cd "$DIRECTORY"

#Request new name
echo "Input new project name"
read NEW_NAME

#Confirmation
echo "New name is $NEW_NAME in $DIRECTORY"
read -p "Are you sure? " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

#Self destruction
rm ./rename-project.command

#Git setup
git init
git add -A
git commit -m "Inital commit"

#Body
transform "$BASE_NAME" "$NEW_NAME"

#Git renaming commit
git add -A
git commit -m "Rename project"

#Success message
echo "Success"

git status
