f () {
  if [[ "--message" in "$@" ]]; then echo "yes"; fi
  echo $@
}