#!/bin/bash
# This is a quick bash script to take a pascal (.p) file and compile it in one pass.
FILE=$1

echo "Compiling $FILE..."
./psc < $FILE > "${FILE%.*}.s"
gcc -o "${FILE%.*}" "${FILE%.*}.s"
echo "done!"