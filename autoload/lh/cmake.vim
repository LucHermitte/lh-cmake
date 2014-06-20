"=============================================================================
" $Id$
" File:         addons/cmake/autoload/lh/cmake.vim                {{{1
" Author:       Luc Hermitte <EMAIL:hermitte {at} free {dot} fr>
"		<URL:https://github.com/LucHermitte/lh-cmake>
" Version:      001
" Created:      11th Apr 2014
" Last Update:  $Date$
"------------------------------------------------------------------------
" Description:
"       CMake plugin for Vim
" }}}1
"=============================================================================

let s:cpo_save=&cpo
set cpo&vim
"------------------------------------------------------------------------
" ## Misc Functions     {{{1
" # Version {{{2
let s:k_version = 1
function! lh#cmake#version()
  return s:k_version
endfunction

" # Debug   {{{2
let s:verbose = 0
function! lh#cmake#verbose(...)
  if a:0 > 0 | let s:verbose = a:1 | endif
  return s:verbose
endfunction

function! s:Verbose(expr)
  if s:verbose
    echomsg a:expr
  endif
endfunction

function! lh#cmake#debug(expr)
  return eval(a:expr)
endfunction


"------------------------------------------------------------------------
" ## Exported functions {{{1

"------------------------------------------------------------------------
" ## loaded on-the-fly functions {{{1
" Subcommands list {{{2
let s:subcommands = {
      \ 'show': function('lh#cmake#_show'),
      \ 'open-cache': function('lh#cmake#_open_cache'),
      \ 'where-is-cache': function('lh#cmake#_where_is_cache'),
      \}

" Function: lh#cmake#_complete(ArgLead, CmdLine, CursorPos) {{{2
let s:command = 'CM\%[ake]'
function! lh#cmake#_complete(ArgLead, CmdLine, CursorPos) abort
  let cmd = matchstr(a:CmdLine, s:command)
  let cmdpat = '^'.cmd

  let tmp = substitute(a:CmdLine, '\s*\S\+', 'Z', 'g')
  let pos = strlen(tmp)
  let lCmdLine = strlen(a:CmdLine)
  let fromLast = strlen(a:ArgLead) + a:CursorPos - lCmdLine 
  " The argument to expand, but cut where the cursor is
  let ArgLead = strpart(a:ArgLead, 0, fromLast )
  if 0
    call confirm( "a:AL = ". a:ArgLead."\nAl  = ".ArgLead
	  \ . "\nx=" . fromLast
	  \ . "\ncut = ".strpart(a:CmdLine, a:CursorPos)
	  \ . "\nCL = ". a:CmdLine."\nCP = ".a:CursorPos
	  \ . "\ntmp = ".tmp."\npos = ".pos
	  \ . "\ncmd = ".cmd
	  \, '&Ok', 1)
  endif

  if cmd != 'CMake'
    throw "Completion option called with wrong command"
  endif

  if     2 == pos
    return keys(s:subcommands)
  elseif 3 == pos
    if !exists('b:BTW_compilation_dir')
      throw "No path to CMakeCache.txt configured from this buffer"
    endif

    let subcommand = matchstr(a:CmdLine, '^'.s:command.'\s\+\zs\S\+\ze')
    " call confirm("subcommand: ".subcommand, '&Ok', 1)
    if subcommand == 'show'
      let cachefile = b:BTW_compilation_dir.'/CMakeCache.txt'
      let kv = s:UpdateCache(cachefile)
      let k = keys(kv)
      let ArgLead = substitute(ArgLead, '\*', '.*', 'g') " emulate wildcars
      call filter(k, 'v:val =~ ArgLead')
      return k
    endif
  endif
  return []
endfunction

" Function: lh#cmake#_command(...) {{{2
function! lh#cmake#_command(...) abort
  if a:0 == 0
    call lh#common#error_msg(':CMake: missing argument, try '.string(keys(s:subcommands)))
    return
  endif
  if !exists('b:BTW_compilation_dir')
    throw "No path to CMakeCache.txt configured from this buffer"
  endif
  let cachefile = b:BTW_compilation_dir.'/CMakeCache.txt'

  let subcommand = a:1
  if !has_key(s:subcommands, subcommand)
    call lh#common#error_msg(':CMake: invalid subcommand `'.subcommand.'`, try '.string(keys(s:subcommands)))
  else
    call call (s:subcommands[subcommand], a:000[1:])
  endif
endfunction

"------------------------------------------------------------------------
" ## Internal functions {{{1

" Function: lh#cmake#cachefile() {{{3
function! lh#cmake#cachefile()
  let cachefile = b:BTW_compilation_dir.'/CMakeCache.txt'
  return cachefile
endfunction

" Function: lh#cmake#_open_cache() {{{3
function! lh#cmake#_open_cache(...)
  call lh#buffer#jump(lh#cmake#cachefile(), 'sp')
endfunction

" Function: lh#cmake#_where_is_cache() {{{3
function! lh#cmake#_where_is_cache(...)
  echomsg lh#cmake#cachefile()
endfunction

" Function: lh#cmake#get_variables(pattern) {{{3
function! lh#cmake#get_variables(pattern) abort
  let kv = copy(s:UpdateCache(lh#cmake#cachefile()))
  let pattern = substitute(a:pattern, '\*', '.*', 'g') " emulates wildcars
  let kv = filter(kv, 'v:key =~ pattern')
  return kv
endfunction

" Function: lh#cmake#_show() {{{3
function! lh#cmake#_show(...)
  let kv = lh#cmake#get_variables(a:1)

  let lengths = map(keys(kv), 'strlen(v:val)')
  let max_key_len = max(lengths)
  let msg = []
  for [k,v] in items(kv)
    let msg += [k.repeat(' ', max_key_len-strlen(k)) . ' = '. (v.value)]
  endfor
  call lh#common#echomsg_multilines(msg)
endfunction

" # Cache Management {{{2
let s:__cache = {}

" function: s:UpdateCache(filename) {{{3
function! s:UpdateCache(filename) abort
  if ! file_readable(a:filename)
    throw "ccmake not run yet for this project -- ".a:filename. " does not exist."
  endif
  if !has_key(s:__cache, a:filename)
    let s:__cache[a:filename] = {"date": 0}
  endif
  let info = s:__cache[a:filename]
  let date = getftime(a:filename)
  if info.date < date 
    let info.kv = {}
    let content = readfile(a:filename)
    call filter(content, 'v:val =~ "^\\k\\+:\\k\\+\\s*="')
    for kv in content
      let [all, key, type, value; rest] = matchlist(kv, '\(\k\+\):\(\k\+\)=\(.*\)')
      let info.kv[key] = {'type': type, 'value':value}
    endfor
    let info.date = date
  endif

  return info.kv
endfunction
"------------------------------------------------------------------------
let &cpo=s:cpo_save
"=============================================================================
" vim600: set fdm=marker:
