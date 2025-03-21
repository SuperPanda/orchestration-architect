
a() {
  ./echo-a.sh
}

b(){
  ./echo-b.sh
}

tensor() {
  { "$1" & "$2" & } | cat
}

tensor a b
