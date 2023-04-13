#! /bin/zsh

function spinner() {
  while [ 1 ]
  do
    echo -ne "\033[?25l"
    sleep 0.2
    echo -ne "\b\UEE00"
    sleep 0.2
    echo -ne "\b\UEE01"
    sleep 0.2
    echo -ne "\b\UEE02"
    sleep 0.2
    echo -ne "\b\UEE03"
    sleep 0.2
    echo -ne "\b\UEE04"
    sleep 0.2
    echo -ne "\b\UEE05"
  done
}

spinner
