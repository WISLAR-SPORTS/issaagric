#!/bin/sh
echo "Running migrations..."
php artisan migrate --force

echo "Clearing cache..."
php artisan config:clear
php artisan route:clear
php artisan view:clear

echo "Starting server..."
php -S 0.0.0.0:8080 -t public