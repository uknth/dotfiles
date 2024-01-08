# returns operating system name
function fn_operating_system {
	if [[ "$OSTYPE" == "linux-gnu"* ]]; then
		echo "linux"
	elif [[ "$OSTYPE" == "darwin"* ]]; then
		echo "darwin"
	else
		echo "others"
	fi
}

function fn_dev_go {
	workspace_home=$1

	if [ ! -d "$workspace_home/lib/Go" ]; then
		fn_create_directory_tree
	fi

	export GOPATH="$workspace_home/lib/Go"
}

function fn_print_dot_env {
	for v in $(env | grep "DOT"); do
		printf "\t - $v"
	done
}

function fn_neofetch {
	if command -v neofetch &>/dev/null; then
		neofetch
		printf "%s\n" "---"
	fi
}
