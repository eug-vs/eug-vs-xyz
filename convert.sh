#!/bin/sh
echo Writing to ${1%.*}.html
cat "$1" \
  | sed 's/.md)/.html)/g' \
  | pandoc -s --from=gfm --to=html -c /style.css -B header.html -H icon.html -M pagetitle="Eugene's Space" --shift-heading-level-by=1 > ${1%.*}.html
