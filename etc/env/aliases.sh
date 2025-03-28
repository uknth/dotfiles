#!/bin/bash

alias workspace="cd $WORKSPACE_HOME"
# Curl
if [ -f "$dotfiles_dir/config/curl.txt" ]; then
	alias curlf="curl -w \"@$dotfiles_dir/config/curl.txt\" -o /dev/null -s"
	alias curlfr="curl -w \"@$dotfiles_dir/config/curl.txt\" -s"
fi
# Docker
alias docker-ecr-login='aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $ECR_URL'

# Debian
alias add-key="sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys "

# Utils
alias ip="fn_ip"

# K8s
alias minikube-start-server="minikube start --driver=docker --addons=ingress --apiserver-port=50505 --ports=50505:50505 --ports=80:80 --ports=2376:2376 --apiserver-ips=192.168.1.137  --cpus=8 --memory=16g"
alias k3s="kubectl --kubeconfig=/home/uknth/.kube_k3s/config"
alias auth-ecr="kubectl delete secret aws-ecr-auth && create_k8s_secret && docker-ecr-login"

# Ssh Jump Hosts
alias jump-use1="ssh jue1"
alias jump-euw2="ssh jew2"
alias jump-aps-2="ssh jas2"
alias jump-aps-1="ssh jas1"

export GCP_PROJECT="unbxdgcp"

alias jump-gcp-anz-prod='gcloud compute ssh --zone "australia-southeast1-a" "devops@prod-au-se1-mgmt-host-gce" --tunnel-through-iap --project "$GCP_PROJECT"'
alias jump-gcp-us-prod='gcloud beta compute ssh --zone "us-east4-a" "pilot-rc-unbxd-mgmt-host-us-est4-a-gce" --tunnel-through-iap --project "$GCP_PROJECT"'

alias git-clone="fn_git_clone_work"

alias nvimobs="nvim ~/Syncthing/Obsidian/Tangerine"

alias w="ssh  workstation-1.hnet"

if [ -f "$DOT_DATA/etc/env/aliases.sh" ]; then 
    source $DOT_DATA/etc/env/aliases.sh
fi

if command -v bat 2>&1 >/dev/null; then
    alias cat="bat"
fi

alias zola='docker run -i -u "$(id -u):$(id -g)" -v $PWD:/app --workdir /app ghcr.io/getzola/zola:v0.19.1'
alias zola-build='docker run -u "$(id -u):$(id -g)" -v $PWD:/app --workdir /app ghcr.io/getzola/zola:v0.19.1 build'
alias zola-run='docker run -u "$(id -u):$(id -g)" -v $PWD:/app --workdir /app -p 8080:8080 ghcr.io/getzola/zola:v0.19.1 serve --interface 0.0.0.0 --port 8080 --base-url workstation-1.hnet'
