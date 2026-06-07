#!/bin/sh

echo "Running migrations..."
php artisan migrate --force

echo "Starting PHP built-in server..."
php -S 0.0.0.0:8080 -t public