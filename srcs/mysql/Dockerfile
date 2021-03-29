FROM  alpine:3.12

RUN apk update && apk upgrade
RUN apk add mariadb mariadb-client openrc libc6-compat

RUN mkdir -p /run/mysqld

VOLUME ["/var/lib/mysql"]
VOLUME /sys/fs/cgroup
COPY wordpress.sql /wordpress.sql

RUN echo -e "\
[mysqld]\n\
user = root\n\
port = 3306\n\
datadir = /var/lib/mysql\n\
bind-address = 0.0.0.0\n\
skip-networking = false\n\
log-bin = /var/lib/mysql-bin\n\
" > /etc/my.cnf

RUN echo -e "\
echo \"CREATE DATABASE wordpress;\" | mysql                                                \n\
echo \"CREATE USER 'admin'@'192.168.99.240/255.255.255.0' IDENTIFIED BY 'admin';\" | mysql \n\
echo \"GRANT ALL PRIVILEGES ON wordpress.* TO admin IDENTIFIED BY 'admin';\" | mysql       \n\
" > /db_creat.sh
RUN chmod +x db_creat.sh

RUN echo -e "\
\#!/bin/sh\n\
openrc default\n\
/etc/init.d/mariadb setup\n\
rc-service mariadb start\n\
./db_creat.sh\n\
mysql -u root wordpress < wordpress.sql\n\
rc-service mariadb stop\n\
/usr/bin/mysqld_safe\n\
" > /run.sh

RUN mkdir -p /var/log/run
RUN chmod -R 755 run.sh

EXPOSE 3306

CMD /run.sh