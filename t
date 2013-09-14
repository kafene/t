#!/bin/sh
# http://github.com/unu/t

f="${TODOFILE:-$HOME/todo.txt}"; test -f "$f" || touch "$f"
c=$(printf '\033[1;3'); d=$(printf '\033[m')
case "$*" in
  h|-h) echo 't: minimalist todo list for your command line
    t              # show todo list
    t buy milk     # add item
    t /milk        # search for "milk"
    t -milk        # remove item containing "milk"
    t parachute?   # add item to maybe list
    t ?            # show maybe list
    t a            # show all items
    t e            # open in editor';;
  '') grep -ve '\?$' -e '^\s*$' "$f" | sed 's/^/ /';;
  \?) grep '\?$' "$f" | sed 's/^/ /';;
   a) sed 's/^/ /' "$f";;
   e) ${EDITOR:-vi} "$f";;
  [/+]*) GREP_COLOR='1;34' grep --color=always -i "${*#/}" "$f" | sed 's/^/ /';;
  -*) match="$(grep -i "${*#-}" "$f")"
      grep -qi "${*#-}" "$f" || exec echo "NOT FOUND: ${*#-}"
      test $(grep -ci "${*#-}" "$f") -eq 1 || exec echo -e "${c}3m$(echo "$match" | sed 's/^/? /')$d"
      echo "$(grep -iv "${*#-}" "$f")" > "$f" && echo "${c}1m- $match$d";;
   *) echo "$*" >> "$f" && echo "${c}2m+ $*$d"
      echo "$(grep -ve '\?$' -e '^\s*$' "$f"; grep '\?$' "$f")" > "$f";;
esac
