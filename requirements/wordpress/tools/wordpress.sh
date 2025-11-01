#!/bin/sh

if ! wp core is-installed --allow-root --path=/var/www/wordpress
then

until mariadb-admin ping --skip-ssl --host=mariadb --user="$MARIADB_USER" --password="$MARIADB_PASSWORD"
do
	sleep 1s
done

#wp --allow-root --path=/var/www/wordpress config create \
#	--dbname="$MARIADB_DATABASE" \
#	--dbuser="$MARIADB_USER" \
#	--dbpass="$MARIADB_PASSWORD" \
#	--dbhost="mariadb" \

wp core install --allow-root --path=/var/www/wordpress\
	--url="${DOMAIN_NAME}" \
	--title="${DOMAIN_TITLE}" \
	--admin-user="${WP_ADMIN_USER}" \
	--admin_password="${WP_ADMIN_PASS}"\
	--admin-email="${WP_ADMIN_EMAIL}" \

wp user create --allow-root --path=/var/www/wordpress\
	"${WP_USER}" "${WP_USER_EMAIL}" \
	--user_pass="${WP_USER_PASSWORD}" \
	--role=editor 

fi

mkdir -p /run/php
php-fpm8.4 -F
