"=============================================================================
" File:         ftplugin/cmake_dictionary.vim                     {{{1
" Author:       Luc Hermitte <EMAIL:hermitte {at} gmail {dot} com>
"		<URL:http://github.com/LucHermitte/lh-cmake>
" Version:      0.0.2.
let s:k_version = '002'
" Created:      14th Jan 2016
" Last Update:  14th Jan 2016
"------------------------------------------------------------------------
" Description:
"       CMake Dictionary
"       List usual cmake keyword/words for vim dictionary completion with
"       i_CTRL-X_CTRL_K
"
"------------------------------------------------------------------------
" History:      «history»
" TODO:         «missing features»
" }}}1
"=============================================================================

" Buffer-local Definitions {{{1
" Avoid local reinclusion {{{2
if &cp || (exists("b:loaded_ftplug_cmake_dictionary")
      \ && (b:loaded_ftplug_cmake_dictionary >= s:k_version)
      \ && !exists('g:force_reload_ftplug_cmake_dictionary'))
  finish
endif
let b:loaded_ftplug_cmake_dictionary = s:k_version
let s:cpo_save=&cpo
set cpo&vim
" Avoid local reinclusion }}}2

"------------------------------------------------------------------------
" Options {{{2

let s:dictionary=expand("<sfile>:p:h").'/word.list'
if filereadable(s:dictionary)
  let &l:dictionary=s:dictionary
  setlocal complete+=k
endif
setlocal complete-=i

"=============================================================================
" Global Definitions {{{1
" Avoid global reinclusion {{{2
if &cp || (exists("g:loaded_ftplug_cmake_dictionary")
      \ && (g:loaded_ftplug_cmake_dictionary >= s:k_version)
      \ && !exists('g:force_reload_ftplug_cmake_dictionary'))
  let &cpo=s:cpo_save
  finish
endif
let g:loaded_ftplug_cmake_dictionary = s:k_version
" Avoid global reinclusion }}}2
"------------------------------------------------------------------------
" Functions {{{2
" Note: most filetype-global functions are best placed into
" autoload/«your-initials»/cmake/«cmake_dictionary».vim
" Keep here only the functions are are required when the ftplugin is
" loaded, like functions that help building a vim-menu for this
" ftplugin.
" Functions }}}2
"------------------------------------------------------------------------
let &cpo=s:cpo_save
"=============================================================================
" vim600: set fdm=marker:
