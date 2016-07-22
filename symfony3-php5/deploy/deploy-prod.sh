#!/bin/sh
cp deploy/app-prod.php web/app.php
rm -rf var/cache/*
rm -fr web/bundles
php bin/console doctrine:schema:update --force --env=prod --no-debug
php bin/console assets:install web --env=prod --no-debug
rm -rf var/cache/*
php bin/console cache:warmup --env=prod --no-debug
