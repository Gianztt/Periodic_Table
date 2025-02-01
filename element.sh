#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

element_description() {
GET_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$GET_ATOMIC_NUMBER")
GET_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$GET_ATOMIC_NUMBER")
#It's a nonmetal, with a mass of 1.008 amu. 
GET_TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$GET_ATOMIC_NUMBER")
GET_TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$GET_TYPE_ID")
GET_ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$GET_ATOMIC_NUMBER")
#Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.
GET_MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$GET_ATOMIC_NUMBER")
GET_BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$GET_ATOMIC_NUMBER")

echo "The element with atomic number $GET_ATOMIC_NUMBER is $GET_NAME ($GET_SYMBOL). It's a $GET_TYPE, with a mass of $GET_ATOMIC_MASS amu. $GET_NAME has a melting point of $GET_MELTING_POINT celsius and a boiling point of $GET_BOILING_POINT celsius."
}

if [[ -z $1 ]]
  then
  echo "Please provide an element as an argument."
elif [[ $1 =~ ^[0-9]+$ ]]
  then
  GET_ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE $1=atomic_number")

  if [[ -z $GET_ATOMIC_NUMBER ]]
    then
    echo "I could not find that element in the database."
  else
    element_description
  fi

elif [[ $1 =~ ^[a-zA-Z]+$ ]]
  then
  GET_ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE '$1'=symbol OR '$1'=name")

  if [[ -z $GET_ATOMIC_NUMBER ]]
    then
    echo "I could not find that element in the database."
  else
    element_description
  fi

fi




