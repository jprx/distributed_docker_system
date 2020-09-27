# Distributed Docker System
Infrastructure for launching a distributed network of docker containers, each running a service.

## Requirements
Docker

# Launching Nodes
To launch `N` servers, run `./start.sh N`.

To attach to a running node, run `./attach N` for node index `N`. To exit a node, just use `control + d`.

## Viewing Server Logs

When the nodes come to life, they will perform the actions in `src/start_server.sh`. This is run under a `tmux` window, so after attaching to a node, you can then attach to the virtual terminal using `tmux a`. This will allow you to see the outputs of your build command and the running service. You can exit `tmux` using `control + b` then `d`. 

In the future this system will be improved to build the server code once and then share the built binary across containers, instead of building the binary in each container at launch. If your nodes are launching and then failing this is likely due to a bug in your code, and you can diagnose by uncommenting the `cat` command at the bottom of `start_server.sh` (this will keep the server alive after attempting to run whatever else). You can then attach with `tmux a` to see the contents of the server.

To view running services, you can use `docker-compose ps`.

# Caveats
The top-level directory cannot be named starting with an underscore (however, underscores within the name are totally cool).
