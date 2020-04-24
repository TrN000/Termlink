# Termlink - send lines to terms

This is a *very* small (read: quickly cobbled together) vim plugin, that 
provides a layer of functionality around the `send_termkeys` function.

At its core, the plugin takes some string and sends it to a `:term` instance.
Around that are file type specific functions, that allow grabbing certain 
clumps of text and feed them into the core send functions.

At the moment it is most capable when used for python scripts, as I have 
written it for that purpose. 

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

to start Termlink, use `<leader>l`
this opens a `term` window, which will be associated with termlink 
(as of 20-04-2020 still somewhat buggy). 

to send any particular line to this window, move your cursor to the line and 
press `<c-l>` (control and L).

similarly, you can send visual selections to a terminal using `<c-l>`

You can also send the entire block (from unindented `def` until the end of the 
function) using `<c-b>`

### contributing

If you write your own file type extensions, feel free to send a pull request!

### better alternatives

This is in many ways a general purpose tool, not specialized to any one 
language.

For certain languages better plugins exist. Here's a list(maybe??)

- R     Nvim-R
