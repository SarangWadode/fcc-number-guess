#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

random=$(( 1 + $RANDOM % 1000 ))

echo $random

