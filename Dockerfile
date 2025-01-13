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

# Copy wp-config.php into the container
# Ensure wp-config.php exists in your project directory
COPY wp-config.php /var/www/html/wp-config.php

# Set permissions for WordPress files
RUN chown -R www-data:www-data /var/www/html/wp-content && \
    chmod -R 755 /var/www/html/wp-content && \
    chown www-data:www-data /var/www/html/wp-config.php && \
    chmod 644 /var/www/html/wp-config.php

# Install additional PHP extensions if needed
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Expose WordPress default port
EXPOSE 80

# Start Apache server
CMD ["apache2-foreground"]
