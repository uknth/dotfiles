# -- START
# variables
machine="*"
history_file="*"
cifs_mount="false"
ftu="true"
lock="$HOME/.dot.lock"
verbose="false"

if [ -z "$KITTY_WINDOW_ID" ] && [ -z "$ALACRITTY_LOG" ]; then
    verbose="true"
fi

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine="linux";;
    Darwin*)    machine="darwin";;
    *)          machine="UNKNOWN:${unameOut}"
esac

if  command -v neofetch &> /dev/null; then
    # Do not print neofetch when running in alacritty or kitty
    if [ "$verbose" = "true" ]; then
        neofetch
        echo "----------------------------------------"
    fi
else 
    echo "Neofetch not found"

    case "${machine}" in
        "linux")     sudo apt-get install -y neofetch && echo "-------" && neofetch;;
        "darwin")    brew install neofetch && echo "---------" && neofetch ;;
        *)          echo "$machine not recognised"
    esac

fi

if [ -f "$lock" ]; then 
    ftu="false"
    echo "Login TS: $(date +%s) $(tty)" >> $lock
else
    echo "----------------------" > $lock
    echo "Created: $(date)" >> $lock
    echo "----------------------" >> $lock
    echo "$(neofetch)" >> $lock
    echo "----------------------" >> $lock
    echo "Login TS: $(date +%s) $(tty)" >> $lock
fi


# >> Configurable Parameters                
#----------------------------------------
dotfiles_dir="$HOME/Synced/dotfiles"
history_size=999999
#----------------------------------------

if [[ ! -z "${DOTFILES_DIR}" ]]; then
    dotfiles_dir="${DOTFILES_DIR}"
fi

if [[ ! -z "${DOTFILES_HIST_SIZE}" ]]; then
    history_size="${DOTFILES_HIST_SIZE}"
fi

history_file="$dotfiles_dir/data/_history"

if [ "$machine" = "linux" ]; then 
    # check if the directory is mounted
    parent_dotfiles_dir=$(dirname "$dotfiles_dir")
    if mountpoint -q -- "$parent_dotfiles_dir"; then

        history_file="$HOME/.dot_history"
        cifs_mount="true"

        if [ ! -f "$HOME/.dot_history" ]; then
            rsync -ar "$dotfiles_dir/data/_history" "$HOME/.dot_history"

            src="$dotfiles_dir/data/_history"
            dest="$HOME/.dot_history"

            crontab -l > /tmp/cron.job

            echo "*/5 * * * * rsync -ar $src $dest" >> /tmp/cron.job
            crontab /tmp/cron.job
            rm /tmp/cron.job
        fi
    fi
fi

# >> Imports
#----------------------------------------

if [ "$verbose" = "true" ]; then 
    echo "DOTFILES: $dotfiles_dir"
    echo "CIFS_MOUNT: $cifs_mount"
fi

# Functions in ./fns.d/*
if [ -d "$dotfiles_dir/etc/fns.d" ]; then 
    for f in $dotfiles_dir/etc/fns.d/*; do  source $f; done
fi 

# Aliases in ./aliases.d/*
if [ -d "$dotfiles_dir/etc/aliases.d" ]; then 
    for f in $dotfiles_dir/etc/aliases.d/*; do source $f; done
fi 


# >> Setup Environment
#----------------------------------------
check_and_create_symbolic_links "$HOME/.aws" "$dotfiles_dir/config/aws"
check_and_create_symbolic_links "$HOME/.ideavimrc" "$dotfiles_dir/config/idea/idearc"
check_and_create_symbolic_links "$HOME/.bin" "$dotfiles_dir/bin"
check_and_create_symbolic_links "$HOME/.alacritty.yml" "$dotfiles_dir/config/alacritty/alacritty.yml"

if [ "$machine" = "darwin" ]; then 
    check_and_create_symbolic_links "$HOME/.spacebarrc" "$dotfiles_dir/config/spacebar/rc"
    check_and_create_symbolic_links "$HOME/.yabairc" "$dotfiles_dir/config/yabai/rc"
    check_and_create_symbolic_links "$HOME/.skhdrc" "$dotfiles_dir/config/skhd/rc"
    check_and_create_symbolic_links "$HOME/.simplebarrc" "$dotfiles_dir/config/simple-bar/rc"
fi

# mkdir -p $HOME/Library/Preferences/kitty
# check_and_create_symbolic_links "$HOME/Library/Preferences/kitty/kitty.conf" "$dotfiles_dir/config/kitty/kitty.conf"

if [ "$cifs_mount" != "true" ]; then
    check_and_create_symbolic_links "$HOME/.ssh" "$dotfiles_dir/config/ssh"

    dest="$HOME/.ssh"
    chmod -f 700 $dest/id_rsa*
    chmod -f 700 $dest/*.pem 
else
    # check if ~/.ssh/config exists, if not do a rsync
    if [ ! -f "$HOME/.ssh/config" ]; then
        src="$dotfiles_dir/config/ssh/"
        dest="$HOME/.ssh"

        rsync -ar "$src" "$dest"

        chmod -f 700 $dest/id_rsa*
        chmod -f 700 $dest/*.pem

        # Set the same up on crontab
        crontab -l > /tmp/cron.job
        echo "0 * * * * rsync -ar $src $dest && chmod 700 $dest/id_rsa* $dest/*.pem" >> /tmp/cron.job
        crontab /tmp/cron.job
    fi
fi

# Create Directory Tree
create_directory_tree

# Set up Development Environment
generate_go_vars

if [ "$ftu" = "true" ]; then 

    declare -a repos=(
        "asterix"
        "albus"
        "ether"
        "wingman"
        "blackpearl"
        "search-brewer"
        "nats-bridge"
        "mozart"
        "cube"
        "solr-zero"
        "qpl"
        "banshee"
        "hagrid"
        "overpass"
        "odin"
    )
    echo "----------------------------------------"
    for i in "${repos[@]}"; do
        git_clone_work $i
    done
    echo "----------------------------------------"

	git config --global url."git@github.com:".insteadOf "https://github.com/"

    # Set up vim
    echo "Installing: vim"

    # Remove Existing .vim directory and .vimrc
    rm -rf ~/.vim ~/.vimrc
    
    # Clone Vim Config
    git clone git@github.com:uknth/vimx.git $HOME/.vim

    # Vim Setting
    echo "source $HOME/.vim/vimrc.vim" > $HOME/.vimrc
    echo "colorscheme Tomorrow" >> ~/.vimrc
	echo "set background=light" >> ~/.vimrc

    echo "Note: vim setup Complete, install yarn from nodesource"

fi


# >> ZSH/BASH Setup Parameters
#----------------------------------------
HISTFILE=$history_file
HISTSIZE=$history_size
SAVEHIST=$history_size

# >> Exports
#----------------------------------------
export LC_ALL=en_US.UTF-8
export EDITOR="vim"
export PATH="$dotfiles_dir/bin:$PATH"
export PATH="$PATH:$GOROOT/bin:$GOPATH/bin"

# >> Exports 
if [ -d "$dotfiles_dir/etc/exports.d" ]; then 
    for f in $dotfiles_dir/etc/exports.d/*; do source $f; done
fi 



# >> Host Specific Configuration
#----------------------------------------
if [ -f "$dotfiles_dir/config/host/$HOST.sh" ]; then
    source "$dotfiles_dir/config/host/$HOST.sh"
fi

if [ "$verbose" = "true" ]; then 
    echo "----------------------------------------"
fi 

cd $HOME
# -- END
