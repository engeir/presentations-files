#!/bin/sh

# Make white background of 2nd image transparent
convert AEROD_v20220404_6m-after_sphere.png -fuzz 2% -transparent white AEROD_v20220404_6m-after_sphere-trans.png
# Extend white background
convert AEROD_v20220404_erupt_sphere.png -background white -gravity southeast -splice 350x150 AEROD_v20220404_erupt_sphere-extended.png
# Make a composite image of the two that are shifted/translated
composite -geometry +350+250 AEROD_v20220404_6m-after_sphere-trans.png AEROD_v20220404_erupt_sphere-extended.png composite.png
# Remove wide borders
convert composite.png -crop 0x0+170+20 AEROD_v20220404-composite.png

# Clean up
rm composite.png AEROD_v20220404_6m-after_sphere-trans.png AEROD_v20220404_erupt_sphere-extended.png
