#!/bin/bash
set -e
yarn run build
cd dist
git init .
git add .
git commit -m "deploy"
git push -f https://github.com/suapapa/site-hangulclocks master:gh-pages

