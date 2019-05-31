#!/bin/sh
export USER="$(id -u)"
export GROUP="$(id -g)"
export PORT=${PORT:-8080}
envsubst '${USER},${GROUP}'  < /etc/php7/php-fpm.d/www.conf.tmpl > /etc/php7/php-fpm.d/www.conf && \
/usr/sbin/php-fpm7 -R
envsubst '${PORT}'  < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf && exec nginx -g 'daemon off;'