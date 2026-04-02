FROM php:8.4-fpm

ARG AIKIDO_VERSION=1.5.4

RUN apt-get update && apt-get install -y \
    git curl zip unzip libpng-dev libonig-dev libxml2-dev libzip-dev \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl -L -o /tmp/aikido-php-firewall.deb \
    "https://github.com/AikidoSec/firewall-php/releases/download/v${AIKIDO_VERSION}/aikido-php-firewall.$(uname -m).deb" \
    && dpkg -i /tmp/aikido-php-firewall.deb \
    && rm /tmp/aikido-php-firewall.deb

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www

COPY composer.json composer.lock ./
RUN composer install --no-dev --no-scripts --no-autoloader

COPY . .

RUN composer dump-autoload --optimize \
    && chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache \
    && chmod -R 775 /var/www/storage /var/www/bootstrap/cache

# Aikido Zen: Set AIKIDO_TOKEN at runtime via docker run -e or docker-compose environment
# ENV AIKIDO_TOKEN="set-at-runtime"
# ENV AIKIDO_BLOCK="false"

COPY docker/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 9000
ENTRYPOINT ["entrypoint.sh"]
