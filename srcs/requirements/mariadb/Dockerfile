FROM debian:bookworm

RUN apt-get update && apt-get install -y mariadb-server

COPY conf/my.cnf /etc/mysql/my.cnf
COPY conf/init.sql /docker-entrypoint-initdb.d/

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

USER mysql

CMD ["mysqld"]