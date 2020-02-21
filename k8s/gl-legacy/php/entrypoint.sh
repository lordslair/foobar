#!/bin/sh

echo "`date +"%F %X"` Building PHP dependencies and system set-up ..."

apk update --no-cache \
    && apk add --no-cache --virtual .build-deps \
                                    tzdata \
    && cp /usr/share/zoneinfo/Europe/Paris /etc/localtime \
    && echo 'date.timezone = Europe/Paris' > /usr/local/etc/php/conf.d/date.timezone.ini \
    && apk del .build-deps \
    && docker-php-ext-install mysql \
    && docker-php-ext-enable mysql \
    && docker-php-ext-install mysqli \
    && docker-php-ext-enable mysqli

echo "`date +"%F %X"` Build done ..."

exec php-fpm
