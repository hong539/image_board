#!/bin/bash

# Define an array of directories containing Docker Compose files
declare -a dirs=($(find /java -name docker-compose.yml -exec dirname {} \;))

# Loop through each directory and run the Docker Compose file
for dir in "${dirs[@]}"
do
  cd "$dir"
  docker-compose up -d
done