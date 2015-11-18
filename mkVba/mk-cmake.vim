"=============================================================================
" File:         mkVba/mk-cmake.vim                                {{{1
" Author:       Luc Hermitte <EMAIL:hermitte {at} free {dot} fr>
"		<URL:http://code.google.com/p/lh-vim/>
" Version:      0.0.2
let s:version = '0.0.2'
" Created:      07th May 2014
" Last Update:  18th Nov 2015
"------------------------------------------------------------------------
" Description:
"       Plugin to be sourced in order to build a vimball archive for lh-cmake
" }}}1
"=============================================================================
let s:project = 'lh-cmake'
cd <sfile>:p:h
try
  let save_rtp = &rtp
  let &rtp = expand('<sfile>:p:h:h').','.&rtp
  exe '17,$MkVimball! '.s:project.'-'.s:version
  set modifiable
  set buftype=
finally
  let &rtp = save_rtp
endtry
finish
LICENSE
README.md
VimFlavor
addon-info.json
autoload/lh/cmake.vim
plugin/lh-cmake.vim
