#!/usr/bin/env sh
# 

cd /var/www/
# find all jpegs in upload folder and optimize them w/o stripping metadata
find . -iname \*.jp*g -type f | grep uploads | grep -v sysext| xargs -0 jpegoptim -n --strip-com --strip-exif --strip-icc

exit 0;

# Running optipng with highest optimization level on all foud png
find . -iname \*.png -type f | grep uploads | grep -v sysext| xargs -0 optipng -o7
exit 0;