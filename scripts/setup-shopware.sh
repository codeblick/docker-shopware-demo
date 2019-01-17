#!/usr/bin/env bash
set -e

if [ -d /var/lib/mysql/${MYSQL_DATABASE} ] ; then
    echo "Shopware is already installed."
    mysqld_safe --datadir='/var/lib/mysql' &
else
    mysql_install_db --datadir='/var/lib/mysql'
    mysqld_safe --datadir='/var/lib/mysql' &

    sleep 1

    mysql -u root -h localhost -e "
        CREATE DATABASE ${MYSQL_DATABASE};
        CREATE USER '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';
        GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE} . * TO '${MYSQL_USER}'@'localhost';
        FLUSH PRIVILEGES;
    "

    rm /var/www/html/recovery/install/data/install.lock

    php recovery/install/index.php \
        --quiet \
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

    chown -R www-data:www-data .

    sudo -u www-data php -d memory_limit=128M bin/console sw:firstrunwizard:disable --no-interaction --quiet
    sudo -u www-data php -d memory_limit=128M bin/console sw:plugin:refresh --no-interaction --quiet
    sudo -u www-data php -d memory_limit=128M bin/console sw:plugin:install --no-interaction --quiet SwagDemoDataDE

    if [ -z "${COB_PLUGIN_NAME}" ]; then
        echo "No plugin was selected for installation."
    else
        sudo -u www-data php -d memory_limit=128M bin/console sw:plugin:install --no-interaction --quiet --activate ${COB_PLUGIN_NAME}
    fi

    sudo -u www-data php -d memory_limit=128M bin/console sw:cache:clear --no-interaction --quiet
    sudo -u www-data php -d memory_limit=128M bin/console sw:theme:cache:generate --no-interaction --quiet
    sudo -u www-data php -d memory_limit=128M bin/console sw:warm:http:cache --no-interaction --quiet
fi

exec apache2-foreground
