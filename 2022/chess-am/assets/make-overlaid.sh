#!/bin/bash

p=0
while getopts ":p:" opt; do
    case "$opt" in
    p)
        p=${OPTARG}
        ;;
    :)
        echo "Missing argument for option -$OPTARG"
        exit 1
        ;;
    \?)
        echo "Unknown option -$OPTARG"
        exit 1
        ;;
    esac
done

# here's the key part: remove the parsed options from the positional params
shift $((OPTIND - 1))

if [ "$p" -eq "1" ]; then
    extension="280x170"
    translation="+300+50"
    cropping="0x0+90+50"
    location="northeast"
elif [ "$p" -eq "2" ]; then
    extension="280x230"
    translation="+300-5"
    cropping="0x0+60+0"
    location="northeast"
else
    extension=${3:-350x150}
    translation=${4:-+350+250}
    cropping=${5:-0x0+170+20}
    location=${6:-southeast}
fi

# Make white background of 2nd image transparent
convert "$2" -channel rgba -fuzz 2% -transparent white transparent.png
# convert "$2" -channel rgba -fuzz 2% -matte -fill "rgba(255,255,255,0.4)" -opaque "rgb(255,255,255)" transparent.png
# Extend white background of first image
convert "$1" -background white -gravity "$location" -splice "$extension" extended.png
# Make a composite image of the two that are shifted/translated
composite -geometry "$translation" transparent.png extended.png composite.png
# Remove wide borders
convert composite.png -crop "$cropping" overlaid.png

# Clean up
rm composite.png transparent.png extended.png
