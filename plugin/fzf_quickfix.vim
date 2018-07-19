scriptencoding utf-8

" Copyright (c) 2018 Filip Szymański. All rights reserved.
" Use of this source code is governed by an MIT license that can be
" found in the LICENSE file.

if exists('g:loaded_fzf_quickfix') || !exists('g:loaded_fzf')
  finish
endif
let g:loaded_fzf_quickfix = 1

let s:keep_cpo = &cpoptions
set cpoptions&vim

execute 'command!' get(g:, 'fzf_command_prefix', '') . 'Quickfix call fzf_quickfix#run()'

nnoremap <silent> <Plug>(fzf-quickfix) :call fzf_quickfix#run()<CR>

if !exists('g:fzf_quickfix_no_maps')
  if !hasmapto('<Plug>(fzf-quickfix)', 'n') && empty(maparg('<Leader>q', 'n'))
    nmap <Leader>q <Plug>(fzf-quickfix)
  endif
endif

let &cpoptions = s:keep_cpo
unlet s:keep_cpo

" vim: sw=2 ts=2 et fdm=marker
