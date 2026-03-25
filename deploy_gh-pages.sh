#!/bin/bash
set -e
rm -rf dist
npm run build
cd dist
git init
git checkout -b main
git add .
git commit -m "deploy to github pages"
git push -f git@github.com:suapapa/site-hangulclocks.git main:gh-pages

