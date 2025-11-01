#!/bin/sh

until mariadb-admin ping --skip-ssl --host=mariadb --user="$MARIADB_USER" --password="$MARIADB_PASSWORD"
do
	sleep 1s
done

#cat /var/www/wordpress/wp-config.php && 1

wp config create --allow-root --path=/var/www/wordpress\
	--dbname="$MARIADB_DATABASE" \
	--dbuser="$MARIADB_USER" \
	--dbpass="$(cat $MARIADB_PASSWORD_FILE)" \
	--dbhost="mariadb" \

wp core install --allow-root --path=/var/www/wordpress\
	--url="${DOMAIN_NAME}" \
	--title="${DOMAIN_TITLE}" \
	--admin_user="${WP_ADMIN_USER}" \
	--admin_password="$(cat ${WP_ADMIN_PASSWORD_FILE})"\
	--admin_email="${WP_ADMIN_EMAIL}" \

wp user create --allow-root --path=/var/www/wordpress\
	"${WP_USER}" "${WP_USER_EMAIL}" \
	--user_pass="$(cat ${WP_USER_PASSWORD_FILE})" \
	--role=editor 

mkdir -p /run/php
php-fpm84 -F
