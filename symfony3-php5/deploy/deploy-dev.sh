#!/bin/sh
cp deploy/app-dev.php web/app.php
cp deploy/parameters-dev.yml app/config/parameters.yml
rm -rf var/cache/*
rm -fr web/bundles
php bin/console doctrine:schema:update --force
php bin/console assets:install web --symlink
