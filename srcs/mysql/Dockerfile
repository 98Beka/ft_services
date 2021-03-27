FROM alpine:3.12

RUN apk update && apk upgrade
RUN apk add openrc mysql mysql-client
RUN openrc && touch /run/openrc/softlevel
RUN mkdir -p /run/mysqld
RUN echo -e "\
[mysqld]\n\
user = root\n\
datadir = /var/lib/mysql\n\
port = 3306\n\
log-bin = /var/lib/mysql/mysql-bin\n\
bind-address = 0.0.0.0\n\
skip-networking = false\n\
" > /etc/mysql/my.cnf
RUN echo -e "\
echo \"CREATE DATABASE wordpress;\" | mysql                                             \n\
echo \"CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';\" | mysql  	            \n\
echo \"GRANT ALL PRIVILEGES ON wordpress.* TO admin IDENTIFIED BY 'admin';\" | mysql    \n\
" > /db_creat.sh
RUN chmod +x db_creat.sh
COPY wordpress.sql .
RUN echo -e "\
#!/bin/sh              					        \n\
openrc       						            \n\
/etc/init.d/mariadb setup				        \n\
rc-service mariadb start                        \n\
./db_creat.sh           			            \n\
mysql wordpress -u root < wordpress.sql         \n\
rc-service mariadb stop					        \n\
/usr/bin/mysqld_safe --datadir='/var/lib/mysql' \n\
" > /run.sh
RUN chmod +x /run.sh
VOLUME ["/var/lib/mysql"]
VOLUME ["/sys/fs/cgroup"]                 
EXPOSE 3306
ENTRYPOINT /run.sh;