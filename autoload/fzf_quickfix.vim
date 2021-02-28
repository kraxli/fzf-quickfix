scriptencoding utf-8

" Copyright (c) 2018-2019 Filip Szymański. All rights reserved.
" Use of this source code is governed by an MIT license that can be
" found in the LICENSE file.

let s:keep_cpo = &cpoptions
set cpoptions&vim
let s:TYPE = {'dict': type({}), 'funcref': type(function('call')), 'string': type(''), 'list': type([])}

function! s:error_type(type, nr) abort
  if a:type ==? 'W'
    let l:msg = ' warning'
  elseif a:type ==? 'I'
    let l:msg = ' info'
  elseif a:type ==? 'E' || (a:type ==# "\0" && a:nr > 0)
    let l:msg = ' error'
  elseif a:type ==# "\0" || a:type ==# "\1"
    let l:msg = ''
  else
    let l:msg = ' ' . a:type
  endif

  if a:nr <= 0
    return l:msg
  endif

  return printf('%s %3d', l:msg, a:nr)
endfunction

function! s:format_error(item) abort
  return (a:item.bufnr ? bufname(a:item.bufnr) : '')
        \ . '|' . (a:item.lnum  ? a:item.lnum : '')
        \ . (a:item.col ? ' col ' . a:item.col : '')
        \ . s:error_type(a:item.type, a:item.nr)
        \ . '|' . substitute(a:item.text, '\v^\s*', ' ', '')
endfunction

function! s:error_handler(err) abort
  let l:match = matchlist(a:err, '\v^([^|]*)\|(\d+)?%(\scol\s(\d+))?.*\|')[1:3]
  if empty(l:match) || empty(l:match[0])
    return
  endif

  if empty(l:match[1]) && (bufnr(l:match[0]) == bufnr('%'))
    return
  endif

  let l:lnum = empty(l:match[1]) ? 1 : str2nr(l:match[1])
  let l:col = empty(l:match[2]) ? 1 : str2nr(l:match[2])

  execute 'buffer' bufnr(l:match[0])
  call cursor(l:lnum, l:col)
  normal! zvzz
endfunction

function! s:syntax() abort
  if has('syntax') && exists('g:syntax_on')
    syntax match fzfQfFileName '^[^|]*' nextgroup=fzfQfSeparator
    syntax match fzfQfSeparator '|' nextgroup=fzfQfLineNr contained
    syntax match fzfQfLineNr '[^|]*' contained contains=fzfQfError
    syntax match fzfQfError 'error' contained

    highlight default link fzfQfFileName Directory
    highlight default link fzfQfLineNr LineNr
    highlight default link fzfQfError Error
  endif
endfunction

function! fzf_quickfix#run(query, loc_list, opts, bang) abort
  let is_loclist = get(a:, 'loc_list', '0')
  let opts = get(a:, 'opts', {})
  let bang = get(a:, 'bang', 0)

  let wrap_dic = {
        \ 'source': map(is_loclist ? getloclist(0) : getqflist(), 's:format_error(v:val)'),
        \ 'sink': function('s:error_handler'),
        \ 'options': [printf('--prompt="%s> "', (is_loclist ? 'LocList' : 'Qfix')), '--query', a:query]
      \ }

  if type(opts) == type({}) | let wrap_dic = s:extend_opts(wrap_dic, opts, 0) | endif
  call fzf#run(fzf#wrap(wrap_dic, a:bang))

  if g:fzf_quickfix_syntax_on
    call s:syntax()
  endif
endfunction

function! s:extend_opts(dict, eopts, prepend)
  if empty(a:eopts)
    return
  endif

  let dict = copy(a:dict)
  let opts = copy(a:eopts)

  if has_key(dict, 'options') && has_key(a:eopts, 'options')
    if type(dict.options) == s:TYPE.list && type(a:eopts.options) == s:TYPE.list
      if a:prepend
        let dict.options = extend(copy(a:eopts.options), dict.options)
      else
        call extend(dict.options, a:eopts.options)
      endif
    else
      let all_opts = a:prepend ? [a:eopts.options, dict.options] : [dict.options, a:eopts.options]
      let dict.options = join(map(all_opts, 'type(v:val) == s:TYPE.list ? join(map(copy(v:val), "fzf#shellescape(v:val)")) : v:val'))
    endif
  elseif has_key(a:eopts, 'options')
    let dict.options = a:eopts.options
  endif

  if has_key(a:eopts, 'options')
    call remove(opts, 'options')  " unlet opts.options
  endif

  return extend(dict, opts)
endfunction

let &cpoptions = s:keep_cpo
unlet s:keep_cpo


" vim: et sw=2 ts=2
