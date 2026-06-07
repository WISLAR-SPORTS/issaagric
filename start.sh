#!/bin/sh
set -e
echo "APP_KEY is:"
printenv APP_KEY

echo "Fixing storage permissions..."
mkdir -p storage/logs
chmod -R 775 storage

echo "Running migrations..."
php artisan migrate --force

echo "Creating storage link if missing..."
if [ ! -L public/storage ]; then
    php artisan storage:link
fi

echo "Clearing cache..."
php artisan config:clear
php artisan route:clear
php artisan view:clear
php artisan route:list
echo "Starting server..."
exec php -S 0.0.0.0:8080 -t public index.php