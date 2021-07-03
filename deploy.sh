#!/bin/sh
EMOJI_SEDSTRING=$(./compile_emoji_sedstring.sh)
find . -type f -name '*.md' -exec ./convert.sh {} "$EMOJI_SEDSTRING" \;
rsync -zarv --exclude=".git" --exclude="*.md" . root@eug-vs.xyz:/var/www/website

