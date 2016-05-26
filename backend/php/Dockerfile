FROM php:5.6-fpm

MAINTAINER  Coomy Chang <coomysky@gmail.com>


RUN     docker-php-ext-install -j$(nproc) pdo_mysql && docker-php-ext-install -j$(nproc) mbstring &&\
        docker-php-ext-install -j$(nproc) tokenizer && curl -sS https://getcomposer.org/installer | php &&\
        mv composer.phar /usr/local/bin/composer && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

