FROM alpine:3.12


RUN apk update && apk upgrade
RUN apk add supervisor nginx wget openssl
RUN mkdir -p /run/nginx;
RUN mkdir /www

                 #phpmyadmin
######################################################
RUN apk add php7 php7-fpm php7-opcache php7-gd \
php7-mysqli php7-zlib php7-curl php7-mbstring \
php7-json php7-session
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-english.tar.gz
RUN tar -zxvf phpMyAdmin-5.0.4-english.tar.gz && rm phpMyAdmin-5.0.4-english.tar.gz
RUN mv phpMyAdmin-5.0.4-english /www/phpmyadmin 
RUN echo -e "\
<?php\n\
\$cfg['blowfish_secret'] = 'beklightbeklight';\n\
\$i = 1;\n\
\$cfg['Servers'][\$i]['auth_type'] = 'cookie';\n\
\$cfg['Servers'][\$i]['host'] = 'mysql-svc';\n\
\$cfg['Servers'][\$i]['port'] = '3306';\n\
\$cfg['Servers'][\$i]['compress'] = false;\n\
\$cfg['Servers'][\$i]['AllowNoPassword'] = false;\n\
\$cfg['Servers'][\$i]['user'] = 'ehande';\n\
\$cfg['Servers'][\$i]['password'] = 'ehande';\n\
" > /www/phpmyadmin/config.inc.php

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
[program:phpmyadmin]                         \n\
command=sh -c \"php-fpm7 -F -R &&\
kill -s SIGSTREM $(cat supervisord.pid)\"    \n\
stdout_logfile=/home/nginx.log               \n\
stderr_logfile=/home/nginxerr.log            \n\
" > /etc/supervisord.conf
EXPOSE 5000
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]