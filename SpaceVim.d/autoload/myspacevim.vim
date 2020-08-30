function! myspacevim#before() abort

" Use clang-format by default for C++ and C.
let g:neoformat_cpp_clangformat = {
    \ 'exe': 'clang-format',
    \ 'args': []
    \}
let g:neoformat_enabled_cpp = ['clangformat']
let g:neoformat_enabled_c = ['clangformat']

" Autoformat buffers on save.
augroup fmt
autocmd!
autocmd BufWritePre * undojoin | Neoformat
" Remove trailing whitespace.
autocmd BufWritePre * %s/\s\+$//e
augroup END

endfunction

function! myspacevim#after() abort
endfunction

