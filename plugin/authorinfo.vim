" Vim File
" Filename: vim-authorinfo.vim
" Author:   hhktony (hhktony@gmail.com)

if exists('g:authorinfo_loaded')
endif
let g:authorinfo_loaded = 1

let g:authorinfo_author  = exists('g:authorinfo_author')  ? g:authorinfo_author  : system ("whoami | tr -d '\n'")
let g:authorinfo_email   = exists('g:authorinfo_email')   ? g:authorinfo_email   : 'Youremail'
let g:authorinfo_company = exists('g:authorinfo_company') ? g:authorinfo_company : 'Yourcompany'

function! s:filetype()
  let s:type_on = 1
  let s:file = expand('<afile>:t')
  let l:ft = &filetype
  if l:ft ==# 'sh'
      let s:comment = '#'
      let s:type = s:comment . '!/usr/bin/env bash'
  elseif l:ft ==# 'python'
      let s:comment = '#'
      let s:type = s:comment . ' -*- coding:utf-8 -*-'
  elseif l:ft ==# 'perl'
      let s:comment = '#'
      let s:type = s:comment . '!/usr/bin/env perl'
  elseif l:ft ==# 'vim'
      let s:comment = '"'
      let s:type = s:comment . ' Vim File'
  elseif l:ft =~# '\v^%(c|cpp|objc|objcpp)$'
      let s:comment_start = '/**'
      let s:comment = ' *'
      let s:comment_end = ' */'
      let s:type = s:comment . ' C/C++ File'
  elseif l:ft ==# 'rst'
      let s:comment = '..'
      let s:type = s:comment . ' reStructuredText '
  elseif l:ft ==# 'php'
      let s:comment = '//'
      let s:type = s:comment . ' Php File '
  elseif l:ft ==# 'javascript'
      let s:comment = '//'
      let s:type = s:comment . ' Javascript File'
  else
    let s:type_on = 0
  endif
  unlet s:file
endfunction

function! s:insert()
  call s:filetype()

  if s:type_on == 1
    let s:file     = s:comment .   '  Filename: ' . expand('<afile>')
    let s:created  = s:comment .   '   Created: ' . strftime ('%Y-%m-%d %H:%M:%S')
    let s:desc     = s:comment .    '      Desc: TODO (some description)'
    let s:author   = s:comment .    '    Author: ' . g:authorinfo_author.', ' .g:authorinfo_email
    let s:company  = s:comment .  '   Company: ' . g:authorinfo_company

    if &filetype =~# '\v^%(c|cpp|objc|objcpp)$'
      call append(0, s:comment_start)
      call append(1, s:file)
      " call append(2, s:created)
      call append(2, s:desc)
      call append(3, s:author)
      call append(4, s:company)
      call append(5, s:comment_end)
      unlet! s:comment_start s:comment_end
    else
      call append(0, s:type)
      call append(1, s:file)
      " call append(2, s:created)
      call append(2, s:desc)
      call append(3, s:author)
      call append(4, s:company)
    endif
    unlet! s:comment s:type s:file s:created s:desc s:author s:company
  endif
endfunction

augroup vim-authorinfo
  autocmd BufNewFile * call s:insert ()
augroup end
