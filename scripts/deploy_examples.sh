#!/bin/bash

COMMAND="globe deploy"
CWD=$(pwd)
function return_to_cwd {
  cd "$CWD"
}

for folder in "$CWD/examples"/*; do
  if [ -d "$folder" ]; then
    cd "$folder"
    trap return_to_cwd ERR
    echo "Deploying example in $folder"
    $COMMAND
    trap - ERR
    return_to_cwd
  fi
done
