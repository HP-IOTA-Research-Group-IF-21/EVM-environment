#!/bin/bash

WARN="⚠️ "
SUCCESS="✔️ "
EXIT=0

pushd() {
	command pushd "$@" >/dev/null
}

popd() {
	command popd >/dev/null
}

print_help() {
	printf '%s\n' "usage: $(basename $0) [-c] [-h]"
	printf '\t%s\t%s\n' "-c" "install IPFS client to interact with the nodes"
	printf '\t%s\t%s\n' "-h" "help"
}

INSTALL_CLIENT=false

while getopts 'ch' OPTION; do
	case "$OPTION" in
	c)
		INSTALL_CLIENT=true
		;;
	h | ?)
		print_help
		exit 0
		;;
	esac
done

# Install Docker
if ! command -v docker &>/tmp/cmdpath; then
	echo "${WARN} Please install Docker; see https://docs.docker.com/engine/install/ for installation"
	EXIT=1
else
	echo -e "${SUCCESS} Docker found:\t$(cat /tmp/cmdpath)"
fi

# Install npx
if ! command -v npx &>/tmp/cmdpath; then
	echo "${WARN} Please install nodejs, npm, & npx; suggested install commands:"
	echo "sudo apt-update && sudo apt-install -y nodejs npm"
	EXIT=1
else
	echo -e "${SUCCESS} npx found:\t\t$(cat /tmp/cmdpath)"
fi

IPFS_DIR="./ipfs_cluster"
if [[ ! -d $IPFS_DIR ]]; then
	mkdir $IPFS_DIR
	curl -L https://raw.githubusercontent.com/ipfs-cluster/ipfs-cluster/latest/docker-compose.yml >"${IPFS_DIR}/docker-compose.yml"
	echo -e "${SUCCESS} IPFS setup download complete"
else
	echo -e "${SUCCESS} IPFS setup found"
fi

if [ $INSTALL_CLIENT = true ]; then
	# Install client binaries
	BIN_DIR="./bin"

	# IPFS CTL
	IPFS_CTL_DIR="./bin/ipfs_cluster_ctl"
	if [[ ! -d $IPFS_CTL_DIR ]]; then
		mkdir -p $IPFS_CTL_DIR
		curl -L https://dist.ipfs.tech/ipfs-cluster-ctl/v1.1.2/ipfs-cluster-ctl_v1.1.2_linux-amd64.tar.gz |
			tar -zx -C $IPFS_CTL_DIR --strip-components=1
		echo -e "${SUCCESS} IPFS cluster ctl download complete"
	else
		echo -e "${SUCCESS} IPFS cluster ctl found: ${IPFS_CTL_DIR}"
	fi
	echo "To complete setup, run \"source .bashrc\" to export path to terminal"
fi

rm /tmp/cmdpath &>/dev/null

exit $EXIT
