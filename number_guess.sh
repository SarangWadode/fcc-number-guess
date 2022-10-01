#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

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
  echo "Welcome, $USERNAME! It looks like this is your first time here."

  #insert to users table
  INSERTED_TO_USERS=$($PSQL "insert into users(name) values('$USERNAME')")
  #get user_id
  USER_ID=$($PSQL "select u_id from users where name = '$USERNAME'")
  echo $USER_ID
fi

#secret number
SECRET=$(( 1 + $RANDOM % 1000 ))

#count guesses
TRIES=0
#guess number
echo "Guess the secret number between 1 and 1000:"
echo $SECRET
read GUESS


#track count of tries
#if correct guess
if [[ $SECRET = $GUESS ]]
then
  TRIES=$(( $TRIES + 1 ))
  echo "You guessed it in $TRIES tries. The secret number was $SECRET. Nice job!"
  #insert into db
#if greater
elif [[ $SECRET -gt $GUESS ]]
then
  TRIES=$(( $TRIES + 1 ))
  echo "It's higher than that, guess again:"
#if smaller
else
  TRIES=$(( $TRIES + 1 ))
  echo "It's lower than that, guess again:"
fi

