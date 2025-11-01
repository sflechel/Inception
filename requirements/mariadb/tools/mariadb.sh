#!/bin/sh

set -e

mkdir -p /run/mysqld/
chown -R mysql:mysql /var/lib/mysql
cd /var/lib/mysql

mariadbd --user=root &

until mariadb-admin ping --silent --skip-ssl --host="localhost" --user=root --password=${MARIADB_ROOT_PASSWORD}
do
	sleep 0.5s
done

#if [ -z "$(ls /var/lib/mysql/$DB)" ]; then
#	mariadb --user=root -h localhost <<EOF
#create database if not exists $DB;
#EOF
#fi

mariadb --user=root --password=${MARIADB_ROOT_PASSWORD}  -h localhost <<EOF
create database if not exists ${MARIADB_DATABASE};
alter user 'root'@'localhost' identified by '${MARIADB_ROOT_PASSWORD}';
create user if not exists '${MARIADB_USER}'@'%' identified by '${MARIADB_PASSWORD}';
grant all privileges on ${MARIADB_DATABASE}.* to '${MARIADB_USER}'@'%';
flush privileges;
EOF

wait
