lh-cmake : A CMake plugin for vim
========

This plugin provides a few utilities for working on [CMake](http://www.cmake.org) projects from
[vim](http://www.vim.org).

## Features
### Obtain current project configuration as it's known by CMake

This plugin can analyze the current `CMakeCache.txt` (see
[`b:BTW_Compilation_dir`](#configuration)) and report miscellaneous
information:

* Where the `CMakeCache.txt` file is thanks to `lh#cmake#_where_is_cache()`
* The dictionary (`:h Dict`) of variables matching a REGEX pattern with
  `lh#cmake#get_variables(*pattern*)`

It also provides a `:CMake` command that takes different parameters:

* `:CMake where-is-cache` displays the location of the current `CMakeCache.txt` ;
* `:CMake open-cache` opens the current `CMakeCache.txt` ;
* `:CMake show pattern` displays the cached CMake variables that have a name
  that matches the REGEX pattern


## Installation

This plugin will best installed with
[Vim-Addon-Manager](https://github.com/MarcWeber/vim-addon-manager) as it will
also install
dependencies ( [lh-vim-lib](http://code.google.com/p/lh-vim/wiki/lhVimLib)).

By the mean time, you can clone this repositoriy and lh-vim-lib and install
them manually or with your prefered plugin manager.


## Configuration

This plugin needs the variable `b:BTW_Compilation_dir` to be set to the
directory where `ccmake` has been executed. Having this variable set and
up-to-date can be automated thanks to
[BuildToolsWrapper](http://code.google.com/p/lh-vim/wiki/BTW) and
[local_vimrc](http://code.google.com/p/lh-vim/source/browse/misc/trunk/plugin/local_vimrc.vim).
More on the subject latter.
