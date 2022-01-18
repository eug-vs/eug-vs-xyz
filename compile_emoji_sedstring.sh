#!/bin/sh
# Return a large sed command that will substitute all :emoji: listed in /public/emoji with <img>

SIZE=20px
STYLE="margin-bottom: -4px;"

cd public/emoji;
for EMOJI in *;
do
  BASENAME=${EMOJI%.*}
  echo "s|:${BASENAME}:|<img src=\\\"/public/emoji/${EMOJI}\\\" alt=\\\"${BASENAME}-icon\\\" height=\\\"${SIZE}\\\" width=\\\"${SIZE}\\\" style=\\\"${STYLE}\\\">|g; "
done
