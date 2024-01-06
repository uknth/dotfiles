function git_clone_work {
    if [ ! -z "$1" ]; then
        # Workspace Directories should Exist
        if [ ! -d "$HOME/Workspace/orig" ]; then
            create_directory_tree
        fi

        if [ ! -d "$HOME/Workspace/fork" ]; then
            create_directory_tree
        fi

        fork="$HOME/Workspace/fork"
        orig="$HOME/Workspace/orig"

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
