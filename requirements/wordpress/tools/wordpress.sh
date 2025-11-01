#!/bin/sh

until mariadb-admin ping --skip-ssl --host=mariadb --user="$MARIADB_USER" --password="$MARIADB_PASSWORD"
do
	sleep 1s
done

#cat /var/www/wordpress/wp-config.php && 1

wp config create --allow-root --path=/var/www/wordpress\
	--dbname="$MARIADB_DATABASE" \
	--dbuser="$MARIADB_USER" \
	--dbpass="$MARIADB_PASSWORD" \
	--dbhost="mariadb" \

wp core install --allow-root --path=/var/www/wordpress\
	--url="${DOMAIN_NAME}" \
	--title="${DOMAIN_TITLE}" \
	--admin_user="${WP_ADMIN_USER}" \
	--admin_password="${WP_ADMIN_PASS}"\
	--admin_email="${WP_ADMIN_EMAIL}" \

wp user create --allow-root --path=/var/www/wordpress\
	"${WP_USER}" "${WP_USER_EMAIL}" \
	--user_pass="${WP_USER_PASSWORD}" \
	--role=editor 

mkdir -p /run/php
php-fpm84 -F
