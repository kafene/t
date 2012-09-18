#!/bin/sh
# http://github.com/unu/t

f="$HOME/todo.txt"
def="[m"; green="[1;32m"; red="[1;31m"; orange="[33m"; gray="[36m"
usage(){
  cat << eof
t: minimalistic todo list for your command line
    t              # show todo list
    t buy milk     # add item
    t /milk        # search for "milk"
    t -milk        # remove item containing "milk"
    t parachute?   # add item to maybe list
    t ?            # show maybe list
    t a            # show both lists
    t e            # open in editor
    t h            # show this help
eof
}
todo(){ grep -v '\?$' "$f" | grep -v '^ *$'; }
maybe(){ grep '\?$' "$f"; }
reorder(){ echo "$(todo && maybe)" > "$f"; }
indent(){ sed 's/^/  /; s/\(+[a-z]*\)/'$gray'\1'$def'/g'; }
remove(){
  match="$(grep "$*" "$f")"
  test "$match" || exec echo "${orange}NOT FOUND$def"
  test "$(echo "$match" | wc -l)" = 1 || exec echo "$orange$match$def"
  echo "$(grep -v "$*" "$f")" >  "$f" && echo "$red$match$def"
}

test -f "$f" || touch "$f"
case "$*" in
  h|-h) usage;;
  '') todo | indent;;
  \?) maybe | indent;;
  a) (todo && maybe) | indent;;
  e) reorder; "${EDITOR:-vi}" "$f";;
  [/+]*) GREP_COLOR="1;35" grep --color=always "${*#/}" "$f" | indent;;
  -*) remove "${*#-}" | indent;;
  *) echo "$*" >> "$f" && echo "$green$*$def" | indent && reorder;;
esac
