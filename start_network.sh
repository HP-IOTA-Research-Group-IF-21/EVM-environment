#!/bin/bash

pushd() {
  command pushd "$@" > /dev/null
}

popd() {
  command popd > /dev/null
}

print_help_exit() {
	printf "usage: $(basename $0) [--besu] [--ipfs] [--all] [-h|--help] <mode>\n"
	printf '\t%s\t%s\n' "<mode>" "mode for the environment start | stop"
	printf '\t%s\t%s\n' "--besu" "compose component for besu environment"
	printf '\t%s\t%s\n' "--ipfs" "compose component for IPFS environment"
	printf '\t%s\t%s\n' "--all" "short alias for all compose at once"
    exit 0
}

ENVIRONMENT=("./besu_test_network" "./ipfs_cluster")
COMPOSE=(false false)

# Default values
_positionals=()
_arg_comp=('' )

parse_commandline() {
	_positionals_count=0
    # Parse flags
	while test $# -gt 0
	do
		_key="$1"
		case "$_key" in
			--besu)
                COMPOSE[0]=true
				;;
			--ipfs)
                COMPOSE[1]=true
				;;
            --all)
                for ((i=0; i<${#COMPOSE[@]}; i++))
                do
                    COMPOSE[i]=true
                done
                ;;
			-h|--help)
				print_help_exit
				;;
			-h*)
				print_help_exit
				;;
			*)
				_last_positional="$1"
				_positionals+=("$_last_positional")
				_positionals_count=$((_positionals_count + 1))
				;;
		esac
		shift
	done

    test $_positionals_count -eq 1 || print_help_exit
    # Parse positional args
    # Parse start/stop
    test ${_positionals[0]} = "start" || test ${_positionals[0]} = "stop" || print_help_exit
    [ "${_positionals[0]}" = "start" ]
    START=$?
}

parse_commandline "$@"

if [ $START -eq 0 ]
then
    _command="docker compose up -d"
else
    _command="docker compose down"
fi

for ((i=0; i<${#COMPOSE[@]}; i++))
do
    if [ ${COMPOSE[i]} = true ]
    then
        pushd ${ENVIRONMENT[i]}
        $_command
        popd
    fi
done
