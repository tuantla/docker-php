FROM nginx:1.15-alpine
RUN apk update && apk upgrade
RUN apk add openrc php7 php7-fpm php7-opcache && \
    apk add php7-gd php7-mysqli php7-zlib php7-curl  php7-session
RUN rc-update add php-fpm7 default && apk add curl
COPY php-fpm.conf /etc/php7/php-fpm.conf
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf.tmpl /etc/nginx/conf.d/default.conf.template
COPY docker-entrypoint.sh /docker-entrypoint.sh
WORKDIR /app
ENV ENV prod
RUN echo "<?php var_export(\$_SERVER);?>" > /app/index.php && \
    sed    -e 's/^user = nobody/user = ${USER}/g'  \
           -e 's/^group = nobody/group = ${GROUP}/g' \
           -e 's/;clear_env = no/clear_env = no/g' /etc/php7/php-fpm.d/www.conf > /etc/php7/php-fpm.d/www.conf.tmpl
# RUN chgrp -R 0 /etc/php7/php-fpm.d &&  chmod -R g=u /etc/php7/php-fpm.d && \
#     chgrp -R 0 /etc/nginx/conf.d &&  chmod -R g=u /etc/nginx/conf.d && \
#     chgrp -R 0 /var/log/php7 &&  chmod -R g=u /var/log/php7/
ENTRYPOINT ["/docker-entrypoint.sh"]

