minikube start
eval $(minikube docker-env)
docker build -t php8 .
kubectl apply -f manifests/
