" send lines to :term instance
" Author: Nicolas Trutmann nicolas.trutmann (at) gmx.ch
" Version: 0.0

" TODO: 
"       :scriptversion to keep track of default argument situation with
"           Termlink_start 
"       make command
"       formal def of what I want of filetype functions
"           i.e. circumscribe the end state of functionality
"       uncomment function
"       NO: unexpected behaviour when calling <c-d>, turns termlink on and off
"       get bash working
"       NO: :h <SID>
"       NO: bug for python?? caused by being too fast for pythons interpreter...
"       DONE make proper plugin
"       DONE fix python block
"       DONE possibly need to work with operators, that allow motions :h operatorfunc

" ifdef guard
if exists("g:loaded_termlink")
   finish
endif
let g:loaded_termlink=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" globals

" keep track of terminal buffer number
let g:termlink_term = 0
let g:termlink_comm = ""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" keybinds
nnoremap <leader>s :call Termlink_start()<cr>
nnoremap <C-L> :call Termlink_send()<cr>j
vnoremap <C-L> :<C-U>call Termlink_send(Get_visual_selection())<cr>gv
nnoremap <leader>l :call Termlink_send("\<c-l>", "")<cr>
nnoremap <leader>d :call Termlink_send("\<c-d>", "")<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" internal functions

" send first argument to termlink instance; creates one if necessary.
" if none is provided line at cursor position is sent.
" second argument is used as end char, if ommited '\<cr>' is used.
function! Termlink_send(...)
    if a:0 == 0
        let line = getline(".")
    else
        let line = a:1
    endif

    if a:0 > 1
        let endchar = a:2
    else
        let endchar = "\<cr>"
    endif

    if bufnr(g:termlink_term) <= 0
        call Termlink_start()
    endif
    let term = g:termlink_term

    call term_sendkeys(term, line . endchar)
endfunction

" starts a :term instance and stores the bufnr in g:termlink.
" string provided to the 'comm' argument is sent to the term.
function! Termlink_start(comm=g:termlink_comm)
    if bufnr(g:termlink_term) > 0
        echom "Termlink already started"
        return
    endif
    rightb vert term 
    let g:termlink_term = term_list()[-1]
    wincmd p
    if a:comm !=? ""
        call Termlink_send(a:comm)
    endif
endfunction

" returns visual selection
" function credit to stack-overflow user 'xolox' licensed as public domain.
" https://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript?noredirect=1&lq=1
function! Get_visual_selection()
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[0] = lines[0][column_start - 1:]
    let lines[-1] = lines[-1][:column_end - (&selection == 'inclusive' ? 1 : 2)]
    return join(lines, "\n")
endfunction
