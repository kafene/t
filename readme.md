<!-- vi:set syntax=markdown: -->

# t: minimalistic todo list for your command line

**t** is a simple todo list written in shell.
It stores your tasks in a plain text file (`~/todo.txt` by default).

## Installation

    git clone git@github.com:unu/t
    cp t/t ~/bin/

## Usage

    t                # show list
    t Wash the car   # add item
    t 2              # delete second item
    t e              # open in editor
    t r              # reorder items
    t c              # count items
    t -h, --help     # show this message

## Credits

**t** is inspired by [wandernauta's **t**](http://github.com/wandernauta/t),
which is a port of [tsion's **do\_stuff**](http://github.com/tsion/do_stuff).
