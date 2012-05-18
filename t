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
c(){ wc -l "$f" | grep -o '^[0-9]'; }
a(){
  echo "Added #`n`: $1"
  echo "`n`. $1" >> "$f"
  echo "`t`" > "$f"
}
d(){
  s="`grep "^$1\." "$f"`"
  test "$s" && echo "Erased #$1: ${s#*. }" \
            || echo "There is no task #$1"
  echo "`grep -v "^$1\." "$f"`" > "$f"
}
test -f "$f" || touch "$t"
case "$1" in
  ''|e|r|c) ${1:-t};;
  -h|--help) h;;
  *[!0-9]*) a "$*";;
  *) d "$1";;
esac
