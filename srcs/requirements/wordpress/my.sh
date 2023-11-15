#!/bin/bash

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar  
chown -R www-data:www-data /var/www/html/
chmod -R 755 /var/www/html/ 
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

mkdir -p /run/php/
cd /var/www/html/

wp core download --allow-root
touch wp-config.php
cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

sed -i '36 s/\/run\/php\/php8.2-fpm.sock/9000/' /etc/php/8.2/fpm/pool.d/www.conf

# Set The Database that will be connected with wordpress
sed -i 's/database_name_here/'$WORDPRESS_DB_NAME'/g' /var/www/html/wp-config.php

# Set the Username of The database
sed -i 's/username_here/'$MARIADB_USER_NAME'/g' /var/www/html/wp-config.php

# Set the Password
sed -i 's/password_here/'$MARIADB_USER_PASSWORD'/g' /var/www/html/wp-config.php

# set The Hostname of the That database
sed -i 's/localhost/'$HOST'/g' /var/www/html/wp-config.php

wp config set FORCE_SSL_ADMIN 'false' --allow-root

# instal the wordpress
wp core install --url=$DOMAIN_NAME --title="My Wordpress Site" --admin_user=$ADMIN_USER --admin_password=$ADMIN_PASSWORD --admin_email=$ADMIN_EMAIL --allow-root

exec "$@"