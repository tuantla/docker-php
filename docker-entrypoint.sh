#!/bin/sh
/usr/sbin/php-fpm7
exec nginx -g 'daemon off;'