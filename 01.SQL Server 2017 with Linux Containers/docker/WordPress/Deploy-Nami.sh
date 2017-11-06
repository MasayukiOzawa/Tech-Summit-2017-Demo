#!/bin/bash
# Base Script : https://github.com/ProjectNami/sandbox-installer

# Install Package
apt-get update
apt-get install -y \
nginx \
git \
unixodbc-dev \
php7.0-fpm php-pear php-dev 

# configure NGINX as non-daemon
# echo "daemon off;" >> /etc/nginx/nginx.conf

# configure php-fpm as non-daemon
# sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php/7.0/fpm/php-fpm.conf

# Create nginx Content Directory & Set permission
mkdir /usr/share/nginx/www/

# Generate nginx config
nginx_config="# Configured for use as a Project Nami sandbox
server {
        listen   80;
   
        root /usr/share/nginx/www;
        index index.php index.html index.htm;

        server_name _;

        location / {
                try_files \$uri \$uri/ /index.php;
        }

        error_page 404 /404.html;

        error_page 500 502 503 504 /50x.html;
        location = /50x.html {
              root /usr/share/nginx/www;
        }

        # pass the PHP scripts to FastCGI server listening on the php-fpm socket
        location ~ \.php$ {
                try_files \$uri =404;
                fastcgi_pass unix:/run/php/php7.0-fpm.sock;
                fastcgi_index index.php;
                fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
                include fastcgi_params;                
        }
}"

# write nginx config
printf "%s" "$nginx_config" > /etc/nginx/sites-available/default

# install project nami sandbox
cd /usr/share/nginx/www/
git clone https://github.com/ProjectNami/projectnami.git .
chown -R  www-data:www-data /usr/share/nginx/www

# Change Path
sed -i".org" -e "s/file_put_contents(/file_put_contents('\/' + "/g /usr/share/nginx/www/wp-includes/fields_map.php

# Change EnvName
sed -i".org" -e "s/ProjectNami\.//g" /usr/share/nginx/www/wp-admin/setup-config.php
echo "env[DBHost] = $DBHost" >> /etc/php/7.0/fpm/php-fpm.conf
echo "env[DBUser] = $DBUser" >> /etc/php/7.0/fpm/php-fpm.conf
echo "env[DBPass] = $DBPass" >> /etc/php/7.0/fpm/php-fpm.conf

# Install SQL Server Driver
# https://github.com/Microsoft/msphpsql/issues/81
# https://docs.microsoft.com/ja-jp/sql/connect/php/installation-tutorial-linux-mac
apt-get install -y apt-transport-https
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
apt-get update
ACCEPT_EULA=Y apt-get install -y mssql-tools msodbcsql
apt-get install -y locales
locale-gen en_US.utf8 && update-locale

pear config-set php_ini `php --ini | grep "Loaded Configuration" | sed -e "s|.*:\s*||"` system
pecl install sqlsrv 
pecl install pdo_sqlsrv

echo "extension=sqlsrv.so" >> /etc/php/7.0/fpm/php.ini
echo "extension=pdo_sqlsrv.so" >> /etc/php/7.0/fpm/php.ini

# Test PHP
echo "<?php phpinfo();" >> /usr/share/nginx/www/info.php

: <<'#COMMENT'
# Install Other Tools
apt-get install -y iputils-ping net-tools
apt-get install -y vim
#COMMENT

apt-get autoclean && apt-get -y autoremove

# service php7.0-fpm start && service nginx start
# service php7.0-fpm start && nginx -g "daemon off;"

