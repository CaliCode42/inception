FROM mariadb:10.11

COPY conf/my.cnf /etc/mysql/my.cnf

COPY conf/init.sql /docker-entrypoint-initdb.d/

RUN chmod 644 /etc/mysql/my.cnf
