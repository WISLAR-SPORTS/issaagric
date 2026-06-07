# Use official PHP 8.3 FPM image
FROM php:8.3-fpm

# ----------------------------
# Step 1: System dependencies + PHP extensions
# ----------------------------
RUN apt-get update && apt-get install -y \
    git curl zip unzip libpng-dev libonig-dev libxml2-dev \
    libzip-dev libicu-dev libpq-dev \
    && docker-php-ext-install \
       pdo pdo_mysql pdo_pgsql pgsql mbstring exif pcntl bcmath gd intl zip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# ----------------------------
# Step 2: Install Composer
# ----------------------------
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# ----------------------------
# Step 3: Working directory
# ----------------------------
WORKDIR /var/www

# ----------------------------
# Step 4: Copy project files
# ----------------------------
COPY . .

# ----------------------------
# Step 5: Ensure required Laravel directories exist
# ----------------------------
RUN mkdir -p storage/framework/{cache,sessions,views} bootstrap/cache

# ----------------------------
# Step 6: Install dependencies
# ----------------------------
RUN composer install --no-dev --optimize-autoloader --no-scripts

# Run Laravel safely after install


# ----------------------------
# Step 7: Permissions
# ----------------------------
RUN chown -R www-data:www-data storage bootstrap/cache \
    && chmod -R 775 storage bootstrap/cache

# ----------------------------
# Step 8: Expose port
# ----------------------------
EXPOSE 8080

# ----------------------------
# Step 9: Make startup script executable
# ----------------------------
RUN chmod +x start.sh

# ----------------------------
# Step 10: Start app via script
# ----------------------------
CMD ["./start.sh"]