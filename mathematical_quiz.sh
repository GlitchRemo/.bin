# /bin/zsh

# mathematical quiz give contestant an arithmetic operation to solve
# our program asserts whether contestant's answer is correct or wrong
# our program also displays the time taken by the contestent to answer

function wants_to_play() {
  local WISH=$1
  test $WISH -eq 0 
}

function convert_time_in_seconds() {
  local TIME=$1

  local HOURS=$(echo $TIME | cut -d":" -f1)
  local MINUTES=$(echo $TIME | cut -d":" -f2)
  local SECONDS=$(echo $TIME | cut -d":" -f3)
  dc -e " $HOURS 60 60 * * $MINUTES 60 * $SECONDS + + p "
}

function delta_time() {
  local FINAL_TIME=$1
  local INITIAL_TIME=$2

  local FINAL_TIME_IN_SECONDS=$(convert_time_in_seconds $FINAL_TIME)
  local INITIAL_TIME_IN_SECONDS=$(convert_time_in_seconds $INITIAL_TIME)

  dc -e " $FINAL_TIME_IN_SECONDS $INITIAL_TIME_IN_SECONDS - p "
}

function display_time_passed() {
  TIME_AFTER_SOLVING=$1
  TIME_BEFORE_SOLVING=$2
  echo $(delta_time $TIME_AFTER_SOLVING $TIME_BEFORE_SOLVING) "seconds passed"
}

function generate_random_number(){
  jot -r 1 $1 $2
}

function generate_random_operator(){
  echo "+\n-\n/\nx\n%" | sort -R | head -n1
}

function calculate(){
  echo "$1 $3 $2 p" | tr "x" "*" | dc 
}

function is_valid_answer(){
  test  $1 -eq $2 
}

function quiz(){
  local UPPER_BOUND=1
  local LOWER_BOUND=100
  local EXIT_CODE=1
  local RESULT="wrong"

  local OPERAND1=$(generate_random_number $LOWER_BOUND $UPPER_BOUND )
  local OPERAND2=$(generate_random_number $LOWER_BOUND $UPPER_BOUND )
  local OPERATOR=$(generate_random_operator)
  EXPECTED_ANSWER=$(calculate $OPERAND1 $OPERATOR $OPERAND2)
  read -p "$OPERAND1 $OPERATOR $OPERAND2 = ? " PLAYER_ANSWER

  if is_valid_answer $PLAYER_ANSWER $EXPECTED_ANSWER;
  then
    RESULT="correct"
    EXIT_CODE=0
  fi

  echo $RESULT "answer"
  return $EXIT_CODE
}

function current_timestamp(){
  date "+%H:%M:%S"
}

function main(){
  local WISH=$1

  while  wants_to_play $WISH 
  do
    local TIME_BEFORE_SOLVING=$(current_timestamp)
    quiz
    local TIME_AFTER_SOLVING=$(current_timestamp)
    display_time_passed $TIME_AFTER_SOLVING $TIME_BEFORE_SOLVING

    read -p "0 to play, other to quit " WISH
    main $WISH
    return $?
  done
}

main 0
exit $?
