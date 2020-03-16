#!/bin/sh

# This script prepares an interactive rebase that will set the date of each
# commit after the argument reference to a current timestamp.
#
# It's useful because in GitHub pull requests, the commit navigation is ordered
# by commit date, rather than commit order.

set -e

git rebase -i "$1"^ --exec \
  'git commit --amend --no-edit --date="$(date +%Y-%m-%dT%H:%M:%S)"'