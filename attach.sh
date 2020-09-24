#!/bin/bash
# Nodes names follow {parent directory name}_node_{index}
# basename "$PWD" gives us the parent directory name
# $1 is the first argument passed to this script
docker exec -it `basename "$PWD"`_node_$1 bash
