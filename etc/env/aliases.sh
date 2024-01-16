#!/bin/bash
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

alias jump-gcp-anz-prod='gcloud compute ssh --zone "australia-southeast1-a" "devops@prod-au-se1-mgmt-host-gce" --tunnel-through-iap --project "$GCP_PROJECT"'
alias jump-gcp-us-prod='gcloud beta compute ssh --zone "us-east4-a" "pilot-rc-unbxd-mgmt-host-us-est4-a-gce" --tunnel-through-iap --project "$GCP_PROJECT"'

alias git-clone="fn_git_clone_work"
