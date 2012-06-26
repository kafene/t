<!-- vi:set syntax=markdown: -->

# t: minimalistic todo list for your command line

**t** is a simple todo list written in shell.
It stores your tasks in a plain text file (`~/todo.txt` by default).

## Installation

    git clone git@github.com:unu/t
    cp t/t ~/bin/

## Usage

In **t** you can tag your tasks and then list one or more +tags. There is two lists – *todo* and *maybe*. Items ending by "?" are in the *maybe* list.

    t                 # show todo list
    t Buy milk +shop  # add item with tag
    t 2 4             # delete items 2 and 4

    t +shop +city     # list tags +shop and +city
    t +               # show used tags
    
    t Parachute ?     # add item to maybe list
    t ?               # show maybe list
    t 1?              # move item 1 to maybe list
    t 3!              # move item 3 to todo list

    t -a              # show all (todo + maybe)
    t -e              # open list in editor
    t -d              # edit source code (develop)
    t -h              # show this help

## Tips

- You can use `[edh]` without `-`.
- For deleting items 3-7 in bash, use:

        t {3..7}

- If you open list in editor often, add this to to your startup script:
        
        alias te="t -e"`

- If you want something more simple, try [wandernauta's **t**][wt] or [tsion's **do\_stuff**][do_stuff].

[wt]: http://github.com/wandernauta/t
[do_stuff]: http://github.com/tsion/do_stuff
