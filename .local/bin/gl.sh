#!/usr/bin/bash

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

if ! fzf --version &> /dev/null; then
  printf "%s\n" "fzf not found"
  exit 1
fi

if ! bat --version &> /dev/null; then
  printf "%s\n" "bat not found"
  exit 1
fi

if ! git status > /dev/null; then
  exit 1
fi

if [ ! "$1" ]; then
  output=$(git log --oneline --decorate=short | fzf \
    --preview="git show --color --abbrev-commit --pretty=medium --date=format:%c {1}" \
    --preview-window=right:70%:noborder \
    --header="git log" | awk '{print $1}')
  git show "$output"
  else
    git log --oneline --parents --decorate=short --diff-filter=a -- "$1" | fzf \
    --with-nth=3.. \
    --preview="git show --color --abbrev-commit -s --pretty=medium --date=format:%c {1} \
    && echo -e \n \
    && git diff -p --color {2} {1} -- $1" \
    --preview-window=right:70%:noborder \
    --header="git log $1"
fi
