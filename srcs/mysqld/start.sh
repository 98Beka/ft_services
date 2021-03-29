#!/bin/sh

mariadb-install-db --user=root
mysqld --user=root & sleep 5
mysql --user=root --execute="CREATE DATABASE wordpress;"
mysql --user=root wordpress < wordpress.sql
mysql --user=root --execute="CREATE USER 'admin'@'%' IDENTIFIED BY 'admin'; GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION; USE wordpress; FLUSH PRIVILEGES;"
/usr/bin/mysqld_safe --datadir="/var/lib/mysql"
