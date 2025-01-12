# Use the official WordPress image as the base
FROM wordpress:latest

# Set environment variables for WordPress database connection
ENV WORDPRESS_DB_HOST=db
ENV WORDPRESS_DB_USER=wordpress
ENV WORDPRESS_DB_PASSWORD=wordpress
ENV WORDPRESS_DB_NAME=wordpress

# Set the working directory
WORKDIR /var/www/html

# Copy custom WordPress content (themes, plugins, uploads)
# Ensure wp-content exists in your project directory
COPY wp-content /var/www/html/wp-content

# Set correct permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Copy wp-config.php into the container
COPY wp-config.php /var/www/html/wp-config.php

# Install additional PHP extensions if needed
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Expose WordPress default port
EXPOSE 80

# Start Apache server
CMD ["apache2-foreground"]

