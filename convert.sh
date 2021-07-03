#!/bin/sh
echo Writing to ${1%.*}.html

if [ -z "${2}" ]; then
    SEDSTRING=$(./compile_emoji_sedstring.sh)
else
    SEDSTRING=$2
fi

cat "$1" \
  | sed "s/.md)/.html)/g; $SEDSTRING" \
  | pandoc -s --from=gfm+emoji --to=html -c /style.css -B header.html -H icon.html -M pagetitle="Eugene's Space" --shift-heading-level-by=1 > ${1%.*}.html
