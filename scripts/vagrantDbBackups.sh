#!/bin/sh

# Dump the database
mysqldump -uroot -proot mydatabase > /var/www/my-site/backups/mydatabase_latest_new.sql;

# Delete previous DB dump
if [ -e "/var/www/my-site/backups/mydatabase_previous.sql" ]; then
	rm /var/www/my-site/backups/mydatabase_previous.sql.sql;
fi

# Rename latest DB dump to previous DB dump
if [ -e "/var/www/my-site/backups/mydatabase_latest.sql" ]; then
	mv /var/www/my-site/backups/mydatabase_latest.sql /var/www/my-site/backups/mydatabase_previous.sql
fi

# Rename the new DB dump to the latest DB dump
mv /var/www/my-site/backups/mydatabase_latest_new.sql /var/www/my-site/backups/mydatabase_latest.sql
