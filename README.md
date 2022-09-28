# llvm.vim

[![Build Status](https://github.com/ararslan/llvm.vim/workflows/Update/badge.svg)](https://github.com/ararslan/llvm.vim/actions?query=workflow%3AUpdate+branch%3Async)

The Vim definitions from the LLVM source tree, providing syntax recognition for LLVM
assembly (.ll) and TableGen (.tg) files.

The plugin files are extracted manually by running the GitHub Action specified in
`update.yml`.
This runs as a cron job once a week to ensure that everything remains current.

If there is an issue with the definitions themselves, please file an issue with LLVM.
If there is an issue with the syncing between upstream LLVM and this repository, please
file an issue here.

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
from the LLVM source tree.
A copy of LLVM's license, which applies only to the contents of the `main` branch, is
included in the LICENSE file on this branch.
The file is not on the `main` branch directly as that would interfere with how the
contents are synced from upstream.
The only code here which is not part of LLVM is the GitHub Action, which is placed
into the public domain.
