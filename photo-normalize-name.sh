#!/bin/bash

######################################################################################################
# Normalizes photo's file name to format "yyyyMMdd_HHmmss.jpg". Can normalize ".mp4" and other files.
# Use case: migrate photos from Android, iPhone and others to one folder
# Example: cd {folder-with-photos} && sh photo-normalize-name.sh --dryRun=false
######################################################################################################

dryRun=true

# Parse arguments
for arg in "$@"; do
  case $arg in
    --dryRun=false) dryRun=false ;;
    *) echo "Unknown option: $arg"; exit 1 ;;
  esac
done

for file in *; do
  [ -f "$file" ] || { echo "Skipping non-file item: $file"; continue; }
  extension="${file##*.}"
  if [[ "$extension" =~ ^(JPG|jpeg|JPEG|png|PNG)$ ]]; then
     extension="jpg"
  fi
  if [[ $file =~ ([0-9]{8}_[0-9]{6}) ]]; then
    datetime=${BASH_REMATCH[1]}
  else
     datetime=$(identify -quiet -format '%[EXIF:DateTimeOriginal]' "$file" | sed -E 's/://g' | sed -E 's/ /_/g')
  fi
 [ -n "$datetime"  ] || { echo "Cannot rename: $file"; continue; } 
 new_name="${datetime}.${extension}"
    if [ "$dryRun" = true ]; then
      echo "Would rename: $file to $new_name"
    else
      mv "$file" "$new_name"
    fi
done

