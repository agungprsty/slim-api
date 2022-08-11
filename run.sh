#!/bin/sh

cd /var/www/html 
php -S 0.0.0.0:$APP_PORT -t public