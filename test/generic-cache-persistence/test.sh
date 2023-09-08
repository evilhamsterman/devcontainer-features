#!/bin/bash

source dev-container-features-test-lib

check "Check $HOME/.config is a link" test -L $HOME/.config
check "Check $HOME/.config links to $CACHE_HOME" bash -c "readlink $HOME/.config | grep -q $CACHE_HOME"

reportResults
