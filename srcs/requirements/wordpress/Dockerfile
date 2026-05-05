FROM debian:bullseye

RUN apt update && apt install -y \
    php \
    php-fpm \
    php-mysql \
    curl \
    ca-certificates \
    mariadb-client

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/www \
    && curl -O https://wordpress.org/latest.tar.gz \
    && tar -xzf latest.tar.gz \
    && mv wordpress /var/www/wordpress \
    && rm latest.tar.gz

# config PHP-FPM
RUN sed -i 's|listen = .*|listen = 9000|' /etc/php/*/fpm/pool.d/www.conf

RUN mkdir -p /run/php

COPY tools/init.sh /init.sh
RUN chmod +x /init.sh

EXPOSE 9000

CMD ["/init.sh"]