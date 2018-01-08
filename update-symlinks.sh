#!/usr/bin/env sh

source functions.sh

function symlink() {
  if [ -e "$2" ] || [ -h "$2" ]; then
      backup="$2.$(date +%Y%m%dT%H%M).bak"
      warn "$2 already exists, backing up to $backup"
      mv "$2" "$backup"
  fi
  if ln -s "$1" "$2"; then
      success "Symlinked $2 to $1"
  else
      error "Failed to symlink $2 to $1"
  fi
}

info "Symlinking homedir entries"
for name in homedir/*; do
  src="$(realpath $name)"
  target="$HOME/.$(basename $name)";
  symlink "$src" "$target"
done
