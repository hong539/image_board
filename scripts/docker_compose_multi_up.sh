#!/bin/bash

# Define an array of directories containing Docker Compose files
declare -a dirs=("/path/to/dir1" "/path/to/dir2" "/path/to/dir3")

# Loop through each directory and run the Docker Compose file
for dir in "${dirs[@]}"
do
  cd "$dir"
  docker-compose up -d
done