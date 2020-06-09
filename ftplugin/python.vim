" python command group
nnoremap <leader>f :call Termlink_send("exec(open(\"" . expand('%:p') . "\").read())")<cr>
nnoremap <leader>b :call Termlink_python_block()<cr>

" python globals
let g:python_version = "3"

" TODO: here an if block, determining the 'load file string'

" python functions
function! Termlink_python_block()
    " search for an empty line, followed by a non-indented line
    let start = search('^$\n^[^ ]', 'bnW', line("0")) + 1
    let end   = search('^$\n^[^ ]', 'nW' , line("$"))
    if end == 0
        let end = line("$")
    endif
    let lines = join(getline(start, end), "\n")
    call Termlink_send(lines, "\<cr>\<cr>")
endfunction
