#!/usr/bin/env bash
#
# declare some variables
USE_JPEGOPTIM=true;
USE_OPTIPNG=true;
USE_PNGOUT=true;

# check for jpegoptim, png and pngout. Aborting when not installed.
command -v jpegoptim >/dev/null 2>&1 || { echo >&2 "I require jpegoptim but it's not installed. Ignoring."; USE_JPEGOPTIM=false; }
command -v optipng >/dev/null 2>&1 || { echo >&2 "I require optipng but it's not installed. Ignoring."; USE_OPTIPNG=false; }
command -v pngout >/dev/null 2>&1 || { echo >&2 "I require pngout but it's not installed. Ignoring."; USE_PNGOUT=false; }

# first some system information ist gathered, on a quadcore, 3 threads will be in parallel use
CPUCOUNT=`grep -c processor /proc/cpuinfo`
if [ $CPUCOUNT -gt 1 ]
then THREADS=$(($CPUCOUNT-1))
else THREADS=1
fi

echo "$CPUCOUNT Cores found, using $THREADS threads parallel"

# find all jpegs in upload folder and optimize them w/o stripping copyright-metadata
# output of find is filtered to paths with containing an uploads folder.
#symlinks are followed
#
if [ $USE_JPEGOPTIM = "true" ]
then find -L -iname \*.jp*g | grep -a -Z uploads | xargs -n 1 -P $THREADS jpegoptim -o -t -v --strip-com --strip-exif --strip-icc
fi

# find all png and store in a file
find . -iname \*.png -type f | grep uploads | xargs -n 1 cat >/tmp/found_png.tmp



# Running optipng with highest optimization level on all found png
if [ $USE_OPTIPNG = "true" ]
then cat < /tmp/found_png.tmp | xargs -n 1 -P $THREADS optipng -o2
fi

#pngout to compress png further after optimization
# pngout can be found at: http://www.jonof.id.au/kenutils
# to work properly, either copy the script to /usr/bin oder set a symlink
if [ $USE_PNGOUT = "true" ]
then cat < /tmp/found_png.tmp | xargs -n 1 -P $THREADS pngout
fi

#
#delete all temporary files after sucessful run

rm /tmp/found_png.tmp

echo "All Done, see your bandwithmeter dropping. "
exit 0;
