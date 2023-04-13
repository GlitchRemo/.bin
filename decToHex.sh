#! /bin/zsh


function convert_to_hex_digit() {
  case $1 in 
    10) echo "A";;
    11) echo "B";;
    12) echo "C";;
    13) echo "D";;
    14) echo "E";;
    15) echo "F";;
    *)  echo $1;;
  esac
}

function hexadecimal_converter() {
  DEC=$1
  N=$DEC
  HEX=""
  while [ $N -ne 0 ]
  do 
    REMAINDER=$(bc -e "$N % 16");
    REMAINDER=$(convert_to_hex_digit $REMAINDER);
    HEX=$REMAINDER$HEX;
    N=$(bc -e "$N / 16");
  done
  echo $HEX
}

