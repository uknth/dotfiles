# Util Methods

function fn_dot_home {
	if [[ ! -z "${DOT_HOME}" ]]; then
		echo "$DOT_HOME"
	else
		echo "$HOME/Sync/dotfiles"
	fi
}

function fn_dot_data {
	if [[ ! -z "${DOT_DATA}" ]]; then
		echo "$DOT_DATA"
	else
		echo "$HOME/Sync/dotfiles_data"
	fi
}

function fn_workspace_home {
	if [[ ! -z "${WORKSPACE_HOME}" ]]; then
		echo "$WORKSPACE_HOME"
	else
		echo "$HOME/Sync/Workspace"
	fi
}

# resolve variable `dot_home`
dot="$HOME/.dot"
mkdir -p $dot

dot_lock="$HOME/.dot/lock"
dot_home=$(fn_dot_home)
dot_data=$(fn_dot_data)
dot_history="$dot_data/zsh/history"
workspace_home=$(fn_workspace_home)

if [ ! -d "$dot_home" ]; then
	echo "dir: $dot_home doesn't exist"
	exit 1
fi

if [ ! -d "$dot_data" ]; then
	echo "dir: $dot_home doesn't exist"
	exit 1
fi

# Import Library Files
if [ -d "$dot_home/etc/lib" ]; then
	for f in $dot_home/etc/lib/*; do source $f; done
fi

# Now that we have parsed the library,
# we can use functions defined in lib
dot_os=$(fn_operating_system)
dot_history_size="10000"
dot_is_ftu=$(fn_ftu $dot_lock)

# Load Environment
if [ -d "$dot_home/etc/env" ]; then
	for f in $dot_home/etc/env/*; do source $f; done
fi

# Print startup details

# Set zsh
HISTFILE=$dot_history
HISTSIZE=$dot_history_size
SAVEHIST=$dot_history_size

if [ -f "$dot_data/host/$HOST.sh" ]; then
	source "$dot_data/host/$HOST.sh"
fi

if [ "$dot_is_ftu" = "true" ]; then
	# execute ftu flow
	echo "---"
	echo "ftu -> $USER"
	echo "---"
	fn_create_symbolic_link "$HOME/.bin" "$dot_home/bin"
	fn_create_symbolic_link "$HOME/.ideavimrc" "$dot_home/config/idea/idearc"
	fn_create_symbolic_link "$HOME/.alacritty.yml" "$dot_home/config/alacritty/alacritty.yml"
	fn_create_symbolic_link "$HOME/.wezterm.lua" "$dot_home/config/wezterm.lua"

	if [ "$dot_os" = "darwin" ]; then
		fn_create_symbolic_link "$HOME/.yabairc" "$dot_home/config/yabai/rc"
		fn_create_symbolic_link "$HOME/.skhdrc" "$dot_home/config/skhd/rc"
	fi

	fn_ftu_nvim $dot_home $dot_data # neovim

	# configs with secrets
	fn_ftu_aws $dot_home $dot_data # AWS
	fn_ftu_ssh $dot_home $dot_data # SSH

	# data
	fn_create_symbolic_link "$HOME/.kube" "$dot_data/kube"
	fn_create_symbolic_link "$HOME/.m2" "$dot_data/m2"

	# create directory structure
	fn_create_directory_tree "$workspace_home"

	# clone work repository
	if [[ -z "${DOT_SKIP_GIT_CLONE}" ]]; then
		fn_git_clone "$dot_data" "$workspace_home"
	fi
fi

# Development Environment
fn_dev_go $workspace_home

fn_neofetch
fn_motd

cd $HOME
