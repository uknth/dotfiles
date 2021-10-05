function generate_go_vars {
    if [ ! -d "$HOME/Workspace/lib/Go" ]; then
        create_directory_tree
    fi 

    go_path="$HOME/Workspace/lib/Go"
    go_root="unknown"

    # check if go binary exists
    if command -v go &> /dev/null; then 
        go_root="$(go env GOROOT)"
    fi

    export GOROOT="$go_root"
    export GOPATH="$go_path"
}