#!/bin/sh
# t: minimalistic todo list for your command line
# http://github.com/unu/t

f="$HOME/todo.txt"
h(){
  echo "t: minimalistic todo list for your command line
usage: t                # show list
       t Wash the car   # add item
       t 2              # delete second item
       t e              # open in editor
       t r              # reorder items
       t c              # count items
       t -h, --help     # show this message"
}
t(){ sort -n "$f" | grep -v '^ *$'; }
n(){ i=1; while grep -q "^$i\\." "$f"; do i=`expr $i + 1`; done; echo $i; }
r(){ echo "`t | grep -o '[^0-9\. ].*' | nl -w 1 -s ". "`" > "$f"; }
e(){ exec "${EDITOR:-vi}" "$f"; }
c(){ t | wc -l | grep -o '^[0-9]*'; }
a(){
  echo "Added #`n`: $1"
  echo "`n`. $1" >> "$f"
  echo "`t`" > "$f"
}
d(){
  for i in $1; do
    s="`grep "^$i\." "$f"`"
    test "$s" && echo "Deleted #$i: ${s#*. }" \
              || echo "There is no task #$i"
    echo "`grep -v "^$i\." "$f"`" > "$f"
  done
}
test -f "$f" || touch "$f"
case "$*" in
  ''|e|r|c) ${*:-t};;
  -h|--help) h;;
  *[!0-9\ ]*) a "$*";;
  *) d "$*";;
esac
