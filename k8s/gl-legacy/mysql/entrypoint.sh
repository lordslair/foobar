#!/bin/sh

echo "`date +"%F %X"` Building MySQL dependencies and system set-up ..."

apt-get update \
    && apt-get install -y wget \
    && wget https://downloads.mysql.com/archives/get/p/23/file/mysql-5.0.96-linux-x86_64-glibc23.tar.gz -O /tmp/mysql.tar.gz \
    && tar -xzf /tmp/mysql.tar.gz --no-same-owner -C /usr/local/mysql --strip-components=1 \
    && rm -rf /tmp/mysql.tar.gz \
    && useradd --system mysql \
    && chown mysql:mysql /var/lib/mysql \
    && ./scripts/mysql_install_db --datadir=/var/lib/mysql --user=mysql

echo "`date +"%F %X"` Build done ..."

exec /usr/local/mysql/bin/mysqld_safe --defaults-file=/etc/mysql/my.cnf
