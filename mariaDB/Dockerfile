FROM debian:12.1

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y mariadb-server

COPY ./my.sh /my.sh

RUN chmod +x /my.sh

ENTRYPOINT ["/my.sh"]

CMD ["mysqld"]