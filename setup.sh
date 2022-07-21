#!/bin/bash

printf "\n"

if test -e asd-projects; then
    rm -rf asd-projects
fi

mkdir asd-projects
cd asd-projects

git clone https://github.com/operationspark/asd-data-shapes data-shapes
git clone https://github.com/operationspark/asd-walker walker
git clone https://github.com/operationspark/asd-pong pong
git clone https://github.com/operationspark/asd-image-filtering image-filtering
git clone https://github.com/operationspark/asd-sorting sorting-exercise

if ! test -e data-shapes || ! test -e walker || ! test -e pong || ! test -e image-filtering || ! test -e sorting-exercise; then
    printf "\nFAILURE: Some projects could not be accessed on GitHub. Please run the script again."
else
    #data-shapes
    cd data-shapes
    rm -rf .git* .master

    #walker
    cd ../walker
    rm -rf .git* .master

    #pong
    cd ../pong
    rm -rf .git* .master

    #image-filtering
    cd ../image-filtering
    rm -rf .git* .master

    #sorting-exercise
    cd ../sorting-exercise
    rm -rf .git* .master

    printf "\nSUCCESS: All projects succesfully installed.\n"
fi
