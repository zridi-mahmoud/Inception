FROM debian:11

RUN apt-get update && apt-get upgrade -y


RUN apt-get install -y nginx && apt-get install -y openssl && apt-get install -y vim && apt-get install -y curl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt \
    -subj "/C=MA/ST=KH/L=KHOURIBGA/O=1337/OU=1337/CN=www.1337.ma"

COPY ./tools/config.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]
