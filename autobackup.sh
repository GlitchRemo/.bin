#! /bin/bash

function versionControl() {
  local DIRECTORY=$1

  while [ 1 ]
  do
    local NUMBER_OF_MODIFIED_FILES=$(find $PWD -mmin -5 | wc -l);

    if [ $NUMBER_OF_MODIFIED_FILES -gt 0 ]
    then 
      local FILE_NAME=$DIRECTORY
      backup.sh $FILE_NAME $DIRECTORY
    fi
    sleep 300
  done
}

versionControl $1
