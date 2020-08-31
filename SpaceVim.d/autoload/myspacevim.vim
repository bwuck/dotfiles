function! myspacevim#before() abort

  let g:neomake_open_list = 0

  " Use clang-format by default for C++ and C.
  let g:neoformat_c_clangformat = {
        \ 'exe': 'clang-format',
        \ 'args': ['-style=file'],
        \ }
  let g:neoformat_enabled_cpp = ['clangformat']
  let g:neoformat_enabled_c = ['clangformat']
  let g:neoformat_basic_format_align = 1
  let g:neoformat_basic_format_trim = 1

  " Autoformat buffers on save.
  augroup fmt
    autocmd!
    autocmd BufWritePre * undojoin | Neoformat
    " Remove trailing whitespace.
    " autocmd BufWritePre * %s/\s\+$//e
  augroup END

endfunction

function! myspacevim#after() abort
endfunction

