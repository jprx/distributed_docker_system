#!/bin/bash
make
./rpc -server

# If debugging a make issue, uncomment this:
# Running cat will allow you the container to remain up, and you can use tmux to reattach
# and see where the make failed
#cat