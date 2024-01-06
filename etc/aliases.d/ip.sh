function getIP {
    if [ $# -eq 0 ]; then
        echo "No arguments supplied"
        exit 1
    fi

    curl -s "https://ipinfo.io/$1" | jq .
}

alias ip="getIP"
