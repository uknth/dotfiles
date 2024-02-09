function fn_create_directory_tree {
	workspace_home="$1"
	declare -a paths=(
		"$workspace_home/fork"
		"$workspace_home/orig"
		"$workspace_home/scratch"
		"$workspace_home/lib"
		"$workspace_home/lib/Go/bin"
		"$workspace_home/lib/Go/src"
		"$workspace_home/lib/Go/pkg"
	)

	for i in "${paths[@]}"; do
		fn_create_directory "$i"
	done
}

function fn_create_directory {
	if [ ! -d "$1" ]; then
		echo "Creating Directory: $1"
		mkdir -p $1
	fi
}

function fn_create_symbolic_link {
	flag="*"

	if [ -L $1 ]; then
		if [ -e $1 ]; then
			flag="true"
		else
			flag="false"
		fi
	elif [ -e $1 ]; then
		flag="false"
	else
		flag="false"
	fi

	if [ "$flag" = "false" ]; then
		# create sym link
		echo "ftu -> creating symlink for: $2 to $1"
		rm -rf "$1"
		ln -s "$2" "$1"
	fi
}

function fn_ftu {
	lock=$1

	# lock file exists, not ftu
	if [ -f "$lock" ]; then
		echo "false"
		echo "repeat: $USER $(date +%s) $(tty)" >>$lock
	else
		echo "ftu: $USER $(date +%s) $(tty)" >$lock
		echo "true"
	fi
}

function fn_ftu_aws {
	home=$1
	data=$2
	aws_home="$HOME/.aws"

	echo "ftu -> aws :: args:{ $home $data } vars:{ $aws_home }"

	if [ -L $aws_home ] || [ ! -d $aws_home ]; then
		# aws_home exists & is symbolic link or not a directory
		# delete it, it is old way of storing
		rm -rf $aws_home
	fi

	mkdir -p $aws_home

	fn_create_symbolic_link "$aws_home/config" "$home/config/aws/config"
	fn_create_symbolic_link "$aws_home/credentials" "$data/aws/credentials"
	fn_create_symbolic_link "$aws_home/sso" "$data/aws/sso"

	echo "---"
}

function fn_ftu_ssh {
	home=$1
	data=$2
	ssh_home="$HOME/.ssh"

	echo "ftu -> ssh :: args:{ $home $data } vars:{ $ssh_home }"

	if [ -L $ssh_home ] || [ ! -d $ssh_home ]; then
		rm -rf $ssh_home
	fi

	mkdir -p $ssh_home

	for f in $(find "$data/ssh" | sed 1,1d); do
		fn_create_symbolic_link "$ssh_home/$(basename $f)" "$f"
		# fix permission
		chmod -f 700 "$ssh_home/$(basename $f)"
	done

	echo "---"
}

function fn_ftu_nvim {
	home=$1
	data=$2

	nvim_home="$HOME/.config/nvim"

	echo "ftu -> ssh :: args:{ $home $data } vars:{ $nvim_home }"

	if [ -L $nvim_home ] || [ ! -d $nvim_home ]; then
		rm -rf $nvim_home
	fi

	if [ ! -d "$nvim_home" ]; then
		mkdir -p $nvim_home
	fi

	fn_create_symbolic_link "$nvim_home" "$home/config/nvim_s"

	echo "---"
}

function fn_git_clone {
	data=$1
	workspace_home=$2

	for repo in $(cat $data/repo.txt); do
		fn_git_clone_unbxd $repo $workspace_home
	done
}
