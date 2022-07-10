FROM php:8.1-fpm

# Fix debconf warnings upon build
ARG DEBIAN_FRONTEND=noninteractive

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

RUN apt-get install -y \
            libzip-dev \
            zip \
            unzip \
    && docker-php-ext-install zip \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

RUN apt-get update \
    && apt-get -y --no-install-recommends install libpq-dev \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install pdo pdo_pgsql pgsql

# Install git
RUN apt-get update \
    && apt-get -y install git \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

WORKDIR /application
COPY app /application
