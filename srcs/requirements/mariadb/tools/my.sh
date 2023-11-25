#!/bin/bash
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

if [ ! -d "/var/lib/mysql/$WORDPRESS_DB_NAME" ]; then
    mariadb-install-db --user="mysql" --datadir="/var/lib/mysql"

    mariadbd --user=mysql --bootstrap << END
	    FLUSH PRIVILEGES;

	    ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ROOTPASSWORD';

	    CREATE DATABASE IF NOT EXISTS $WORDPRESS_DB_NAME;

	    CREATE USER IF NOT EXISTS'$MARIADB_USER_NAME'@'%' IDENTIFIED BY '$MARIADB_USER_PASSWORD';

	    GRANT ALL PRIVILEGES ON $WORDPRESS_DB_NAME.* TO '$MARIADB_USER_NAME'@'%';

	    -- FLUSH PRIVILEGES;
END
fi

mariadbd-safe --datadir='/var/lib/mysql'
