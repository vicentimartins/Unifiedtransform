FROM php:7.4-fpm-alpine

ADD ./docker/php/www.conf /usr/local/etc/php-fpm.d/www.conf
ADD ./docker/php/php.ini /usr/local/etc/php/php.ini

RUN apk add --no-cache libzip-dev \
    libpng-dev \
    zip;
RUN docker-php-ext-install zip \
    gd \
    pdo \
    pdo_mysql;

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN addgroup -g 1000 laravel && \
    adduser -G laravel -g laravel -s /bin/sh -D laravel

RUN mkdir -p /var/www/html
RUN chown laravel:laravel /var/www/html
WORKDIR /var/www/html

RUN docker-php-ext-install pdo pdo_mysql 
