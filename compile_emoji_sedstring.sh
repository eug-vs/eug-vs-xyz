#!/bin/sh
cd public/emoji;
for EMOJI in *;
do
  BASENAME=${EMOJI%.*}
  echo "s|:${BASENAME}:|<img src=\\\"public/emoji/${EMOJI}\\\" height=\\\"24px\\\" style=\\\"margin-bottom: -4px\\\">|g; "
done
