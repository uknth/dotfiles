alias minikube-start-server="minikube start --driver=docker --addons=ingress --apiserver-port=50505 --ports=50505:50505 --ports=80:80 --ports=2376:2376 --apiserver-ips=192.168.1.137  --cpus=8 --memory=16g"
alias k3s="kubectl --kubeconfig=/home/uknth/.kube_k3s/config"
alias auth-ecr="kubectl delete secret aws-ecr-auth && create_k8s_secret && docker-ecr-login"
