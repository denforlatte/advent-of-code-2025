#!/bin/bash
# Simple build script for Ada projects

# Compile the Ada source file
gnatmake -o bin/part2 src/part2.adb -D obj/

echo "Build complete! Binary is in bin/part2"
