#! /bin/bash

# tic_tac_toe is a two player board game starting with player 1
# player 1 and player 2 will play alternatively
# player 1 plays with X
# player 2 plays with O
# player who will fill a single row or column or a diagonal first will win the game
# else the game will be a draw 

# updates the board for each play
BOARD="| 1 | 2 | 3 |\n| 4 | 5 | 6 |\n| 7 | 8 | 9 |"
function board(){
  local CELL_NUMBER=$1
  local PLAYER_SIGN=$2
  if [ $CELL_NUMBER ]
  then
    BOARD=$(echo $BOARD | tr "$CELL_NUMBER" "$PLAYER_SIGN")
  fi
  echo -e $BOARD | grep --color "[XO ]"
}

function is_within_range(){
  POSITION=$1
  if [ $POSITION -gt 9 -o $POSITION -lt 1 ]
  then
    read -p "Enter a number between 1 and 9 : " POSITION
    is_within_range $POSITION
    POSITION=$?
  fi
  return $POSITION
}

function get_legal_position(){
  local NUMBER=$1
  local PATTERN1=$2
  local PATTERN2=$3
  local IS_NUMBER_PRESENT=" "
  IS_NUMBER_PRESENT=$IS_NUMBER_PRESENT$(echo $PATTERN1 | grep $NUMBER)
  IS_NUMBER_PRESENT=$IS_NUMBER_PRESENT$(echo $PATTERN2 | grep $NUMBER)
  
  if [ $IS_NUMBER_PRESENT ]
  then
    read -p "Position already filled. Enter another number: " NUMBER
    get_legal_position $NUMBER $PATTERN1 $PATTERN2
    NUMBER=$?
  fi
  return $NUMBER
}

# check if a given pattern is a winning pattern
function is_a_winning_pattern(){
  
  local PATTERN_TO_BE_MATCHED=$1
  local MATCHED_PATTERN
  MATCHED_PATTERN=$MATCHED_PATTERN$(echo $PATTERN_TO_BE_MATCHED | grep 1 | grep 2 | grep 3)
  MATCHED_PATTERN=$MATCHED_PATTERN$(echo $PATTERN_TO_BE_MATCHED | grep 4 | grep 5 | grep 6)
  MATCHED_PATTERN=$MATCHED_PATTERN$(echo $PATTERN_TO_BE_MATCHED | grep 7 | grep 8 | grep 9)
  MATCHED_PATTERN=$MATCHED_PATTERN$(echo $PATTERN_TO_BE_MATCHED | grep 1 | grep 5 | grep 9)
  MATCHED_PATTERN=$MATCHED_PATTERN$(echo $PATTERN_TO_BE_MATCHED | grep 1 | grep 4 | grep 7)
  MATCHED_PATTERN=$MATCHED_PATTERN$(echo $PATTERN_TO_BE_MATCHED | grep 2 | grep 5 | grep 8)
  MATCHED_PATTERN=$MATCHED_PATTERN$(echo $PATTERN_TO_BE_MATCHED | grep 3 | grep 6 | grep 9)
  MATCHED_PATTERN=$MATCHED_PATTERN$(echo $PATTERN_TO_BE_MATCHED | grep 3 | grep 5 | grep 7)
  test $MATCHED_PATTERN 
}

# asserts won player 
function has_won(){
local PATTERN=$1
is_a_winning_pattern $PATTERN
return $?
}

function increment(){
  dc -e "$1 1 + p"
}

# return 0 for draw 
# return 1 for player1 win 
# return 2 for player2 win
function player(){

  local CURRENT_TURN=$1
  local PLAYER_NUMBER=$2
  local PLAYER_SIGN=$3
  local PLAYER1_PROGRESS_PATTERN=$4
  local PLAYER2_PROGRESS_PATTERN=$5

  # check if all the cells of the board get filled
  if [ $CURRENT_TURN -gt 9 ]
  then 
    return 0
  fi

  # read input
  read -p "Player $PLAYER_NUMBER : " CELL_NUMBER
  is_within_range $CELL_NUMBER
  CELL_NUMBER=$?
  get_legal_position $CELL_NUMBER $PLAYER1_PROGRESS_PATTERN $PLAYER2_PROGRESS_PATTERN
  CELL_NUMBER=$?
  board $CELL_NUMBER $PLAYER_SIGN
  
  if [ $PLAYER_NUMBER -eq 1 ]
  then
    PLAYER1_PROGRESS_PATTERN=$PLAYER1_PROGRESS_PATTERN$CELL_NUMBER
    local PATTERN=$PLAYER1_PROGRESS_PATTERN
  else
    PLAYER2_PROGRESS_PATTERN=$PLAYER2_PROGRESS_PATTERN$CELL_NUMBER
    local PATTERN=$PLAYER2_PROGRESS_PATTERN
  fi

  if has_won $PATTERN
  then
    return $PLAYER_NUMBER
  fi


  # update current player progress
  # assign the next player
  PLAYER_NUMBER=1
  PLAYER_SIGN=X
  if [ $PLAYER_NUMBER -eq 1 ]
  then
    PLAYER_NUMBER=2
    PLAYER_SIGN=O
  fi

  CURRENT_TURN=$(increment $CURRENT_TURN)
  player $CURRENT_TURN $PLAYER_NUMBER $PLAYER_SIGN $PLAYER1_PROGRESS_PATTERN $PLAYER2_PROGRESS_PATTERN
}

function main(){
  local PLAYER_NUMBER=1
  local PLAYER_SIGN=X
  local CURRENT_TURN=1
  local PLAYER1_PROGRESS_PATTERN=" "
  local PLAYER2_PROGRESS_PATTERN=" "

  board
  player $CURRENT_TURN $PLAYER_NUMBER $PLAYER_SIGN $PLAYER1_PROGRESS_PATTERN $PLAYER2_PROGRESS_PATTERN
  echo $? "won"
}

main










# runs an extra round after one player wins 


   #  # check if player 1 has won
   #  if  has_won $PLAYER1_PROGRESS_PATTERN
   #  then
   #    return $PLAYER_NUMBER
   #  fi
   #  PLAYER2_PROGRESS_PATTERN=$PLAYER2_PROGRESS_PATTERN$CELL_NUMBER
   #  # check if player 2 has won
   #  if  has_won $PLAYER2_PROGRESS_PATTERN
   #  then
   #    return $PLAYER_NUMBER
   #  fi
