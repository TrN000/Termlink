" python command group
nnoremap <leader>f :call Termlink_python_file()<cr>
nnoremap <leader>b :call Termlink_python_block()<cr>

" python globals
let g:python_version = "3"

" python functions
function! Termlink_python_file(buf=g:termlink_term)
    if g:python_version ==# "3"
        call term_sendkeys(a:buf, "exec(open(\"" . expand('%:p') . "\").read())" . "\<cr>")
    endif
endfunction

function! Termlink_python_block()
    " search for an empty line, followed by a non-indented line
    let start = search('^$\n^[^ ]', 'bnW', line("0")) + 1
    let end   = search('^$\n^[^ ]', 'nW' , line("$"))
    if end == 0
        let end = line("$")
    endif
    let lines = join(getline(start, end), "\n")
    call Termlink_send(lines)
endfunction
