#!/bin/bash

minikube start --vm-driver=virtualbox
eval $(minikube docker-env)
minikube addons enable metallb

#range ip
kubectl apply -f srcs/yaml/configmap.yaml

# nginx
docker build -t nginx_image srcs/nginx/
kubectl apply -f srcs/yaml/nginx.yaml

# #mysql
# docker build -t mysql_image srcs/mysql/
# kubectl apply -f srcs/yaml/mysql.yaml


#phpmyadmin
docker build -t phpmyadmin_image srcs/phpmyadmin/
kubectl apply -f srcs/yaml/phpmyadmin.yaml

# # wordpress
# docker build -t wordpress_image srcs/wordpess/
# kubectl apply -f srcs/yaml/wordpress.yaml

minikube dashboard

# minikube start --vm-driver=virtualbox
# eval $(minikube docker-env)
# kubectl exec -it
# kubectl exec -it ........ -- /bin/sh
# kubectl get all
# nginx -t
# kubectl get svc
# kubectl get pods


