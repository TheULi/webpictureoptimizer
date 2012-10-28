webpictureoptimizer
===================

small shell-script for lossless compression of uploaded pictures in CMS

First supported CMS will be Wordpress.

It utilizes jpegoptim and optipng.

The idea is quite basic, the script changes to /var/www/, then searches for image-files in "uploads" folders and does lossless compression. 
It shall be run as cron-weekly.
Copyright-Data will be preserved.



This is my first "real"-project, feel free to contribute or at least point at obvious errors

ToDo
-check if jpegoptim and optipng are installed
-storing last-run-date in a file, so only newer files are touched
-creation of a logfile after each run


This program is free software. It comes without any warranty, to
the extent permitted by applicable law. You can redistribute it
and/or modify it under the terms of the Do What The Fuck You Want
To Public License, Version 2, as published by Sam Hocevar. See
http://sam.zoy.org/wtfpl/COPYING for more details.