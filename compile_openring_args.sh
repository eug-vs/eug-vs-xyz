#!/bin/sh
# Compile args string for openring from URLS file
URLS=urls

sed '/^$/d; s/^/-s /;' $URLS
