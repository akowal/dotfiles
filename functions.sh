info () {
  printf "\r  \033[00;34m[ .. ] $1\033[0m\n"
}

warn () {
  printf "\r\033[2K  \033[00;33m[ !! ] $1\033[0m\n"
}

error () {
  printf "\r\033[2K  \033[0;31m[ ERR ] $1\033[0m\n"
}

success () {
  printf "\r\033[2K  \033[00;32m[ OK ] $1\033[0m\n"
}

realpath(){ perl -MCwd -e 'print Cwd::abs_path shift' "$1";}

