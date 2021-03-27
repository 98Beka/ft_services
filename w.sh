docker build -t wordpress_image srcs/wordpress/
kubectl delete -f srcs/yaml/wordpress.yaml
kubectl apply -f srcs/yaml/wordpress.yaml
