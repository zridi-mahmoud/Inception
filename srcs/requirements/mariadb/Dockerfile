FROM debian:11

WORKDIR /tmp

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y mariadb-server

COPY ./tools/my.sh /tmp/my.sh

RUN chmod +x /tmp/my.sh

ENTRYPOINT ["/tmp/my.sh"]
