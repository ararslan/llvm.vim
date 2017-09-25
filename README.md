# llvm.vim

[![Build Status](https://travis-ci.org/ararslan/llvm.vim.svg?branch=master)](https://travis-ci.org/ararslan/llvm.vim)

The Vim definitions from the LLVM source tree, providing syntax recognition for LLVM
assembly (.ll) and TableGen (.tg) files.

The plugin files are extracted manually by running the `update.sh` script.
This runs on a Travis cron job once a week to ensure that everything remains current.

If there is an issue with the definitions themselves, please file an issue with LLVM.
If there is an issue with the update script, please file an issue here.

## Installation

#### [Vim Plug](https://github.com/junegunn/vim-plug)

Add `Plug 'ararslan/llvm.vim'` to your .vimrc, then run `:source %`, `:PlugInstall`.
If you don't have a preferred installation method, I recommend Vim Plug.

#### Vundle

Add `Plugin 'ararslan/llvm.vim'` to your .vimrc, then run `:source %`, `:PluginInstall`.
For versions of Vundle prior to 0.10.2, replace `Plugin` with `Bundle`.

#### Pathogen

Run `cd ~/.vim/bundle && git clone https://github.com/ararslan/llvm.vim.git` from the
command line outside of Vim.

## Disclaimer and License

This project is _not_ affiliated with LLVM, it is merely a repackaging of code
from the LLVM source tree, which is licensed under UIUC/NCSA, copyright the LLVM
developers.
A copy of the UIUC/NCSA license is included in the LICENSE file.
The only code here which is not part of LLVM is the update script and the Travis
configuration.
Those are licensed under the 2-Clause BSD License, which appears at the top of
the update script.
