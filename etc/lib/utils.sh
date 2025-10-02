function fn_ip {
	if [ $# -eq 0 ]; then
		echo "No arguments supplied"
		exit 1
	fi

	curl -s "https://ipinfo.io/$1" | jq .
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

function fn_create_symlink {
	dot_os=$1
	dot_home=$2
	dot_data=$3

	fn_create_symbolic_link "$HOME/.bin" "$dot_home/bin"
	fn_create_symbolic_link "$HOME/.ideavimrc" "$dot_home/config/idea/idearc"
	fn_create_symbolic_link "$HOME/.alacritty.yml" "$dot_home/config/alacritty/alacritty.yml"
	fn_create_symbolic_link "$HOME/.wezterm.lua" "$dot_home/config/wezterm.lua"
    fn_create_symbolic_link "$HOME/.config/kitty" "$dot_home/config/kitty"
    fn_create_symbolic_link "$HOME/.config/ghostty" "$dot_home/config/ghostty"
	mkdir -p "$HOME/.config/wezterm"
	fn_create_symbolic_link "$HOME/.config/wezterm/colors" "$dot_home/config/wezterm-colors"

	# exclusive to macos
	if [ "$dot_os" = "darwin" ]; then
		fn_create_symbolic_link "$HOME/.yabairc" "$dot_home/config/yabai/rc"
		fn_create_symbolic_link "$HOME/.skhdrc" "$dot_home/config/skhd/rc"
	fi

	# different config for mac & linux
	if [ "$dot_os" = "darwin" ]; then
		mkdir -p "$HOME/Library/Application Support/halloy/"
		fn_create_symbolic_link "$HOME/Library/Application Support/halloy/config.yaml" "$dot_home/config/halloy/config.yaml"
	fi

	fn_ftu_nvim $dot_home $dot_data # neovim

	# configs with secrets
	fn_ftu_aws $dot_home $dot_data # AWS
	fn_ftu_ssh $dot_home $dot_data # SSH

	# data
	fn_create_symbolic_link "$HOME/.kube" "$dot_data/kube"
	fn_create_symbolic_link "$HOME/.m2" "$dot_data/m2"
}
