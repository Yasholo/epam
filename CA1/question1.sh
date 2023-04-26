#!/bin/bash

file_info() {
  local file_type=""
  local file_name=""
  for file_name in "$@"; do
    if [ -f "$file_name" ]; then
      file_type="regular file"
    elif [ -d "$file_name" ]; then
      file_type="directory"
    else
      file_type="other type of file"
    fi
    echo "File type: $file_type"
    ls -l "$file_name"
  done
}

file_count() {
  local count=0
  local file_name=""
  for file_name in "$@"; do
    if [ -f "$file_name" ]; then
      count=$((count + 1))
    fi
  done
  echo "Number of regular files: $count"
}

echo "File information:"
file_info "$@"

echo "File count:"
file_count "$@"
