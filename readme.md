<!-- vi:set syntax=markdown: -->

# t: minimalistic todo list for your command line

**t** is a simple todo list written in shell.
It stores your tasks in a plain text file (`~/todo.txt` by default).

## Installation

    git clone git@github.com:unu/t
    cp t/t ~/bin/

## Usage

    t                 # show all items
    t Buy milk +shop  # add item with tag +shop
    t 2 4             # delete items 2 and 4

    t +shop +city     # list tags +shop and +city
    t +               # show used tags
    
    t Parachute ?     # add item to maybe list
    t ?               # show maybe list
    t 1?              # move item 1 to maybe list
    t 3!              # move item 3 to todo list

    t -e              # open list in editor
    t -d              # edit source code (develop)
    t -h              # show this help

## Tips

- You can use `[edh]` without `-`.
- For deleting items 3-7 use: `t $(seq 3 7)`.  
  In bash you can use: `t {3..7}`.

## Credits

**t** is inspired by [wandernauta's **t**](http://github.com/wandernauta/t),
which is a port of [tsion's **do\_stuff**](http://github.com/tsion/do_stuff).

