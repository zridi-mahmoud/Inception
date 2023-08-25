#!/bin/sh

sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf
sed -i '10i user=root' /etc/mysql/mariadb.conf.d/50-server.cnf
cat /etc/mysql/mariadb.conf.d/50-server.cnf
service mariadb start
mysql -u root -e "CREATE DATABASE $WORDPRESS_DB_NAME;"
mysql -u root -e "CREATE USER '$MARIADB_USER_NAME'@'%' IDENTIFIED BY '$MARIADB_USER_PASSWORD';"
mysql -u root -e "GRANT ALL PRIVILEGES ON $WORDPRESS_DB_NAME.* TO '$MARIADB_USER_NAME'@'%';"
mysql -u root -e "FLUSH PRIVILEGES;"
mysql -u root -e "exit"
service mariadb stop
