# This will be the name of the docker-compose project, and as a result
# will be prefixed in front of each node.
NODE_NAME_PREFIX="jprx_dist_sys"

# At build time, this variable will be copied into all instances of the string `$NODE_NAME_PREFIX`
# in all files in the src/ directory. This way, you can refer to symbolic hostnames right
# in your source code, and update the container names right here outside of the nodes.
