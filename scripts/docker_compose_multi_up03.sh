	#!/bin/bash
	 
	# Function to run multiple docker-compose.yaml files under different directories.
	# This function takes a directory path as input and looks for docker-compose.yaml files recursively.
	# It then runs each docker-compose.yaml file using the "docker-compose up" command.
	 
	# @param $1: The directory path to search for docker-compose.yaml files.
	run_multiple_docker_compose() {
	    local directory="$1"  # Capture the directory path passed as a parameter.
	 
	    # Check if the directory exists.
	    if [ ! -d "$directory" ]; then
	        echo "Directory '$directory' does not exist."
	        exit 1
	    fi
	 
	    # Find all docker-compose.yaml files recursively in the directory.
	    local compose_files
	    compose_files=$(find "$directory" -name "docker-compose.yaml")
	 
	    # Check if any docker-compose.yaml files were found.
	    if [ -z "$compose_files" ]; then
	        echo "No docker-compose.yaml files found in '$directory' or its subdirectories."
	        exit 1
	    fi
	 
	    # Iterate over each docker-compose.yaml file and run it using docker-compose.
	    for file in $compose_files; do
	        echo "Running docker-compose.yaml: $file"
	        docker-compose -f "$file" up -d
	    done
	}
	 
	# Usage example for run_multiple_docker_compose.sh
	 
	# Example: Run multiple docker-compose.yaml files under the "projects" directory.
	run_multiple_docker_compose "projects"