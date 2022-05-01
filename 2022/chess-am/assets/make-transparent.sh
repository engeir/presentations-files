#!/bin/sh

for f in "$@"; do
    convert "$f" -fuzz 2% -transparent white "$f"
done
