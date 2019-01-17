[![Docker Pulls](https://img.shields.io/docker/pulls/codeblick/shopware-demo.svg)](https://hub.docker.com/r/codeblick/shopware-demo/)
[![Docker Stars](https://img.shields.io/docker/stars/codeblick/shopware-demo.svg)](https://hub.docker.com/r/codeblick/shopware-demo/)
[![Build Status](https://travis-ci.org/codeblick/docker-shopware-demo.svg?branch=master)](https://travis-ci.org/codeblick/docker-shopware-demo)

# codeblick/shopware-demo

This image is based on the codeblick/shopware-core images.

## Supported tags

- `5.5.4`

## Environment variables

```dockerfile
ENV MYSQL_USER="shopware"
ENV MYSQL_PASSWORD="7Iuagg3or7O4"
ENV MYSQL_DATABASE="shopware"

ENV SHOP_LOCALE="de_DE"
ENV SHOP_HOST="localhost"
ENV SHOP_PATH=""
ENV SHOP_NAME="Demo Shop"
ENV SHOP_EMAIL="admin@localhost"
ENV SHOP_CURRENCY="EUR"
ENV SHOP_SSL=""
ENV ADMIN_USERNAME="admin"
ENV ADMIN_PASSWORD="0h4JDx7v6dFY"
ENV ADMIN_EMAIL="admin@localhost"
ENV ADMIN_NAME="admin"
ENV ADMIN_LOCALE="de_DE"

ENV COB_PLUGIN_NAME=""
```
