FROM debian

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y mariadb-server

COPY ./my.sh /my.sh

RUN chmod +x /my.sh

# RUN /my.sh

CMD ["/my.sh"]

