<!-- vi:set syntax=markdown: -->

# t: minimalistic todo list for your command line

**t** is a simple todo list written in shell. It stores your tasks in a simple text file (`~/todo.txt` by default).

## Installation

    git clone git@github.com:unu/t
    cp t/t ~/bin/

## Usage

    t                # list all tasks
    t Shave the cat  # add an item
    t 2              # erase the second item
    t -e             # open todo.txt in $EDITOR.
    t -h             # show this help
    t -r             # reorder the items
    t -c             # count the amount of items

## Credits

**t** works pretty same as [wandernauta's **t**](https://github.com/wandernauta/t), which is a port of [tsion's **do\_stuff**](https://github.com/tsion/do_stuff). I just rewrote it to shell.

