#!/bin/bash

set -o errexit -o nounset

rev=$(git rev-parse --short HEAD)

cd book

git init
git config user.name "Giang Nguyen"
git config user.email "nguyengiangdev@gmail.com"

git remote add deploy "https://$GH_TOKEN@github.com/rust-vietnam/rust-programming-language-book.git"
git fetch deploy 
git reset deploy/gh-pages

touch .

git add -A .
git commit -m "rebuild pages at ${rev}"
git push -q deploy HEAD:gh-pages > /dev/null 2>&1
