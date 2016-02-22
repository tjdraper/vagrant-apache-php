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

# Set up XDebug if it hasn't been setup yet
if [ ! -f /var/log/xdebugsetup ];
	then
		# Install PHP5 Dev
		sudo apt-get update
		sudo apt-get -y install php5-dev

		# Add XDebug Log Directories
		mkdir /var/log/xdebug
		chown www-data:www-data /var/log/xdebug

		# Install XDebug
		sudo pecl install xdebug

		# Write XDebug config
		echo '' >> /etc/php5/apache2/php.ini
		echo ';;;;;;;;;;;;;;;;;;;;;;;;;;' >> /etc/php5/apache2/php.ini
		echo '; Added to enable Xdebug ;' >> /etc/php5/apache2/php.ini
		echo ';;;;;;;;;;;;;;;;;;;;;;;;;;' >> /etc/php5/apache2/php.ini
		echo '' >> /etc/php5/apache2/php.ini
		echo 'zend_extension="'$(find / -name 'xdebug.so' 2> /dev/null)'"' >> /etc/php5/apache2/php.ini
		echo 'xdebug.default_enable = 1' >> /etc/php5/apache2/php.ini
		echo 'xdebug.idekey = "vagrant"' >> /etc/php5/apache2/php.ini
		echo 'xdebug.remote_enable = 1' >> /etc/php5/apache2/php.ini
		echo 'xdebug.remote_autostart = 0' >> /etc/php5/apache2/php.ini
		echo 'xdebug.remote_port = 9000' >> /etc/php5/apache2/php.ini
		echo 'xdebug.remote_handler=dbgp' >> /etc/php5/apache2/php.ini
		echo 'xdebug.remote_log="/var/log/xdebug/xdebug.log"' >> /etc/php5/apache2/php.ini
		echo 'xdebug.remote_host=10.0.2.2; IDE-Environments IP, from vagrant box.' >> /etc/php5/apache2/php.ini

		# Write the file xdebugsetup so we know it's already been setup on
		# future provisioning
		echo 'xdebug setup' > /var/log/xdebugsetup
fi
