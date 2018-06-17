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

let s:fzf_quickfix_command = get(g:, 'fzf_command_prefix', '') . 'Quickfix'

execute 'command!' s:fzf_quickfix_command 'call fzf_quickfix#run()'

execute 'nnoremap <silent> <Plug>(fzf-quickfix) :' . s:fzf_quickfix_command . '<CR>'

let &cpoptions = s:keep_cpo
unlet s:keep_cpo

" vim: sw=2 ts=2 et fdm=marker
