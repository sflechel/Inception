FROM alpine:3.21

RUN apk update && apk upgrade \
	&& apk add --no-cache php84 php84-phar php84-fpm php84-pdo php84-pdo_mysql php84-mysqli php84-iconv mariadb-client
RUN ln -s /usr/bin/php84 /usr/bin/php
RUN sed -i "s/memory_limit.*/memory_limit = 312M/"  /etc/php84/php.ini

ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/local/bin/wp
RUN chmod +x /usr/local/bin/wp && mkdir -p /var/www/wordpress
RUN wp core download --allow-root --path=/var/www/wordpress

#RUN ls /var/www/wordpress && 1
#RUN mv /var/www/wordpress/wp-config-sample.php /var/www/wordpress/wp-config.php\
#	&& sed -i "s/database_name_here/${MARIADB_DATABASE}/" /var/www/wordpress/wp-config.php\
#	&& sed -i "s/username_here/${MARIADB_USER}/" /var/www/wordpress/wp-config.php\
#	&& sed -i "s/password_here/${MARIADB_PASSWORD}/" /var/www/wordpress/wp-config.php\
#	&& sed -i "s/localhost/mariadb/" /var/www/wordpress/wp-config.php

COPY conf/wordpress.conf /etc/php84/php-fpm.d/www.conf
COPY tools/wordpress.sh /usr/local/bin/wordpress.sh

EXPOSE 9000

RUN chmod +x /usr/local/bin/wordpress.sh
ENTRYPOINT ["bin/sh", "usr/local/bin/wordpress.sh"]
