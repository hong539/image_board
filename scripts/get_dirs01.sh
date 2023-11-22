#!/bin/bash

dirs=($(find /path/to/search -type d))
# dirs=(/path/to/dir1 /path/to/dir2 /path/to/dir3)
for dir in "${dirs[@]}"
do
  # Do something with $dir
done


