#!/bin/bash

minikube start --vm-driver=virtualbox
eval $(minikube docker-env)
minikube addons enable metallb
docker pull metallb/speaker:v0.8.2
docker pull metallb/controller:v0.8.2
kubectl apply -f srcs/yaml/configmap.yaml


#  # influx
# docker build -t influxdb_image srcs/inflx_grfn_tlgrf/influxdb/
# kubectl apply -f srcs/yaml/influxdb.yaml

## grafana
# docker build -t grafana_image srcs/inflx_grfn_tlgrf/grafana/
# kubectl apply -f srcs/yaml/grafana.yaml

##telegraf
# docker build -t telegraf_image srcs/inflx_grfn_tlgrf/telegraf/
# kubectl apply -f srcs/yaml/telegraf.yaml

# nginx
docker build -t nginx_image srcs/nginx/
kubectl apply -f srcs/yaml/nginx.yaml

#mysql
docker build -t mysql_image srcs/mysql/
kubectl apply -f srcs/yaml/mysql.yaml


# # phpmyadmin
# docker build -t phpmyadmin_image srcs/phpmyadmin/
# kubectl apply -f srcs/yaml/phpmyadmin.yaml

# wordpress
docker build -t wordpress_image srcs/wordpress/
kubectl apply -f srcs/yaml/wordpress.yaml

# # ftps
# docker build -t ftps_image srcs/ftps/
# kubectl apply -f srcs/yaml/ftps.yaml

# minikube start --vm-driver=virtualbox
# eval $(minikube docker-env)
# kubectl exec -it
# kubectl exec -it ........ -- /bin/sh
# kubectl get all
# nginx -t
# kubectl get svc
# kubectl get pods

minikube dashboard

