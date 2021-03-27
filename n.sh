docker build -t nginx_image srcs/nginx/
kubectl delete -f srcs/yaml/nginx.yaml
kubectl apply -f srcs/yaml/nginx.yaml
