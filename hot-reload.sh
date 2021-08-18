#!/bin/sh
# Automatically recompile Markdown sources when they change

find -type f -name '*.md' | entr -s "make localize"
