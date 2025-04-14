FROM php:7.2-apache

RUN apt-get update && apt-get install -y
RUN docker-php-ext-install pdo pdo_mysql
RUN a2enmod rewrite

RUN echo '<Directory /var/www/>\n\
    AllowOverride All\n\
    Require all granted\n\
    RedirectMatch ^/$ /TreasureHunt/index.php\n\
</Directory>\n\
\n\
<Directory "/var/www/html/TreasureHunt">\n\
    AllowOverride All\n\
    Require all granted\n\
    ErrorDocument 404 /TreasureHunt/404.php\n\
    ErrorDocument 403 /TreasureHunt/403.php\n\
</Directory>' >> /etc/apache2/apache2.conf
