function generate_go_vars {
    if [ ! -d "$HOME/Workspace/lib/Go" ]; then
        create_directory_tree
    fi 

    go_path="$HOME/Workspace/lib/Go"

    export GOPATH="$go_path"
}
