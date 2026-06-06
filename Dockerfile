# Use official PHP 8.3 FPM image
FROM php:8.3-fpm

# ----------------------------
# Step 1: System dependencies + PHP extensions
# ----------------------------
RUN apt-get update && apt-get install -y \
    git curl zip unzip libpng-dev libonig-dev libxml2-dev \
    libzip-dev libicu-dev \
    && docker-php-ext-install \
    pdo pdo_mysql mbstring exif pcntl bcmath gd intl zip \
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
# Step 5: Install dependencies (NO DB access during build)
# ----------------------------
RUN composer install --no-dev --optimize-autoloader --no-scripts

# Run Laravel safely after install
RUN php artisan package:discover || true

# ----------------------------
# Step 6: Permissions
# ----------------------------
RUN chmod -R 775 storage bootstrap/cache

# ----------------------------
# Step 7: Expose port
# ----------------------------
EXPOSE 8080

# ----------------------------
# Step 8: Start Laravel
# ----------------------------
CMD php artisan serve --host=0.0.0.0 --port=8080