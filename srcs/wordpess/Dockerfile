FROM alpine:3.12

RUN apk update && apk upgrade
RUN apk add supervisor nginx wget openssl
RUN mkdir -p /run/nginx;
RUN mkdir /www

                 #wordpress
######################################################
RUN apk add php7 php7-fpm php7-opcache php7-gd \
php7-mysqli php7-zlib php7-curl php7-mbstring \
php7-json php7-session
# Download Wordpress
RUN wget https://wordpress.org/latest.tar.gz \
&& tar -zxvf latest.tar.gz \
&& mv wordpress www/wordpress \
&& rm -rf latest.tar.gz
RUN rm -rf /www/wordpress/wp-config.php
COPY wp-config.php /www/wordpress/wp-config.php

                 #nginx
######################################################
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/CN=localhost' -keyout /etc/ssl/localhost.key -out /etc/ssl/localhost.crt
RUN echo -e "\
server {								\n\
    listen          5050 ssl;           \n\
    listen          [::]:5050 ssl;      \n\
	server_name localhost;				\n\
	root        /www/wordpress/;		\n\
    index 		index.php;			    \n\
	location ~ \.php$ {					\n\
        fastcgi_pass   127.0.0.1:9000;	\n\
        fastcgi_param  SCRIPT_FILENAME  \$document_root\$fastcgi_script_name;\n\
        include        fastcgi.conf; }  \n\
    ssl_certificate_key /etc/ssl/localhost.key;\n\
    ssl_certificate     /etc/ssl/localhost.crt;\n\
}" > /etc/nginx/conf.d/default.conf;

                 #supervisor
######################################################
RUN echo -e "\
[supervisord]                                \n\
nodaemon=true                                \n\
[program:nginx]                              \n\
command=sh -c \"nginx -g 'daemon off;' &&\
kill -s SIGSTREM $(cat supervisord.pid)\"    \n\
[program:wordpress]                          \n\
command=sh -c \"php-fpm7 -F -R &&\
kill -s SIGSTREM $(cat supervisord.pid)\"    \n\
stdout_logfile=/home/nginx.log               \n\
stderr_logfile=/home/nginxerr.log            \n\
" > /etc/supervisord.conf
EXPOSE 5050
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
