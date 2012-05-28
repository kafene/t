#!/bin/sh
# t: minimalistic todo list for your command line
# http://github.com/unu/t

f="$HOME/todo.txt"
def="[m"; err="[1;31m"; num="[1;34m"; tag="[36m"
h(){ echo 't: minimalistic todo list for your command line
usage:
    t                 # show all items
    t Buy milk +shop  # add item with tag +shop
    t +shop +city     # list tags +shop and +city
    t 2 4             # delete items 2 and 4
    t -e              # open list in editor
    t -d              # edit source code (develop)
    t -h              # show this help'; }
t(){ nl -w 3 -s ' ' -b a "$f"; } # dump
r(){ echo "$(grep -v '^ *$' "$f")" > "$f"; } # reorder
edit(){ exec "${EDITOR:-vi}" "$1"; }
clr(){ sed 's/\([0-9]*\) /'$num'\1'$def' /g; s/\(+[^ ]*\)/'$tag'\1'$def'/g'; }
add(){ echo "$*" >> "$f"; t | tail -n 1 | clr; }
del(){
  for i in $*; do
    s="$(t | grep "^ *$i ")"
    if test "$s"; then
      echo "$(head "$f" -n $(($i-1)); echo; tail "$f" -n +$(($i+1)))" > "$f"
      echo "${err}Deleted${def} $(echo $s | clr)"
    else echo "${err}There's no task ${num}$i${def}"; fi
  done 
}
tag(){
  for i in $(echo "$*" | sed 's/+/ /g'); do
    t | sed 's/$/ /' | grep "+$i "
  done | sort -d | uniq | clr
}
test -f "$f" || touch "$f"
case "$*" in
  '')         r; t | clr;;   # list
  e|-e)       r; edit "$f";; # edit
  d|-d)       edit "$0";;    # develop
  h|-*)       h;;            # help
  +*)         r; tag "$*";;  # tag
  *[!0-9\ ]*) add "$*"; r;;  # add
  *)          del "$*";;     # delete
esac
