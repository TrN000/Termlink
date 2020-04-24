" send lines to :term instance
" Author: Nicolas Trutmann nicolas.trutmann (at) gmx.ch
" Version: 0.0

" TODO: get bash working
"       DONE make proper plugin
"       DONE fix python block
"       possibly need to work with operators, that allow motions :h operatorfunc
"       :h operatorfunc
"       :h <SID>

" standart ifdef guard
if exists("g:loaded_termlink")
   finish
endif
let g:loaded_termlink=1


" if a termlink window has already been opened
let g:termlink_active = 0
" keep track of terminal buffer number
let g:termlink_term = 0

" keybinds
nnoremap <leader>l :call Termlink_start()<cr>
nnoremap <C-L> :call Termlink_send()<cr>j " send line
vnoremap <C-L> :<C-U>call Termlink_send(Get_visual_selection())<cr>gv

function! Termlink_send(...)
    if a:0 == 0
        let line = getline(".")
    else
        let line = a:1
    endif
    if g:termlink_term == 0
        let term = term_list()[-1]
    else
        let term = g:termlink_term
    endif
    call term_sendkeys(term, line . "\<cr>")
endfunction

function! Termlink_start(comm="")
    rightb vert term 
    let g:termlink_term = term_list()[-1]
    let g:termlink_active = 1
    if a:comm !=? ""
        call Termlink_send(a:comm)
    endif
endfunction

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
