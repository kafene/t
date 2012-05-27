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
    t +shop +city     # list tags +shop and +city
    t 2 4             # delete items 2 and 4
    t e               # open in editor
    t h               # show this help

In bash you can use:

    t {5..9}          # delete items 5-9


## Credits

**t** is inspired by [wandernauta's **t**](http://github.com/wandernauta/t),
which is a port of [tsion's **do\_stuff**](http://github.com/tsion/do_stuff).
