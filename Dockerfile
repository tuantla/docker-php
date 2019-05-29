FROM nginx:1.15-alpine
RUN apk update && apk upgrade
RUN apk add openrc php7 php7-fpm php7-opcache && \
    apk add php7-gd php7-mysqli php7-zlib php7-curl
RUN rc-update add php-fpm7 default && apk add curl
COPY php-fpm.conf /etc/php7/php-fpm.conf
COPY default.conf /etc/nginx/conf.d/default.conf
COPY docker-entrypoint.sh /app/bin/docker-entrypoint.sh
WORKDIR /app
ENV ENV prod
RUN echo "<?php var_export(\$_SERVER);?>" > /app/index.php && \
    sed -i -e 's/;clear_env = no/clear_env = no/g' /etc/php7/php-fpm.d/www.conf
ENTRYPOINT ["bin/docker-entrypoint.sh"]

