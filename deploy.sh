#!/bin/sh
rsync -zarv --exclude=".git" . root@eug-vs.xyz:/var/www/website

