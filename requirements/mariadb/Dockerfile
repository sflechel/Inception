FROM alpine:3.21

RUN apk update && apk upgrade;

RUN apk add mariadb mariadb-client;

WORKDIR /var/lib/mysql

COPY conf/mariadb.conf /etc/my.cnf.d/
RUN mariadb-install-db --auth-root-authentication-method=normal \
	--skip-test-db --datadir=/var/lib/mysql;

COPY tools/mariadb.sh /run
RUN chmod +x /run/mariadb.sh

ENTRYPOINT [ "sh", "/run/mariadb.sh" ]
