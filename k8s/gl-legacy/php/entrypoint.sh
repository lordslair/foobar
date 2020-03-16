#!/bin/sh

echo "`date +"%F %X"` Building PHP dependencies and system set-up ..."

apk update --no-cache \
    && apk add --no-cache ssmtp bind-tools \
<<<<<<< HEAD
=======
#    && echo 'root=postmaster'           > /etc/ssmtp/ssmtp.conf \
#    && echo "mailhub=$SSMTP_MAILHUB"   >> /etc/ssmtp/ssmtp.conf \
#    && echo 'UseTLS=YES'               >> /etc/ssmtp/ssmtp.conf \
#    && echo 'UseSTARTTLS=YES'          >> /etc/ssmtp/ssmtp.conf \
#    && echo "hostname=$SSMTP_HOSTNAME" >> /etc/ssmtp/ssmtp.conf \
>>>>>>> 80060f079ddac169464adaafdc6ca5079536aebc
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
