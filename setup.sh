#!/bin/bash
read -p "Enter Your GitHub Username: "  username
read -s -p "Enter Your GitHub Password: "  password

if test -e asd-projects; then
    rm -rf asd-projects
fi

mkdir asd-projects
cd asd-projects

git clone https://${username}:${password}@github.com/operationspark/asd-debugging-exercise debugging-exercise
git clone https://${username}:${password}@github.com/operationspark/asd-walker walker
git clone https://${username}:${password}@github.com/operationspark/asd-pong pong
git clone https://${username}:${password}@github.com/operationspark/asd-image-filtering image-filtering
git clone https://${username}:${password}@github.com/operationspark/asd-sorting sorting-exercise

cd debugging-exercise
rm -rf .git* .master
cd ../walker
rm -rf .git* .master
cd ../pong
rm -rf .git* .master
cd ../image-filtering
rm -rf .git* .master
cd ../sorting-exercise
rm -rf .git* .master
