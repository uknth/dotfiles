# Dotfiles

Can work with both Linux & MacOS, might need some tweaks. Works for most of my use cases.



To Use the dotfiles

1. Clone the Repository
2. export `DOTFILES_DIR` as part of .zshrc or .bashrc
3. source $DOTFILES_DIR/etc/init.sh


## Sample .zshrc 

Clone in `~/.dotfiles`

```
$ git clone git@github.com:uknth/dotfiles.git ~/.dotfiles
```

```
$ cat ~/.zshrc
export DOTFILES_DIR="$HOME/.dotfiles"
source "$DOTFILES_DIR/etc/init.sh"
```


