#!/bin/sh

function hello(){
  input=$(cat)
  echo "$input hi"
}

function world(){
  input=$(cat)
  echo "$input world"
}

function compose(){
  eval "$1" | eval "$2"
}
compose hello world
