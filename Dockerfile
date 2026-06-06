# Use official PHP 8.3 FPM image
FROM php:8.3-fpm

# ----------------------------
# Step 1: Install system dependencies + PHP extensions
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
# Step 3: Set working directory
# ----------------------------
WORKDIR /var/www

# ----------------------------
# Step 4: Copy application files
# ----------------------------
COPY . .

# ----------------------------
# Step 5: OPTIONAL: create SQLite DB (skip if using Postgres/MySQL)
# ----------------------------
# RUN mkdir -p /var/www/database && touch /var/www/database/database.sqlite

# ----------------------------
# Step 6: Install PHP dependencies safely
# ----------------------------
# Prevent Laravel from failing during build due to DB access
RUN composer install --no-dev --optimize-autoloader --no-scripts
RUN php artisan package:discover || true

# ----------------------------
# Step 7: Fix permissions
# ----------------------------
RUN chmod -R 775 storage bootstrap/cache

# ----------------------------
# Step 8: Expose port
# ----------------------------
EXPOSE 8080

# ----------------------------
# Step 9: Run Laravel development server
# ----------------------------
CMD php artisan serve --host=0.0.0.0 --port=8080