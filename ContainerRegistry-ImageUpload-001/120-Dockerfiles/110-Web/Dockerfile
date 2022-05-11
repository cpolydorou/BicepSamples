# Start with a precompiled image
FROM php:7.4.3-apache

# Install the necessary externsions
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Download the web site code
COPY ./html/index.php /var/www/html