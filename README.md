# Distributed Docker System
Infrastructure for launching a distributed network of docker containers, each running a service.

## Requirements
Docker

# Launching Nodes
To launch `N` servers, run `./start.sh N`. This will run `make` inside the src directory to build your code, and report any build errors to you. The `src/start_server.sh` file is automatically run at startup for all nodes, you can use this to launch your code or automate any runtime tasks.

To attach to a running node, run `./attach N` for node index `N`. To exit a node, just use `control + d`.

## Node Names & Networking
Nodes have hostnames following the pattern `$NODE_NAME_PREFIX_node_{i}`, where the environment variable `$NODE_NAME_PREFIX` is defined in `config.sh`, and `i` is the node's index.

So, to ping the 3rd node, you can run `ping $NODE_NAME_PREFIX_node_3`, where `$NODE_NAME_PREFIX` is what you've defined it to be. (To get a bash shell in node 3, you can run `./attach.sh 3`).

To refer to a node hostname from within your project source, simply refer to it with the string `$NODE_NAME_PREFIX_node_i` (where `i` is the index). At build time (when you launch the nodes), the build system will automagically replace each instance of the string `$NODE_NAME_PREFIX` with the value in `config.sh` for you, just as if it was a regular environment variable like in a shell script.

No worrying about IP addresses, directory path names, or host name lookup- the infrastructure takes care of it for you.

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

Notice that nodes 6-10 are not responding, this is because we only launched 5 nodes. (To launch 10, run with `./start.sh 10`).

Here's what it looks like to attach to tmux:

```
root@d077b8f44d92:/home/proj/src# tmux a
make: 'rpc' is up to date.
Running as server...
Received message: Hello, World!
```
