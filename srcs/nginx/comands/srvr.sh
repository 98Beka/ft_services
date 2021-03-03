docker rmi $(docker images -q)
docker build -t srvr ../.
docker run --rm -it  -p 80:80 -p 443:443 -p 22:22 srvr