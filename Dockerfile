ARG COB_SW_VERSION

FROM codeblick/shopware-core:ce-${COB_SW_VERSION}

ENV SW_APP_ENV=production

ENV MYSQL_USER=shopware
ENV MYSQL_PASSWORD=7Iuagg3or7O4
ENV MYSQL_DATABASE=shopware
ENV MYSQL_HOST=127.0.0.1

ENV SHOP_LOCALE="de_DE"
ENV SHOP_HOST="localhost"
ENV SHOP_PATH=""
ENV SHOP_NAME="Demo Shop"
ENV SHOP_EMAIL="admin@localhost"
ENV SHOP_CURRENCY="EUR"
ENV ADMIN_USERNAME="admin"
ENV ADMIN_PASSWORD="0h4JDx7v6dFY"
ENV ADMIN_EMAIL="admin@localhost"
ENV ADMIN_NAME="admin"
ENV ADMIN_LOCALE="de_DE"

COPY ./assets/index.tpl /var/www/html/themes/Frontend/Responsive/frontend/index/index.tpl
COPY ./assets/.htaccess /var/www/html/.htaccess
COPY ./assets/SwagDemoDataDE /var/www/html/engine/Shopware/Plugins/Community/Frontend/SwagDemoDataDE
COPY ./scripts/setup-shopware.sh /usr/local/bin/setup-shopware

RUN chmod +x /usr/local/bin/setup-shopware && \
    apt-get install -qq -y mysql-server sudo

CMD ["setup-shopware"]
