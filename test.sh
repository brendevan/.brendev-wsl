#!/bin/bash

func () {
  
  ARR=("$@")

  for I in "${ARR[@]}";
    do
      echo "$I"
    done 
  
}

arr=(a b c)

func "${arr[@]}"