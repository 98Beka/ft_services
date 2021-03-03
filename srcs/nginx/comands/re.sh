minikube delete
minikube start
eval $(minikube docker-env)
minikube addons enable metallb
docker build -t nginx_image ../.
kubectl apply -f nginx.yaml
kubectl apply -f configmap.yaml
docker ps
kubectl get svc
kubectl get pods
minikube dashboard