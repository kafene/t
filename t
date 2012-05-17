#!/bin/sh
# t: minimalistic todo list for your command line
# http://github.com/unu/t

# config
t="$HOME/todo.txt"

# functions
help(){
  cat << eof
usage: t                # list unfinished tasks
       t Shave the cat  # add an item
       t 3              # erase the third item
       t -e             # open todo.txt in \$EDITOR.
       t -h             # show this message
       t -r             # reorder the items
       t -c             # count the amount of items
eof
}
num(){
  i=1
  while grep -q "^$i\\." "$t"; do i=`expr $i + 1`; done
  echo $i
}
add(){
  echo "Added #`num`: $1"
  echo "`num`. $1" >> "$t"
  echo "`dump`" > "$t"
}
erase(){
  s="`grep "^$1\." "$t"`"
  test "$s" && echo "Erased #$1: ${s#*. }" \
            || echo "There is no task #$1"
  echo "`grep -v "^$1\." "$t"`" > "$t"
}
reorder(){
  echo "`dump | grep -o '[^0-9\. ].*' | nl -w 1 -s ". "`" > "$t"
}
dump(){ sort -n "$t" | grep -v '^ *$'; }
edit(){ exec "$EDITOR" "$t"; }
count(){ wc -l "$t" | grep -o '^[0-9]'; }

# main
touch "$t"
case "$1" in
  -h) help;;
  -r) reorder;;
  -c) count;;
  -e) edit;;
  '') dump;;
  *[!0-9]*) add "$*";;
   *) erase "$1";;
esac

