#!/bin/bash
source ./config.sh
docker-compose -p $NODE_NAME_PREFIX --env-file ./config.sh down
