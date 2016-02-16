#!/usr/bin/env bash

# Enable SSL
cp /etc/apache2/mods-available/ssl.load /etc/apache2/mods-enabled/ssl.load
cp /etc/apache2/mods-available/ssl.conf /etc/apache2/mods-enabled/ssl.conf
cp /etc/apache2/mods-available/socache_shmcb.load /etc/apache2/mods-enabled/socache_shmcb.load

# Remove unused virtual hosts
rm -rf /etc/apache2/sites-available/*
rm -rf /etc/apache2/sites-enabled/*

# Add virtual host
cp /var/www/tcn/site.conf /etc/apache2/sites-available/site.conf
ln -s /etc/apache2/sites-available/site.conf /etc/apache2/sites-enabled/site.conf
