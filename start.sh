#!/bin/bash
source ./config.sh

# Start N nodes
if [ -z $1 ]; then
    #echo "Defaulting to 5 nodes"
    NUM_NODES=5
else
    NUM_NODES=$1
fi

echo "Starting" $NUM_NODES "nodes"

docker-compose -p $NODE_NAME_PREFIX --env-file ./config.sh down
docker-compose -p $NODE_NAME_PREFIX --env-file ./config.sh up -d --build --scale node=$NUM_NODES
