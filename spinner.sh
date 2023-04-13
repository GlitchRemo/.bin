#! /bin/zsh

source ~/.bin/decToHex.sh

function spinner() {
  TEXT=$1
  echo -ne "\033[?25l"
  sleep 0.2

  for DEC in {200..227}
  do
    ES=$(hexadecimal_converter $DEC)
    echo -ne "\r\UE3"$ES$TEXT
    sleep 0.2
  done
}

