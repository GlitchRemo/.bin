#! /bin/bash

# Synopsis ./vimsh.sh [-n] filename
# Create filename.sh in pwd and open it with vim
# The first line of filename.sh will contain #! /bin/bash
# -n option will suppress the opening of the file

function open_file() {
  vim $1.sh
}

function create_file() {
  touch $1.sh
  chmod +x $1.sh
  echo "#! /bin/bash" > $1.sh
}

function main() {
  if [ $1 == "-n" ]
  then
    create_file $2
  else
    create_file $1
    open_file $1
  fi
}

main $1 $2



