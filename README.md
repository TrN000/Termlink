# Termlink - send lines to terms

This is a *very* small (read: quickly cobbled together) vim plugin, that 
provides a layer of functionality around the `send_termkeys` function.

At its core, the plugin takes some string and sends it to a `:term` instance.
Around that are file type specific functions, that allow grabbing certain 
clumps of text and feed them into the core send functions.

At the moment it is most capable when used for python scripts, as I have 
written it with that purpose in mind.

### small demonstration

Suppose you had a python script, `fib.py`

with contents:

```python
def fib(n):
    a, b = 0, 1
    while a < n:
        a, b = b, a+b
    return a
```

to start Termlink, use `<leader>s` (s for start)
this opens a `term` window, which will be associated with termlink.

to send any particular line to this window, move your cursor to the line and 
press `<c-l>` (control and L).

similarly, you can send visual selections to a terminal using `<c-l>` after
selecting in visual mode

You can also send the entire block (from unindented `def` until the end of the 
function) using `<c-b>`
('block' commands not fully fleshed out yet, only exist for python as of 2020-05-30)

Clear the screen using `<leader>l`, which sends a `<c-l>` command.

Close the terminal with `<leader>d`, it sends `<c-d>` command.
as of 2020-05-30 it also opens termlink (not yet sure if bug or feature)


### contributing

You are of course permitted to fork the repo and extend it on your own.
I only ask you to give credit.

### better alternatives

This is in many ways a general purpose tool, not specialized to any one 
language.

For certain languages better plugins exist. Here's a list(maybe??)

- R     Nvim-R
