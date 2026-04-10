#!/bin/sh
set -e

if [ ! -f /var/www/vendor/autoload.php ]; then
    mkdir -p /var/www/vendor
    cp -a /opt/vendor/. /var/www/vendor/
fi

mkdir -p /var/www/storage/logs /var/www/storage/framework /var/www/bootstrap/cache
chown -R www-data:www-data /var/www/storage/logs /var/www/storage/framework /var/www/bootstrap/cache
chown www-data:www-data /var/www/storage /var/www/storage/app
chown -R www-data:www-data /var/www/vendor
chmod -R ug+rwX /var/www/vendor
chmod -R ug+rwX /var/www/storage/logs /var/www/storage/framework /var/www/bootstrap/cache
chmod ug+rwX /var/www/storage /var/www/storage/app

exec "$@"
