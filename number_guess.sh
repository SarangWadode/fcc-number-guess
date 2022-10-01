#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

#random number
random=$(( 1 + $RANDOM % 1000 ))

#get username
echo "Enter your username:"
read USERNAME

#get username from db
USER_ID=$($PSQL "select u_id from users where name = '$USERNAME'")

#if user present
if [[ $USER_ID ]]
then
  #get games played
  GAMES_PLAYED=$($PSQL "select count(u_id) from games where u_id = '$USER_ID'")

  #get best game (guess)
  BEST_GUESS=$($PSQL "select min(guesses) from games where u_id = '$USER_ID'")

  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GUESS guesses."
else
  #if u_name not present in db 
  #insert user
  #get user_id
  echo no user is not present
fi

