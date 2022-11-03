#!/bin/bash

if [ -z "$1" ]
then
  . bump.sh
  cd .. && cd MSc-SportBuddy-backend && . bump.sh
  cd .. && cd MSc-SportBuddy-Web && . bump.sh
else
  . bump.sh $1
  cd .. && cd MSc-SportBuddy-backend && . bump.sh $1
  cd .. && cd MSc-SportBuddy-Web && . bump.sh $1
fi