#rtil Methods

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

	fn_create_symlink $dot_os $dot_home $dot_data

	# create directory structure
	fn_create_directory_tree "$workspace_home"

	# clone work repository
	if [[ -z "${DOT_SKIP_GIT_CLONE}" ]]; then
		fn_git_clone "$dot_data" "$workspace_home"
	fi
fi

# Development Environment
fn_dev_go $workspace_home

# fn_neofetch

opt_dir="/opt"

# Get all subdirectories in /opt that contain a bin subdirectory
bin_dirs=$(find "$opt_dir" -mindepth 2 -maxdepth 2 -type d -name "bin" -print)

new_path=""
for i in $(find "/opt" -mindepth 2 -maxdepth 2 -type d -name "bin" -print); do 
	new_path="$new_path:$i" 
done


export PATH="$PATH$new_path"

# ssh-environment, makes sure its up
SSH_ENV="$HOME/.ssh/agent-environment"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

cd $HOME
