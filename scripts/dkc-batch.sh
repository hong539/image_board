#!/bin/bash

# @file
# If an application is comprised of multiple docker-compose.yml files, this file
# allows you to execute docker-compose commands for all files in a batch.
# For this to work, place this file into a directory and place each
# docker-compose environment in a subdirectory.
#
# Example:
# /maindir
# /maindir/dkc-batch.sh
# /maindir/project_a
# /maindir/project_a/docker-compose.yml
# /maindir/project_b
# /maindir/project_b/docker-compose.yml
#
# Running "./dkc-batch.sh up" will bring up the environments for project a and b.

WORKDIR=$(pwd)
COMMAND="$1"

# Define array of valid environments.
declare -a VALID_DOCKER_COMPOSE_COMMANDS=("build" "bundle" "config" "create" "down" "events" "exec" "kill" "logs" "pause" "port" "ps" "pull" "push" "restart" "rm" "run" "scale" "start" "stop" "top" "up" "version")

# Execute a docker command in all directories that
# contain a docker-compose file.
function docker_compose_batch {
  DKC_COMMAND=$1

  # Error check for missing command.
  if [ -z "${DKC_COMMAND}" ]
  then
    echo "No commmand passed. Exiting."
    exit 1
  fi

  # Determine help text for this command.
  HELP_TEXT=$(docker-compose ${DKC_COMMAND} --help | sed -n 1p)

  # For upping environments, run command in detached mode.
  case ${DKC_COMMAND} in
    # When destroying all environments, make sure that's what the user wants to do.
    # @see http://stackoverflow.com/questions/226703/how-do-i-prompt-for-yes-no-cancel-input-in-a-linux-shell-script#answer-27875395
    'down' )
      echo -n "Are you sure you want to destroy all of your environments and irrevocably delete all of your data (y/n) ? "
      read answer
      if echo "$answer" | grep -iq "^y" ;then
          echo "Ok, here we go ..."
      else
          echo "Phew, that was close!"
          exit 0
      fi
      BATCH_COMMAND="docker-compose ${COMMAND}"
      ;;
    'up' ) BATCH_COMMAND="docker-compose up -d"
    ;;
    * ) BATCH_COMMAND="docker-compose ${COMMAND}"
  esac

  # Valid commands. Print some help text.
  echo "Attempting to execute \"${DKC_COMMAND}\" in all valid environments."
  echo "Command Purpose: ${HELP_TEXT}"
  echo ""

  # Loop over sub-directories
  for d in */ ; do
    # Get expected path for docker-compose file.
    DOCKER_COMPOSE_YML_FILE_PATH="${WORKDIR}/${d}docker-compose.yml"

    # Check for existance of docker-compose file.
    if [ -e ${DOCKER_COMPOSE_YML_FILE_PATH} ]
    then
      echo "Found ${DOCKER_COMPOSE_YML_FILE_PATH}."
      cd ${WORKDIR}/${d}
      ${BATCH_COMMAND}
      echo ""
    fi
  done
}

# Helper function: Check if item is in array.
# @ see https://raymii.org/s/snippets/Bash_Bits_Check_If_Item_Is_In_Array.html
function in_array() {
  local haystack=${1}[@]
  local needle=${2}
  for i in ${!haystack}; do
    if [[ ${i} == ${needle} ]]; then
      return 0
    fi
  done
  return 1
}

# Check for valid mode.
if in_array VALID_DOCKER_COMPOSE_COMMANDS "${COMMAND}"; then
  # Execute command in batch mode.
  docker_compose_batch "${COMMAND}"
else
  echo "Your command is not supported."
  exit 1
fi