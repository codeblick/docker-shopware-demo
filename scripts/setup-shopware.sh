#!/usr/bin/env bash
set -e

verlte() {
    [  "$1" = "`echo -e "$1\n$2" | sort -V | head -n1`" ]
}

verlt() {
    [ "$1" = "$2" ] && return 1 || verlte $1 $2
}

if [ -d /var/lib/mysql/${MYSQL_DATABASE} ] ; then
    echo "Shopware is already installed."
    mysqld &
else
    mkdir -p /var/run/mysqld
    chown -R mysql /var/run/mysqld
    mysqld &

    sleep 3

    mysql -u root -h localhost -e "
        CREATE DATABASE ${MYSQL_DATABASE};
        CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
        GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE} . * TO '${MYSQL_USER}'@'%';
        FLUSH PRIVILEGES;
    "

    rm /var/www/html/recovery/install/data/install.lock

    if [ -z "${SHOP_PATH}" ]; then
        if [ verlte ${SW_VERSION} 5.4.0 ]; then
            export SHOP_PATH="/"
        fi
    fi

    php recovery/install/index.php \
        --no-interaction \
        --no-skip-import \
        --db-host="${MYSQL_HOST}" \
        --db-user="${MYSQL_USER}" \
        --db-password="${MYSQL_PASSWORD}" \
        --db-name="${MYSQL_DATABASE}" \
        --shop-locale="${SHOP_LOCALE}" \
        --shop-host="${SHOP_HOST}" \
        --shop-path="${SHOP_PATH}" \
        --shop-name="${SHOP_NAME}" \
        --shop-email="${SHOP_EMAIL}" \
        --shop-currency="${SHOP_CURRENCY}" \
        --admin-username="${ADMIN_USERNAME}" \
        --admin-password="${ADMIN_PASSWORD}" \
        --admin-email="${ADMIN_EMAIL}" \
        --admin-name="${ADMIN_NAME}" \
        --admin-locale="${ADMIN_LOCALE}"

    if [ -z "${SHOP_SSL}" ]; then
        echo "SSL is not active."
    else
        mysql -u root -h localhost ${MYSQL_DATABASE} -e "UPDATE s_core_shops SET secure = 1 WHERE id = '1';"
        var="<?php \$_SERVER['HTTPS'] = 'on'; return array ("
        sed -i "1s/.*/$var/" /var/www/html/config.php
    fi

    chown -R www-data:www-data .
    sudo -u www-data php -d memory_limit=128M bin/console sw:firstrunwizard:disable --no-interaction
    sudo -u www-data php -d memory_limit=128M bin/console sw:plugin:refresh --no-interaction
    sudo -u www-data php -d memory_limit=128M bin/console sw:plugin:install --no-interaction SwagDemoDataDE

    if [ -z "${COB_PLUGIN_NAME}" ]; then
        echo "No plugin was selected for installation."
    else
        sudo -u www-data php -d memory_limit=128M bin/console sw:plugin:install --no-interaction --activate ${COB_PLUGIN_NAME}
    fi

    for i in `/bin/ls -1 /migrations/*.sql`; do
        mysql -u root -h localhost ${MYSQL_DATABASE} < ${i}
    done

    sudo -u www-data php -d memory_limit=128M bin/console sw:cache:clear --no-interaction
    sudo -u www-data php -d memory_limit=128M bin/console sw:theme:cache:generate --no-interaction
fi

exec apache2-foreground
