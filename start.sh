#!/bin/sh

echo "Waiting for postgres..."
while ! nc -z $POSTGRES_HOST $POSTGRES_PORT; do
  sleep 0.1
done
echo "PostgreSQL started"

#python manage.py flush --no-input
python manage.py migrate

gunicorn mysite.wsgi:application --bind 0.0.0.0:8000

exec "$@"