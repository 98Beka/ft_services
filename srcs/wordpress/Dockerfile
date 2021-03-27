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
RUN ln -s www/wordpress /var/www/localhost/htdocs/wordpress
COPY ./wp-config.php /var/www/localhost/htdocs/wordpress/wp-config.php
RUN rm -rf /www/wordpress/wp-config.php
RUN echo -e "\
<?php\n\
define( 'DB_NAME', 'wordpress' );\n\
define( 'DB_USER', 'admin' );\n\
define( 'DB_PASSWORD', 'admin' );\n\
define( 'DB_HOST', 'mysql-svc' );\n\
define( 'DB_CHARSET', 'utf8' );\n\
define( 'DB_COLLATE', '' );\n\
\$table_prefix = 'wp_';\n\
define( 'WP_DEBUG', false );\n\
if ( ! defined( 'ABSPATH' ) ) {\n\
        define( 'ABSPATH', __DIR__ . '/' );\n\
}\n\
require_once ABSPATH . 'wp-settings.php';\
" >  /var/www/localhost/htdocs/wordpress/wp-config.php

                 #nginx
######################################################
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/CN=localhost' -keyout /etc/ssl/localhost.key -out /etc/ssl/localhost.crt
COPY nginx.conf /etc/nginx/nginx.conf

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
