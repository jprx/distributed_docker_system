#!/bin/bash
# Launch the service
# (You could wait for some time here, or check if you're the introducer node with `hostname -I`)
./rpc -server

# Running cat will allow you the container to remain up if your previous commands are failing.
cat
