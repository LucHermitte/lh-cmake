"=============================================================================
" $Id$
" File:         addons/cmake/plugin/lh-cmake.vim                  {{{1
" Author:       Luc Hermitte <EMAIL:hermitte {at} free {dot} fr>
"		<URL:https://github.com/LucHermitte/lh-cmake>
" Version:      001
" Created:      11th Apr 2014
" Last Update:  $Date$
"------------------------------------------------------------------------
" Description:
"       API functions of lh-cmake
" }}}1
"=============================================================================

" Avoid global reinclusion {{{1
let s:k_version = 1
if &cp || (exists("g:loaded_lh_cmake")
      \ && (g:loaded_lh_cmake >= s:k_version)
      \ && !exists('g:force_reload_lh_cmake'))
  finish
endif
let g:loaded_lh_cmake = s:k_version
let s:cpo_save=&cpo
set cpo&vim
" Avoid global reinclusion }}}1
"------------------------------------------------------------------------
" Commands and Mappings {{{1

command! -nargs=+ -complete=customlist,lh#cmake#_complete
      \ CMake call lh#cmake#_command(<f-args>)

" Commands and Mappings }}}1
"------------------------------------------------------------------------
let &cpo=s:cpo_save
"=============================================================================
" vim600: set fdm=marker:
