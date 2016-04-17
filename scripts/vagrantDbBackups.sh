#!/bin/sh

# Dump the database
mysqldump -uroot -proot site > /var/www/development/backups/site_latest_new.sql;

# Delete previous DB dump
if [ -e "/var/www/development/backups/site_previous.sql" ]; then
	rm /var/www/development/backups/site_previous.sql;
fi

# Rename latest DB dump to previous DB dump
if [ -e "/var/www/development/backups/site_latest.sql" ]; then
	mv /var/www/development/backups/site_latest.sql /var/www/development/backups/site_previous.sql
fi

# Rename the new DB dump to the latest DB dump
mv /var/www/development/backups/site_latest_new.sql /var/www/development/backups/site_latest.sql
