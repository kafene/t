# t: minimalist todo list for your command line

__t__ is a simple todo list written in posix shell.
It stores your tasks in a plain text file ~/todo.txt.


## Installation

    wget https://raw.github.com/unu/t/master/t -O ~/bin/t
    chmod +x ~/bin/t


## Usage

There are two lists: todo and maybe.
Items ending by ? are in the maybe list.

    t              # show todo list
    t buy milk     # add item
    t /milk        # search for "milk"
    t -milk        # remove item containing "milk"
    t parachute?   # add item to maybe list
    t ?            # show maybe list
    t a            # show both lists
    t e            # open in editor
    t h            # show this help

