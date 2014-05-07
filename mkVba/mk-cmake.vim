"=============================================================================
" $Id$
" File:         mkVba/mk-cmake.vim                                {{{1
" Author:       Luc Hermitte <EMAIL:hermitte {at} free {dot} fr>
"		<URL:http://code.google.com/p/lh-vim/>
" Version:      001
" Created:      07th May 2014
" Last Update:  $Date$
"------------------------------------------------------------------------
" Description:
"       Plugin to be sourced in order to build a vimball archive for lh-cmake
" }}}1
"=============================================================================

let s:version = '0.0.1'
let s:project = 'lh-cmake'
cd <sfile>:p:h
try 
  let save_rtp = &rtp
  let &rtp = expand('<sfile>:p:h:h').','.&rtp
  exe '28,$MkVimball! '.s:project.'-'.s:version
  set modifiable
  set buftype=
finally
  let &rtp = save_rtp
endtry
finish
README.md
autoload/lh/cmake.vim
lh-cmake-addon-info.txt
plugin/lh-cmake.vim
