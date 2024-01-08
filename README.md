# Dotfiles

Can work with both Linux & MacOS, might need some tweaks. Works for most of my use cases.

```

export DOT_HOME="$HOME/Sync/dotfiles"
export DOT_DATA="$HOME/Sync/dotfiles_data"
export WORKSPACE_HOME="$HOME/Workspace"
source "$DOT_HOME/etc/init.sh"
```

DOT_DATA contains the data folder with caches & secrets, such as pem files & key pairs.
DOT_HOME contains this repository cloned
WORKSPACE_HOME contains the code.
