docker build -t telegraf_image srcs/telegraf/
kubectl delete -f srcs/yaml/telegraf.yaml
kubectl apply -f srcs/yaml/telegraf.yaml
