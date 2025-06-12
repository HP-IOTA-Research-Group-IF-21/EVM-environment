## Setup
1. Run [`quick_setup.sh`](./quick_setup.sh) to check the required components. Add the `-c` to automatically install the node client to interact with the network. (Run `quick_setup.sh -h` for more information)
2. Configure each environment in their directory
3. Run [`start_network.sh [options] start`](./start_network.sh) to start the development environment. Try `./start_network.sh --help` for complete help
4. If you choose to install the environment binary clients (IPFS cluster ctl & WASP cli), run [`source .bashrc`](./.bashrc) to add the local binaries to your PATH

## Monitor
### IOTA Sandbox
- [localhost/dahsboard](localhost/dahsboard)
- [localhost/wasp/dahsboard](localhost/wasp/dahsboard)

### IPFS
- [localhost:5001/webui](localhost:5001/webui)

## References
### IOTA Sandbox
* https://wiki.iota.org/iota-sandbox/welcome/
* https://wiki.iota.org/iota-sandbox/getting-started/
* https://wiki.iota.org/iota-sandbox/references/keys/

### IOTA WASP CLI
* https://wiki.iota.org/wasp/how-tos/wasp-cli/

### IPFS Cluster
* https://docs.ipfs.tech/install/server-infrastructure/#create-a-local-cluster

### Docker environment variables
* https://docs.docker.com/compose/how-tos/environment-variables/variable-interpolation/