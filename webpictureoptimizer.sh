#!/usr/bin/env sh
# 

cd /var/www/ && find . -iname \*.jp*g -type f | grep uploads | grep -v sysext| xargs -0 jpegoptim -n --strip-com --strip-exif --strip-icc