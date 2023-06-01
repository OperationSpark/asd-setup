#!/bin/bash

printf "\n"

if test -e asd-projects; then
  rm -rf asd-projects
fi

mkdir asd-projects
cd asd-projects

git clone https://github.com/operationspark/asd-data-shapes data-shapes
https://github.com/OperationSpark/asd-debugging-exercise debugging-exercise
git clone https://github.com/operationspark/asd-walker walker
git clone https://github.com/operationspark/asd-image-filtering image-filtering
git clone https://github.com/operationspark/asd-sorting sorting-exercise
git clone https://github.com/operationspark/snake-fsd snake

if ! test -e data-shapes || ! test -e debugging-exercise ! test -e walker || ! test -e image-filtering || ! test -e sorting-exercise || ! test -e snake ; then
  printf "\nFAILURE: Some projects could not be accessed on GitHub. Please run the script again."
else
  #check for existing project-instructions folder
  if ! test -e project-instructions; then
    mkdir ../project-instructions;
  fi

  #READMEs
  cp data-shapes/README.md ../project-instructions/data-shapes.md
  cp debugging-exercise/README.md ../project-instructions/debugging.md
  cp walker/README.md ../project-instructions/walker.md
  cp snake/README.md ../project-instructions/snake.md
  cp image-filtering/README.md ../project-instructions/image-filtering.md
  cp sorting-exercise/README.md ../project-instructions/sorting-exercise.md

  #data-shapes
  cd data-shapes
  rm -rf .git* .master

  #debugging
  cd ../debugging-exercise
  rm -rf .git* .master
  
  #walker
  cd ../walker
  rm -rf .git* .master

  #snake
  cd ../snake
  rm -rf .git* .master

  #image-filtering
  cd ../image-filtering
  rm -rf .git* .master

  #sorting-exercise
  cd ../sorting-exercise
  rm -rf .git* .master

  printf "\nSUCCESS: All projects succesfully installed.\n"
fi
