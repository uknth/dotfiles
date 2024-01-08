function fn_ip {
	if [ $# -eq 0 ]; then
		echo "No arguments supplied"
		exit 1
	fi

	curl -s "https://ipinfo.io/$1" | jq .
}

function fn_motd {
	if [[ -z "${DOT_SKIP_MOTD}" ]]; then
		curl -s 'https://api.api-ninjas.com/v1/quotes' -H 'Referer: https://api-ninjas.com/' -H 'Origin: https://api-ninjas.com' >/tmp/quote

		quote="$(cat /tmp/quote | jq '.[].quote')"
		author="$(cat /tmp/quote | jq '.[].author')"

		printf "Quote Of the Day: \n\n  %s\n\t- %s\n---", "$quote", "$author"
	fi
}

function fn_git_clone_unbxd {
	if [ ! -z "$1" ]; then
		workspace_home="$2"

		# Workspace Directories should Exist
		if [ ! -d "$workspace_home/orig" ]; then
			fn_create_directory_tree
		fi

		if [ ! -d "$workspace_home/fork" ]; then
			fn_create_directory_tree
		fi

		fork="$workspace_home/fork"
		orig="$workspace_home/orig"

		mkdir -p $fork
		mkdir -p $orig

		if [ -d "$orig/$1" ]; then
			echo "Directory Exists: $orig/$1 [ Not Cloning ]"
		else
			echo "Cloning: unbxd/$1 in $orig/$1"
			git clone --recursive git@github.com:unbxd/$1.git "$orig/$1"
		fi

		if [ -d "$fork/$1" ]; then
			echo "Directory Exists: $fork/$1 [ Not Cloning ]"
		else
			echo "Cloning: uknth/$1 in $fork/$1"
			git clone --recursive git@github.com:uknth/$1.git "$fork/$1"

			echo "Updating Remotes: upstream -> unbxd/$1"

			cd $fork/$1
			git remote add upstream git@github.com:unbxd/$1.git
			git fetch --all
			cd -
		fi
	fi
}
