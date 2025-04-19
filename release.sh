#! /usr/bin/bash
set -uvx
set -e
./do-analyze.sh
./do-test.sh
dart pub publish
git add .
git commit -m.
git push
