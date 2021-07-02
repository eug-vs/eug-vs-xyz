#!/bin/sh
find . -type f -name '*.md' -exec ./convert.sh {} \;
rsync -zarv --exclude=".git" --exclude="*.md" . root@eug-vs.xyz:/var/www/website

