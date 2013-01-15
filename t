#!/bin/sh
# http://github.com/unu/t

f=$HOME/todo.txt; test -f $f || touch $f
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
  '') grep -ve '\?$' -e '^\s*$' $f | sed 's/^/ /';;
  \?) grep '\?$' $f | sed 's/^/ /';;
   a) sed 's/^/ /' $f;;
   e) ${EDITOR:-vi} $f;;
  [/+]*) grep -i "${*#/}" $f | sed 's/^/ /';;
  -*) match="$(grep -i "${*#-}" $f)"
      grep -qi "${*#-}" $f || exec echo "NOT FOUND: ${*#-}"
      test $(grep -ci "${*#-}" $f) -eq 1 || exec echo -e "$(echo "$match" | sed 's/^/? /')"
      echo "$(grep -iv "${*#-}" $f)" > $f && echo "-$match";;
   *) echo "$*" >> $f && echo "+ $*"
      echo "$(grep -ve '\?$' -e '^\s*$' $f; grep '\?$' $f)" > $f;;
esac
