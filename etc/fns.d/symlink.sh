function check_and_create_symbolic_links {
    flag="*"

    if [ -L $1 ] ; then
        if [ -e $1 ] ; then
            flag="true"
        else
            flag="false"
        fi
    elif [ -e $1 ] ; then
        flag="false"
    else
        flag="false"
    fi

    if [ "$flag" = "false" ];then 
        # create sym link
        echo "creating symlink for: $2 to $1"
        rm -rf "$1"
        ln -s "$2" "$1"
    fi
}
