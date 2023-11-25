# base image
FROM    debian:11

# install php and php-curl and php-mysql and php8.2-fpm and curl and sendmail
RUN apt update && apt install -y php7.4 php7.4-curl php7.4-mysql php7.4-fpm curl

RUN mkdir -p /run/php/

COPY ./tools/my.sh /my.sh

RUN chmod +x /my.sh

ENTRYPOINT [ "/my.sh" ]

CMD [ "php-fpm7.4", "-F" ]
