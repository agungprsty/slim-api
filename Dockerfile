FROM php:8.1-alpine

# Copy composer.lock and composer.json
COPY ./slim/composer.lock ./slim/composer.json /var/www/html/

# Copy from image composer to local container
COPY --from=composer:2.3 /usr/bin/composer /usr/local/bin/composer

# Install Depedencies
RUN apk update && apk add git libxml2-dev zip
RUN docker-php-ext-install pdo pdo_mysql mysqli ctype fileinfo xml bcmath sockets

# Set working directory
WORKDIR /var/www/html

# Add user for laravel application
RUN addgroup -S www && adduser -S www -G www

# Copy existing application directory contents
COPY ./slim /var/www/html

# Copy existing application directory permissions
COPY --chown=www:www ./slim /var/www/html

# Change current user to www
USER www

# Run application
COPY ./run.sh /tmp

# Execute run.sh
ENTRYPOINT ["/tmp/run.sh"]

EXPOSE 8080