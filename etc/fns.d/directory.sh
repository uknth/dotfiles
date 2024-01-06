function create_directory_tree {
    declare -a paths=(
        "$HOME/Workspace/fork" 
        "$HOME/Workspace/orig"
        "$HOME/Workspace/scratch"
        "$HOME/Workspace/lib"
        "$HOME/Workspace/lib/Go/bin"
        "$HOME/Workspace/lib/Go/src"
        "$HOME/Workspace/lib/Go/pkg"
    )

    for i in "${paths[@]}"; do
        create_directory "$i"
    done
}

function create_directory {
    if [ ! -d "$1" ]; then
        echo "Creating Directory: $1"
        mkdir -p $1
    fi
}