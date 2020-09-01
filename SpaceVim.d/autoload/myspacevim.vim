function! myspacevim#before() abort

  :command WQ wq
  :command Wq wq
  :command W w
  :command Q q


  let g:neomake_open_list = 0

  " Use clang-format by default for C++ and C.
  let g:neoformat_c_clangformat = {
        \ 'exe': 'clang-format',
        \ 'args': ['-style=file'],
        \ }
  let g:neoformat_enabled_cpp = ['clangformat']
  let g:neoformat_enabled_c = ['clangformat']
  " let g:neoformat_basic_format_align = 1
  let g:neoformat_basic_format_trim = 1

  " Autoformat buffers on save.
  " See: https://github.com/sbdchd/neoformat/issues/134
  augroup fmt
    autocmd!
    au BufWritePre * try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry
  augroup END
  " augroup fmt
  " autocmd!
  " autocmd BufWritePre * undojoin | Neoformat
  " Remove trailing whitespace.
  " autocmd BufWritePre * %s/\s\+$//e
  " augroup END

  autocmd BufRead,BufNewFile *.bzl,*.bazel,*.BUILD,BUILD,WORKSPACE setf bzl

endfunction

function! myspacevim#after() abort
  " au BufNewFile,BufRead *.BUILD set syntax=bzl
endfunction

