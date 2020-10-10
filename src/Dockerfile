# This could be Ubuntu:18.04 for non-go projects
FROM golang:1.15

# A build argument, this is the name of a node
ARG node_name_prefix

# Install useful utilities:
RUN apt-get update && apt-get install -y iputils-ping netcat vim tmux

# This is where docker-compose will mount our files inside the container
WORKDIR /home/proj/src

# Copy sources into src and build
COPY . /home/proj/src
RUN cd /home/proj/src

# Find any instances of $NODE_NAME_PREFIX and replace with the correct value in all files in src
RUN sed -i 's/$NODE_NAME_PREFIX/'$node_name_prefix'/g' *

# Build the project
RUN make

# tmux new-session -d './rpc -server'
#  './rpc -server' : Run ./rpc -server in the new tmux window
#
# This allows you to see server log if you attach to the running container and then run `tmux a`
CMD ["tmux", "new-session", "./start_server.sh"]