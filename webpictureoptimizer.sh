#!/usr/bin/env sh
# 
# first some system information ist gathered, on a quadcore, 3 threads will be in parallel use- 
CPUCOUNT=`grep -c processor /proc/cpuinfo`
THREADS=$(($CPUCOUNT-1))
echo "$CPUCOUNT Cores found, using $THREADS threads parallel"


# find all jpegs in upload folder and optimize them w/o stripping copyright-metadata
# output of find is filtered to paths with containing an uploads folder.
#symlinks are followed
#   
 
find -L -iname \*.jp*g  | grep -a -Z uploads | xargs -n 1 -P $THREADS jpegoptim -o -t -v --strip-com --strip-exif --strip-icc

# Running optipng with highest optimization level on all found png
find . -iname \*.png -type f | grep uploads | xargs -n 1 -P $THREADS optipng -o2
  
#pngout to compress png further after optimization
# pngout can be found at: http://www.jonof.id.au/kenutils
# to work properly, either copy the script to /usr/bin oder set a symlink
 
find . -iname \*.png -type f | grep uploads | xargs -n 1 -P $THREADS pngout 
#tbd
echo "All Done, see your bandwithmeter dropping. "
exit 0;