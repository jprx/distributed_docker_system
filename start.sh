# Start N nodes
if [ -z $1 ]; then
    #echo "Defaulting to 5 nodes"
    NUM_NODES=5
else
    NUM_NODES=$1
fi

echo "Starting" $NUM_NODES "nodes"

docker-compose down
docker-compose up -d --build --scale node=$NUM_NODES
