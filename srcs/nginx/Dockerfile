FROM  alpine:latest

RUN apk update && apk upgrade
RUN apk add nginx openssl openssh-server supervisor

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/CN=localhost' -keyout /etc/ssl/localhost.key -out /etc/ssl/localhost.crt

#nginx
RUN mkdir /run/nginx; 
RUN echo -e "\
server {                                          \n\
		listen 443			ssl;                          \n\
		listen [::]:443		ssl;                        \n\
		server_name			localhost;                    \n\
    # SSL                                         \n\
	  ssl on;                                       \n\
		ssl_certificate /etc/ssl/localhost.crt;       \n\
	  ssl_certificate_key /etc/ssl/localhost.key;   \n\
}                                                 \n\
# HTTP redirect                                   \n\
server {                                          \n\
    listen      80;                               \n\
    listen      [::]:80;                          \n\
    server_name localhost;                        \n\
    return 301 https://\$host\$request_uri;         \n\
}" > /etc/nginx/http.d/default.conf;

#supervisor
RUN echo -e "\
[supervisord]                                    \n\
nodaemon=true                                    \n\
[program:nginx]                                  \n\
command=nginx                                    \n\
autostart=true                                   \n\
autorestart=true                                 \n\
startretries=5                                   \n\
stdout_logfile=/home/nginx.log                   \n\
stderr_logfile=/home/nginxerr.log                \n\
" > /etc/supervisord.conf

# create SSH key ssh
RUN sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
  && echo "root:root" | chpasswd \
  && /usr/bin/ssh-keygen -A \
  && ssh-keygen -t rsa -b 4096 -f  /etc/ssh/ssh_host_key

EXPOSE 80 443 22 23

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]