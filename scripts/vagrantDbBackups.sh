#!/bin/sh

# Dump the database
mysqldump -uroot -proot site > /vagrant/backups/site_latest_new.sql;

# Delete previous DB dump
if [ -e "/vagrant/backups/site_previous.sql" ]; then
	rm /vagrant/backups/site_previous.sql;
fi

# Rename latest DB dump to previous DB dump
if [ -e "/vagrant/backups/site_latest.sql" ]; then
	mv /vagrant/backups/site_latest.sql /var/www/development/backups/site_previous.sql
fi

# Rename the new DB dump to the latest DB dump
mv /vagrant/backups/site_latest_new.sql /vagrant/backups/site_latest.sql
