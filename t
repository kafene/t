#!/bin/sh
# t: minimalistic todo list for your command line
# http://github.com/unu/t

f="$HOME/todo.txt"
h() echo "t: minimalistic todo list for your command line
usage: t                 # show list
       t Buy milk +shop  # add item with tag
       t +shop           # list items tagged +shop
       t 1 2             # delete first and second item
       t e               # open in editor
       t -h, --help      # show this message"
t(){ nl -w 3 -s ". " -b a "$f" | grep -v '^[0-9\. ]*$'; } # dump
r(){ echo "$(grep -v '^ *$' "$f")" > "$f"; } # reorder
clr(){ sed 's/\([0-9]*\)\./[1;34m\1[m/g; s/\(+[^ ]*\)/[36m\1[m/g'; } # colors
del(){ # delete
  s="$(t | grep "^ *$1\.")"
  if test "$s"; then
    echo "$(head "$f" -n $(($1-1)); echo; tail "$f" -n +$(($1+1)))" > "$f"
    echo "Deleted #$1: ${s#*. }"
  else echo "There is no task #$1"; fi
}
test -f "$f" || touch "$f"
case "$*" in
  -h|--help)  h;; # help
  '')         r; t | clr;; # list
  e)          r; exec "${EDITOR:-vi}" "$f";; # editor
  +*)         r; t | sed 's/$/ /' | grep "$1 " | clr;; # tag
  *[!0-9\ ]*) echo "$*" >> "$f"; echo "Added #$(cat "$f" | wc -l): $*"; r;; # add
  *)          for i in $*; do del "$i"; done;; # delete
esac
