scriptencoding utf-8

" Copyright (c) 2018-2019 Filip Szymański. All rights reserved.
" Use of this source code is governed by an MIT license that can be
" found in the LICENSE file.

if exists('g:loaded_fzf_quickfix')
  finish
endif
let g:loaded_fzf_quickfix = 1

let s:keep_cpo = &cpoptions
set cpoptions&vim

let g:fzf_quickfix_no_maps = get(g:, 'fzf_quickfix_no_maps', 0)
let g:fzf_quickfix_syntax_on = get(g:, 'fzf_quickfix_syntax_on', 1)
let g:fzf_quickfix_use_loclist = get(g:, 'fzf_quickfix_use_loclist', 0)

execute 'command!' get(g:, 'fzf_command_prefix', '') . 'Quickfix call fzf_quickfix#run()'

nnoremap <silent> <Plug>(fzf-quickfix) :call fzf_quickfix#run()<CR>

if !g:fzf_quickfix_no_maps
  if !hasmapto('<Plug>(fzf-quickfix)', 'n') && empty(maparg('<Leader>q', 'n'))
    nmap <Leader>q <Plug>(fzf-quickfix)
  endif
endif

let &cpoptions = s:keep_cpo
unlet s:keep_cpo

" vim: et sw=2 ts=2 fdm=marker
