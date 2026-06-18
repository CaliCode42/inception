FROM debian:bookworm

RUN apt-get update && apt-get install -y mariadb-server

COPY conf/my.cnf /etc/mysql/my.cnf
COPY tools/docker-entrypoint.sh /usr/local/bin/

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql && \
    chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]