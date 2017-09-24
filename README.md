# llvm.vim

[![Build Status](https://travis-ci.org/ararslan/llvm.vim.svg?branch=master)](https://travis-ci.org/ararslan/llvm.vim)

The Vim definitions from the LLVM source tree, providing syntax recognition for LLVM
assembly (.ll) and TableGen (.tg) files.

The plugin files are extracted manually by running the `update.sh` script.
This runs on a Travis cron job once a week to ensure that everything remains current.

If there is an issue with the definitions themselves, please file an issue with LLVM.
If there is an issue with the update script, please file an issue here.

**NOTE:** This project is _not_ affiliated with LLVM.
It is merely a repackaging of code from the LLVM source tree, which is licensed
under UIUC/NCSA, copywrite the LLVM developers.
The updating script is the only non-LLVM code here.
