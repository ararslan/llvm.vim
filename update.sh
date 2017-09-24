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
if [ -z "$(command -v rsync)" ]; then
    echo "Unable to update sources: rsync not found"
    exit 1
fi

HERE="$(dirname ${0})"
VIMDIR="${HERE}/llvm/utils/vim"

if [ -d "${HERE}/llvm" ]; then
    rm -rf ${HERE}/llvm
fi

# Perform a shallow clone, since LLVM is enormous and we don't care about the
# full revision history
git clone --depth 1 https://git.llvm.org/git/llvm ${HERE}/llvm

if [ ! -d "${VIMDIR}" ]; then
    echo "Vim definitions not found in the LLVM source"
    echo "Please report this to https://github.com/ararslan/llvm.vim"
    exit 1
fi

# Copy the directories in LLVM's source tree into ours
ls -p ${VIMDIR} | grep / | xargs -I{} rsync -r ${VIMDIR}/{} ${HERE}/{}

# Clean up
rm -rf ${HERE}/llvm

# Make sure we're on a Travis cron job if we want to continue
# We DO NOT want to push to master from pull requests!
if [ -z "${TRAVIS}" -o \
    \( -n "${TRAVIS}" -a "${TRAVIS}" != "true" \) -o \
    \( -n "${TRAVIS_EVENT_TYPE}" -a "${TRAVIS_EVENT_TYPE}" != "cron" \) ]; then
    echo "Done"
    exit 0
fi

###########################################
# Travis-only from here on

# Just in case
cd ${HERE}

if git diff --quiet; then
    echo "No upstream updates, nothing to commit"
    exit 0
fi

git add --all
git commit \
    --author="Travis CI <travis@travis-ci.org>" \
    --message="Incorporate upstream changes ($(date +%Y-%m-%d))"

# The encrypted_* variables come from the Travis environment and are used to
# decrypt deploykey.enc
openssl aes-256-cbc \
    -K $encrypted_03aa28550ce6_key -iv $encrypted_03aa28550ce6_iv \
    -in deploykey.enc -out deploykey -d

chmod 600 deploykey

eval "$(ssh-agent -s)"
ssh-add deploykey

# Push with the git protocol rather than https or whatever
if [ -z "$(git remote | grep origin)" ]; then
    git remote add origin git@github.com:ararslan/llvm.vim.git
else
    git remote set-url origin git@github.com:ararslan/llvm.vim.git
fi

git push origin master

echo "Done"
