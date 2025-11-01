FROM alpine:3.21

RUN apk update && apk upgrade && apk add nginx openssl

RUN mkdir -p /etc/nginx/ssl && openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:4096\
	-out /etc/nginx/ssl/sflechel.crt\
	-keyout /etc/nginx/ssl/sflechel.key\
	-subj "/C=FR/ST=Martinique/L=Fort-de-France/0=972/CN=sflechel.42.fr"

RUN mkdir -p /var/www/wordpress var/run/nginx && chmod 755 var/www/wordpress

COPY conf/nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT ["nginx", "-g", "daemon off;"]
