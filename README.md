# Distributed Docker System
Infrastructure for launching a distributed network of docker containers, each running a service.

## Requirements
Docker

# Launching Nodes
To launch `N` servers, run `./start.sh N`. This will run `make` inside the src directory, and report any build errors to you.

To attach to a running node, run `./attach N` for node index `N`. To exit a node, just use `control + d`.

## Networking
Nodes have hostnames following the pattern `{directory base name}_node_{i}`, where `directory_base_name` is the name of the folder you cloned this repo into (by default this is `distributed_docker_system`), and `i` is the node's index.

So, to ping the 3rd node, you can run `ping distributed_docker_system_node_3`. (To get a bash shell in node 3, you can run `./attach.sh 3`)

## Viewing Server Logs
When the nodes come to life, they will perform the actions in `src/start_server.sh`. This is run under a `tmux` window, so after attaching to a node, you can then attach to the virtual terminal using `tmux a`. This will allow you to see the outputs of your build command and the running service. You can exit `tmux` using `control + b` then `d`. 

If your nodes are launching and then failing this is likely due to a bug in your code, and you can diagnose by attaching to the `tmux` window within a node. The `cat` command at the bottom of `start_server.sh` keeps the server alive after attempting to run whatever else. 

To view running containers, you can use `docker-compose ps`.

## Demo
Here's what it looks like to pull the repo and start a network of 5 nodes.

`git clone https://github.com/jprx/distributed_docker_system.git`

`cd distributed_docker_system`

`./start.sh`

`./attach.sh 1`

```
root@d077b8f44d92:/home/proj/src# ./rpc
Running as client...
Ping distributed_docker_system_node_1           Got return code 1
Ping distributed_docker_system_node_2           Got return code 1
Ping distributed_docker_system_node_3           Got return code 1
Ping distributed_docker_system_node_4           Got return code 1
Ping distributed_docker_system_node_5           Got return code 1
Ping distributed_docker_system_node_6           distributed_docker_system_node_6 not responding
Ping distributed_docker_system_node_7           distributed_docker_system_node_7 not responding
Ping distributed_docker_system_node_8           distributed_docker_system_node_8 not responding
Ping distributed_docker_system_node_9           distributed_docker_system_node_9 not responding
Ping distributed_docker_system_node_10          distributed_docker_system_node_10 not responding
```

Here's what it looks like to attach to tmux:
`root@d077b8f44d92:/home/proj/src# tmux a`

```
make: 'rpc' is up to date.
Running as server...
Received message: Hello, World!
```

# Caveats
The top-level directory cannot be named starting with an underscore (however, underscores within the name are totally cool).
