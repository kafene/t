#!/bin/sh
# t: minimalistic todo list for your command line
# http://github.com/unu/t

f="$HOME/todo.txt"
def="[m"; ok="[1;32m"; err="[1;31m"; num="[1;34m"; tag="[36m"
h(){
  cat << eof
t: minimalistic todo list for your command line
usage:
    t                 # show todo list
    t Buy milk +shop  # add item with tag
    t 2 4             # delete items 2 and 4

    t +shop +city     # list tags +shop and +city
    t +               # show used tags
    
    t Parachute ?     # add item to maybe list
    t ?               # show maybe list
    t 1?              # move item 1 to maybe list
    t 3!              # move item 3 to todo list

    t -a              # show all (todo + maybe)
    t -e              # open list in editor
    t -d              # edit source code (develop)
    t -h              # show this help
eof
}
t(){ # get list
  nl -w 3 -s ' ' -b a "$f" | grep -v '^ *[0-9]* *$'
}
r(){ # reorder
  echo "$(grep -v '^ *$' "$f")" > "$f";
  echo "$(grep -v '\?$' "$f"; grep '\?$' "$f")" > "$f";
}
edit(){ # open editor
  exec "${EDITOR:-vi}" "$1"
}
clr(){ # add colors
  sed 's/^\( *[0-9]\+\) /'$num'\1'$def' /g; s/\(+[a-zA-Z]\+\)/'$tag'\1'$def'/g'
}
add(){ # add item
  echo "$*" >> "$f";
  echo "${ok}Added${def} $(echo "$*" | clr)"
}
move(){ # move or delete items
  for i in $*; do
    a="${i##*[!\?\!]}"
    i="${i%[\?\!]}"
    s="$(t | grep "^ *${i} ")"
    s="${s#*[! ] }";
    if test -z "$s" -o -z "$i" ; then echo "${err}There's no task ${num}$i${def}"
    else
      echo "$(head "$f" -n $(($i-1)); echo; tail "$f" -n +$(($i+1)))" > "$f"
      if test -z "$a"; then
        echo "${err}Deleted${def} $(echo $s | clr)"
      else
         s="${s%\?}"
        case "$a" in
         '?') add "$s ?" | true; echo "${ok}Maybe${def} $(echo $s | clr)";;
         '!') add "$s"   | true; echo "${ok}Todo${def} $(echo $s | clr)";;
         *) echo "$a";;
        esac
      fi
    fi
  done 
}
tags(){ # show all tags
  t | grep -o '+[^ ]\+' | sort -u | xargs echo | sed "s/+/$tag+$def/g"
}
tag(){ # list selected tags
  for i in $(echo "$*" | sed 's/+/ /g'); do
    t | sed 's/$/ /' | grep "+$i[^a-zA-Z]"
  done | sort -du | clr
}

# main
test -f "$f" || touch "$f"
case "$*" in
  '')   r; t | grep -v '\?$' | clr;; # todo
  '?')  r; t | grep '\?$' | clr;;    # maybe
  a|-a) r; t | clr;;                 # all
  e|-e) r; edit "$f";;               # edit
  d|-d) edit "$0";;                  # develop
  h|-*) h;;                          # help
  +)    tags;;                       # tags
  +*)   r; tag "$*";;                # tag
  *[!0-9\ \?\!]*) add "$*"; r;;      # add
  *)    move "$*";;                  # delete
esac
