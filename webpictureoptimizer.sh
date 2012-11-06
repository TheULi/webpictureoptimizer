#!/usr/bin/env sh
#
# check for jpegoptim, png and pngout. Aborting when not installed.
command -v jpegoptim >/dev/null 2>&1 || { echo >&2 "I require jpegoptim but it's not installed.  Aborting."; exit 1; }
command -v optipng >/dev/null 2>&1 || { echo >&2 "I require optipng but it's not installed.  Aborting."; exit 1; }
command -v pngout >/dev/null 2>&1 || { echo >&2 "I require pngout but it's not installed.  Aborting."; exit 1; }

# first some system information ist gathered, on a quadcore, 3 threads will be in parallel use 
CPUCOUNT=`grep -c processor /proc/cpuinfo`
if [ $CPUCOUNT -gt 1 ] 
then    THREADS=$(($CPUCOUNT-1))
else    THREADS=1
fi  

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