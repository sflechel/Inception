#!/bin/sh

cd /var/lib/mysql

mariadbd -u root &

sleep 1

mariadb -u root -p

mariadb -h localhost --user=root "CREATE DATABASE IF NOT EXISTS ${DB};"
mariadb -h localhost --user=root "CREATE USER IF NOT EXISTS ${DB_USER}@'%' IDENTIFIED BY '${DB_USER_PASSWD}';"
mariadb -h localhost --user=root "GRANT ALL PRIVILEGES ON ${DB}.* TO ${DB_USER}@'%';"
mariadb -h localhost --user=root "GRANT ALL PRIVILEGES ON *.* to root@'%' IDENTIFIED BY '${DB_ROOT_PASSWD}';"
mariadb -h localhost --user=root "FLUSH PRIVILEGES;"

mariadb-admin --user=root -p"${DB_ROOT_PASSWD}" #shutdown;

#exec mariadbd -u root;
