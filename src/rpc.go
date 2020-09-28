package main

import (
	// For printing:
	"fmt"

	// For command line args:
	"flag"

	// Networking:
	"net"
	"net/rpc"
)

// In Go, RPCs need to be attached to objects
// Define a struct to use as shared state, all RPCs are member functions of this struct
type NetworkState struct { }

// Define the RPCs as member functions of the shared object type
func (netState *NetworkState) SaySomething (s string, retcode *int) error {
	fmt.Println("Received message:", s)
	*retcode = 1
	return nil
}

// Server method
func Server() {
	networkState := new(NetworkState)

	// Setup TCP listener:
	addr, _ := net.ResolveTCPAddr("tcp", ":1234")
	inbound, _ := net.ListenTCP("tcp", addr)

	rpc.Register(networkState)

	// Loop on accepting inputs
	rpc.Accept(inbound)
}

// Ping a specific server
func PingServer(name string) {
	fmt.Print("Ping ", name)

	client, err := rpc.Dial("tcp", name + ":1234")

	if err != nil {
		fmt.Print("\t\t\t", name, " not responding\n")
		return
	}

	var reply int = 0
	client.Call("NetworkState.SaySomething", "Hello, World!", &reply)
	fmt.Println("\t\t\tGot return code", reply)

}

// Client pings 10 servers and quits
// Change the node name if your parent directory name is different
// (IE if you are running docker-compose under DIRECTORY_NAME, replace distributed_docker_system with
// that DIRECTORY_NAME)
func Client() {
	for i := 1 ; i <= 10 ; i++ {
		PingServer(fmt.Sprintf("distributed_docker_system_node_%d", i))
	}
}

func main () {
	// Switch between server and client
	isServer := flag.Bool("server", false, "are we a server?")
	flag.Parse()

	if (*isServer) {
		fmt.Println("Running as server...");
		Server();
	} else {
		fmt.Println("Running as client...");
		Client();
	}
}
