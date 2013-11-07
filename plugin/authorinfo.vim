" Vim File
" Filename:     vim-authorinfo.vim
" Created:   2013-11-07 22:30:21
" Modified:  2013-11-08 00:09:21
" Author:   butbueatiful (butbueatiful@gmail.com)
" VERSION:  1.0

function s:filetype ()

  let s:file = expand("<afile>:t")
  let l:ft = &ft
  if l:ft ==# 'sh'
      let s:comment = "#"
      let s:type = s:comment . "!/usr/bin/env bash"
  elseif l:ft ==# 'python'
      let s:comment = "#"
      let s:type = s:comment . "-*- coding:utf-8 -*-"
  elseif l:ft ==# 'perl'
      let s:comment = "#"
      let s:type = s:comment . "!/usr/bin/env perl"
  elseif l:ft ==# 'vim'
      let s:comment = "\""
      let s:type = s:comment . " Vim File"
  elseif l:ft ==# 'c' || l:ft ==# 'cpp'
      let s:comment_start = "\/**"
      let s:comment = " *"
      let s:comment_end = "\ *\/"
      let s:type = s:comment . " C/C++ File"
  elseif l:ft==# 'rst'
      let s:comment = ".."
      let s:type = s:comment . " reStructuredText "
  elseif l:ft==# 'php'
      let s:comment = "\/\/"
      let s:type = s:comment . " Php File "
  elseif l:ft ==# 'javascript'
      let s:comment = "\/\/"
      let s:type = s:comment . " Javascript File"
  else
    let s:comment = "#"
    let s:type = s:comment . " Text File"
  endif
  unlet s:file

endfunction


" FUNCTION:
" Insert the header when we create a new file.
" VARIABLES:
" author = User who create the file.
" created = Date of the file creation.
" modified = Date of the last modification.
let g:authorinfo_author  = exists('g:authorinfo_author')  ? g:authorinfo_author  : system ("whoami | tr -d '\n'")
let g:authorinfo_email   = exists('g:authorinfo_email')   ? g:authorinfo_email   : "Youremail"
let g:authorinfo_company = exists('g:authorinfo_company') ? g:authorinfo_company : "Yourcompany"

function s:insert ()

  call s:filetype ()

  let s:file     = s:comment .   "  Filename: " . expand("<afile>")
  let s:created  = s:comment .   "   Created: " . strftime ("%Y-%m-%d %H:%M:%S")
  let s:modified = s:comment .  "  Modified: " . strftime ("%Y-%m-%d %H:%M:%S")
  let s:desc     = s:comment .    "      Desc: TODO (some description)"
  let s:author   = s:comment .    "    Author: " . g:authorinfo_author.", " .g:authorinfo_email
  let s:company  = s:comment .  "   Company: " . g:authorinfo_company


  " if l:ft ==# 'c' || l:ft ==# 'cpp'
  if &filetype == "c" || &filetype == 'cpp'
      call append (0, s:comment_start)
      call append (1, s:file)
      call append (2, s:created)
      call append (3, s:modified)
      call append (4, s:desc)
      call append (5, s:author)
      call append (6, s:company)
      call append (7, s:comment_end)
      unlet s:comment_start
      unlet s:comment_end
  else
      call append (0, s:type)
      call append (1, s:file)
      call append (2, s:created)
      call append (3, s:modified)
      call append (4, s:desc)
      call append (5, s:author)
      call append (6, s:company)
  endif

  unlet s:comment
  unlet s:type
  unlet s:file
  unlet s:created
  unlet s:modified
  unlet s:desc
  unlet s:author
  unlet s:company

endfunction


" FUNCTION:
" Update the date of last modification.
" Check the line number 6 looking for the pattern.

function s:update ()

  call s:filetype ()

  let s:pattern = s:comment . "  Modified: [0-9]"
  let s:line = getline (4)

  if match (s:line, s:pattern) != -1
    let s:modified = s:comment . "  Modified: " . strftime ("%Y-%m-%d %H:%M:%S")
    call setline (4, s:modified)
    unlet s:modified
  endif

  unlet s:comment
  unlet s:pattern
  unlet s:line

endfunction

autocmd BufNewFile * call s:insert ()
autocmd BufWritePre * call s:update ()
