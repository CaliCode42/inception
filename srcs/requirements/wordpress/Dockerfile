FROM debian:bookworm

RUN apt update && apt install -y \
    curl \
    php \
    php-fpm \
    php-mysql \
    mariadb-client \
    wget \
    unzip

# install wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

RUN sed -i 's|listen = /run/php/php.*sock|listen = 0.0.0.0:9000|' \
    /etc/php/*/fpm/pool.d/www.conf

WORKDIR /var/www/wordpress

COPY tools/init.sh /init.sh
RUN chmod +x /init.sh

CMD ["/init.sh"]
