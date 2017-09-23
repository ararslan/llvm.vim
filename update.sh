#!/bin/sh
# Update the plugin definitions from upstream LLVM, since they maintain their
# own Vim definitions but as part of the monolithic LLVM source tree
#
# Copyright (c) 2017, Alex Arslan
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.
#
# * Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

set -e

# Ensure script dependencies are available
if [ -z "$(command -v git)" ]; then
    echo "Unable to fetch LLVM source: git not found"
    exit 1
fi

HERE="$(dirname ${0})"

# Perform a shallow clone, since LLVM is enormous and we don't care about the
# full revision history
git clone --depth 1 http://llvm.org/git/llvm ${HERE}/llvm

if [ ! -d "./llvm/utils/vim" ]; then
    echo "Vim definitions not found in the LLVM source"
    echo "Please report this to https://github.com/ararslan/llvm.vim"
    exit 1
fi

# Move the directories out of LLVM's source tree and into ours
ls -p ${HERE}/llvm/utils/vim/ | grep / | xargs -I{} mv ${HERE}/llvm/utils/vim/{} ${HERE}/

# Clean up
rm -rf ${HERE}/llvm

echo "Done"
