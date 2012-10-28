#!/usr/bin/env sh
# 

cd /var/www/
# find all jpegs in upload folder and optimize them w/o stripping metadata
# output of find is filtered to paths with containing an uploads folder and NOT 
# containing a Typo3 sysext folder.
#symlinks are followed

find . -L -iname \*.jp*g -type f | grep uploads | grep -v sysext| xargs -0 jpegoptim --strip-com --strip-exif --strip-icc



# Running optipng with highest optimization level on all found png
find . -iname \*.png -type f | grep uploads | grep -v sysext| xargs -0 optipng -o7

echo "All Done, see your bandwithmeter dropping. "
exit 0;