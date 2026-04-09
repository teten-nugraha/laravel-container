FROM php:8.2-fpm

# Install dependencies
RUN apt-get update && apt-get install -y \
    git curl zip unzip libpng-dev libonig-dev libxml2-dev

RUN docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd

# Install composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www

COPY . .
COPY docker/entrypoint.sh /usr/local/bin/entrypoint.sh
COPY docker/php-fpm-www.conf /usr/local/etc/php-fpm.d/zz-www.conf

RUN cp -n .env.example .env

RUN composer install --no-dev --optimize-autoloader
RUN cp -a vendor /opt/vendor

RUN chown -R www-data:www-data storage bootstrap/cache
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["php-fpm"]
