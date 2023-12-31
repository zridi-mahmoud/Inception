#!/bin/bash

if [ ! -f /var/www/html/wp-config.php ]; then
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

    sed -i 's/\/run\/php\/php7.4-fpm.sock/9000/' /etc/php/7.4/fpm/pool.d/www.conf

    sed -i 's/database_name_here/'$WORDPRESS_DB_NAME'/g' /var/www/html/wp-config.php

    sed -i 's/username_here/'$MARIADB_USER_NAME'/g' /var/www/html/wp-config.php

    sed -i 's/password_here/'$MARIADB_USER_PASSWORD'/g' /var/www/html/wp-config.php

    sed -i 's/localhost/'$HOST'/g' /var/www/html/wp-config.php
                    
    wp config set FORCE_SSL_ADMIN 'false' --allow-root


    wp core install --url=$DOMAIN_NAME --title="My Wordpress Site" --admin_user=$ADMIN_USER --admin_password=$ADMIN_PASSWORD --admin_email=$ADMIN_EMAIL --allow-root

    wp user create $WP_USER $USER_EMAIL --user_pass=$USER_PASSWORD --role='author' --allow-root
fi

exec "$@"
   