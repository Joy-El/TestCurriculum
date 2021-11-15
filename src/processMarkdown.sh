#!/usr/bin/bash

# Process Markdown
#  Using the IMAGE_URL_PREFIX from course_variables.sh, update the img references
#  in chosen markdown files

# get IMAGE_URL_PREFIX from course_variables.sh
. ./course_variables.sh
#echo $IMAGE_URL_PREFIX
# escape forward slashes with backslashes (for sed)
ESCAPED_IMAGE_URL_PREFIX=${IMAGE_URL_PREFIX//\//'\/'}
#echo $ESCAPED_IMAGE_URL_PREFIX

for markdownFile in "$@"
do
  # split up markdownFile name
  markdownPath="${markdownFile%%/*}"
  temp="${markdownFile##*/}"
  markdownRoot="${temp%%.*}"
  markdownExtension="${temp#*.}"
  #echo $markdownPath
  #echo $markdownRoot
  #echo $markdownExtension

  # find pattern for images
  # ![](markdownRoot_files/figure-gfm/*.*)<!-- -->
  sed -i "s/!\[\](/!\[\]($ESCAPED_IMAGE_URL_PREFIX/g" $markdownFile
  sed -i "s/<!-- -->//g" $markdownFile
done
