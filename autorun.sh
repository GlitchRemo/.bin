#! /bin/zsh

source style.sh

function showStatus() {
  echo 
  purple_fg "$1" 
}

function spinner() {
  local TEXT="$1"

  echo -ne "\033[?25l"
  for ES in $(jot -w"%x" 28 200)
  do
    sleep 0.1
    echo -ne "\r\UE3"$ES$TEXT
  done
}

function execute() {
  local COMMAND=$1
  local FILE=$2
  local PREVIOUS_TIME=$(date -r $FILE)

  while [ 1 ] 
  do
    local CURRENT_TIME=$(date -r $FILE)
    if [ "$PREVIOUS_TIME" != "$CURRENT_TIME" ]
    then
      clear
      $COMMAND $FILE
      showStatus "$CURRENT_TIME"
      PREVIOUS_TIME=$CURRENT_TIME
    fi
    local TEXT=" Running..."$COMMAND" "$FILE
    spinner "$TEXT"
  done
}

execute $1 $2
