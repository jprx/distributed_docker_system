#!/bin/bash
# Nodes names follow {parent directory name}_node_{index}
# basename "$PWD" gives us the parent directory name
# $1 is the first argument passed to this script
source ./config.sh
docker exec -it "$NODE_NAME_PREFIX"_node_$1 bash
