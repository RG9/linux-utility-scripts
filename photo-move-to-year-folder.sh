#!/bin/bash

##################################################################################################
# Groups photos into year folders, provided that file name starts with year, e.g. "20240101.jpg". 
# Use case: cleanup and backup
# Example: cd {folder-with-photos} && sh photo-move-to-year-folder.sh --dryRun=false
##################################################################################################

dryRun=true

# Parse arguments
for arg in "$@"; do
  case $arg in
    --dryRun=false) dryRun=false ;;
    *) echo "Unknown option: $arg"; exit 1 ;;
  esac
done

for file in *.jpg; do
  year=$(echo "$file" | cut -c1-4)
  [ "$dryRun" = false ] || { echo "Would move: $file to /$year"; continue; }
  mkdir -p "$year"
  mv "$file" "$year/"
done
