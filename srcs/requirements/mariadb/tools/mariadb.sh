#!/bin/sh

set -e

mkdir -p /run/mysqld/
cd /var/lib/mysql

mariadbd --user=root &

until mariadb-admin ping --silent --skip-ssl --host="localhost" --user=root
do
	sleep 0.5s
done

mariadb --user=root -h localhost <<EOF
create database if not exists ${MARIADB_DATABASE};
create user if not exists '${MARIADB_USER}'@'%' identified by '$(cat ${MARIADB_PASSWORD_FILE})';
grant all privileges on ${MARIADB_DATABASE}.* to '${MARIADB_USER}'@'%';
flush privileges;
EOF

wait
