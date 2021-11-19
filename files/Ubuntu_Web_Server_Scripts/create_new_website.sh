#!/bin/bash

## EXECUTE THIS SCRIP USING SUDO

## ==== VARIABLES

DAY=$(date +%u)
DATE=$(date +%Y%b%d-%T)
DATE2=$(date +%Y%m%d)
MPASS=$(head -n 1 /root/sql_mysql.txt)
WPASS=$(head -n 1 /root/sql_wordpress.txt)
DBNAMESHORT="EMPTY"
DBNAME="EMPTY"
DBUSER="EMPTY"
DBUSERPASS="EMPTY"
SQLCOMMAND1="EMPTY"
SQLCOMMAND2="EMPTY"
SQLCOMMAND3="EMPTY"
SQLCOMMAND4="FLUSH PRIVILEGES;"
RANDOM2=`openssl rand -base64 10`
# NOTE:  the openssl rand command is not running properly in bash
KEYS=$(curl -s https://api.wordpress.org/secret-key/1.1/salt/)

## ==== LOG THE EVENT STARTING TO GENERIC LOG FILE

echo ""
echo "==========================================" >> /root/Log/website_creation_$DBNAMESHORT.log
echo CREATE .CONF IN HTTPD STARTED on $DATE       >> /root/Log/website_creation_$DBNAMESHORT.log
echo "REFERENCE:  All passwords and variables are below"
# NOTE: this will log every event, not the details.

## ==== EXPLAIN SCRIPT, ENTER WEBSITE NAME, CREATE VARIABLES

echo This script will:
echo 0. Pre-execution: Will ask for paramaters
echo 1. CREATE HTTP VIRTUAL FOLDER
echo 2. CREATE APACHE CONFIG FILES
echo 3. CREATE CONF VIRTUAL FILE, TEST CONFIG
echo 4. CREATE MYSQL DATABASE AND USER
echo 5. DOWNLOAD AND INSTALL WORDPRESS
echo 6. ENABLE WEBSITE IF PERMITTED
echo 7. LOG ALL ACTIVITIES
echo ""

read -p "Do you want to run this shell? [y/n]" answer
if [[ $answer = y ]] ; then

        echo Please enter your webpage name:
        read varwebpagename1
        sleep 1

fi

# CHANGED THE DBNAMESHORT TO USE UNDERSCORE INSTAD OF PERIOD 202104181349

DBNAMESHORT=${varwebpagename1//./_}
# DBNAMESHORT=${varwebpagename1%.*}
DBNAME="${DBNAMESHORT}_${DATE2}"
DBUSER="FITS_${DBNAMESHORT}"
DBUSERPASS="${WPASS}_${varwebpagename1}_${RANDOM2}"
DBPREFIX="${DBNAMESHORT}_"

## ==== CREATE APACHE FOLDERS

mkdir /var/www/html/$varwebpagename1
mkdir /var/www/html/$varwebpagename1/log
mkdir /var/www/html/$varwebpagename1/public_html

## ==== CREATE APACHE CONFIG
# This will default to a secure site using a self signed cert
# this can be changed later to accomodate unsecure sites

echo ""
echo "Creating:  /etc/apache2/sites-available/$varwebpagename1.conf"
echo ""

echo "#### $varwebpagename1 created on $DATE ####

###############################################################
###### THE FOLLOWING COMMENTS ARE FOR NON SSL WEBSITES ########
###############################################################

<VirtualHost *:80>

	ServerName $varwebpagename1
	ServerAlias www.$varwebpagename1
	ServerAdmin noone@localhost
	DocumentRoot /var/www/html/$varwebpagename1/public_html

	ErrorLog \${APACHE_LOG_DIR}/error.log
	CustomLog \${APACHE_LOG_DIR}/access.log combined

	# RewriteEngine on
	# RewriteCond %{SERVER_NAME} =$varwebpagename1 [OR]
	# RewriteCond %{SERVER_NAME} =www.$varwebpagename1
	# RewriteRule ^ https://%{SERVER_NAME}%{REQUEST_URI} [END,NE,R=permanent]

	Redirect permanent / https://$varwebpagename1

</VirtualHost>

<Directory /var/www/html/$varwebpagename1/public_html/>
    AllowOverride All
</Directory>

###############################################################
######### THE FOLLOWING COMMENTS ARE FOR SSL WEBSITES #########
###############################################################

<IfModule mod_ssl.c>
	<VirtualHost _default_:443>

		ServerName $varwebpagename1
		ServerAlias www.$varwebpagename1
		ServerAdmin noone@localhost
		DocumentRoot /var/www/html/$varwebpagename1/public_html

		ErrorLog \${APACHE_LOG_DIR}/error.log
		CustomLog \${APACHE_LOG_DIR}/access.log combined

		SSLEngine on

		SSLCertificateFile	/etc/ssl/certs/ssl-cert-snakeoil.pem
		SSLCertificateKeyFile /etc/ssl/private/ssl-cert-snakeoil.key

		<FilesMatch \"\.(cgi|shtml|phtml|php)$\">
				SSLOptions +StdEnvVars
		</FilesMatch>
		<Directory /usr/lib/cgi-bin>
				SSLOptions +StdEnvVars
		</Directory>

	</VirtualHost>
</IfModule>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet

<Directory /var/www/html/$varwebpagename1/public_html/>
    AllowOverride All
</Directory>" > /etc/apache2/sites-available/$varwebpagename1.conf

echo ""
echo "done..."
echo ""
sleep 1

## ==== TEST CONFIGURATION

echo ""
echo "Testing new configurations..."
echo ""

apache2ctl configtest

echo "done..."
sleep 1

## ==== CREATE MYSQL DATABASE/USER

echo ""
echo "Creating SQL Commands..."
echo ""
sleep 1

SQLCOMMAND1="CREATE DATABASE $DBNAME DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;"
SQLCOMMAND2="CREATE USER '$DBUSER'@'%' IDENTIFIED WITH mysql_native_password BY '$DBUSERPASS';"
SQLCOMMAND3="GRANT ALL ON $DBNAME.* TO '$DBUSER'@'%';"

echo "EXECUTING MYSQL COMMANDS:"
echo ""
echo $SQLCOMMAND1
echo ""
echo $SQLCOMMAND2
echo ""
echo $SQLCOMMAND3
echo ""
sleep 1

echo "Applying SQL Commands..."
echo ""

sudo mysql -u root -e "$SQLCOMMAND1"
sudo mysql -u root -e "$SQLCOMMAND2"
sudo mysql -u root -e "$SQLCOMMAND3"
sudo mysql -u root -e "$SQLCOMMAND4"
sudo mysql -u root -e "show databases"

sleep 1

## ==== DOWNLOAD WORDPRESS, CREATE HTACCESS, CREATE UPGRADE FOLDER

echo "Downloading Wordpress, and adding .htaccess and directory upgrade"

curl -k https://wordpress.org/latest.zip -o /tmp/latest.zip
unzip -qq /tmp/latest.zip -d /tmp
sudo touch /tmp/wordpress/.htaccess
sudo mkdir /tmp/wordpress/upgrade

## ==== CREATE THE WP-CONFIG.PHP FILE

echo "
<?php

/**
* $varwebpagename1 CREATED ON $DATE
*/

define( 'DB_NAME', '$DBNAME' );
define( 'DB_USER', '$DBUSER' );
define( 'DB_PASSWORD', '$DBUSERPASS' );
define( 'DB_HOST', 'localhost' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );

$KEYS

\$table_prefix = '$DBPREFIX';

define( 'WP_DEBUG', false );
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

require_once ABSPATH . 'wp-settings.php';
" > /tmp/wordpress/wp-config.php

## ==== MOVE FILES OVER TO THE APACHE FOLDERS

echo ""
echo "Moving files to /var/www/html/$varwebpagename1/public_html"
echo ""

cp -a /tmp/wordpress/. /var/www/html/$varwebpagename1/public_html
rm /tmp/latest.zip
rm -r /tmp/wordpress

echo ""
echo "done..."
sleep 1

## ==== CHANGE PERMISSIONS TO APACHE FOLDERS

echo ""
echo "Changing permissions:  /var/www/html/$varwebpagename1/public_html"
echo ""

chown -R www-data:www-data /var/www/html/$varwebpagename1/public_html
find /var/www/html/$varwebpagename1/public_html -type d -exec chmod 750 {} \;
find /var/www/html/$varwebpagename1/public_html -type f -exec chmod 640 {} \;
ls -alh /var/www/html/$varwebpagename1/public_html

echo ""
echo "done..."
sleep 1

## ==== ENABLE WEBSITE

read -p "Do you want to ENABLE this website? [y/n]" answer2
if [[ $answer2 = y ]] ; then

	echo ""
	echo "Enabling website using a2ensite $varwebpagename1"
	echo "Reloading apache2:  systemctl reload apache2"
	echo ""

	a2ensite $varwebpagename1
	systemctl reload apache2

fi

echo "Script Complete..."
sleep 1

## ==== SAVE CONFIGURATIONS TO FILE

echo "DAY = $DAY"                    >> /root/Log/website_creation_$DBNAMESHORT.log
echo "DAY = $DAY"
echo "DATE = $DATE"                  >> /root/Log/website_creation_$DBNAMESHORT.log
echo "DATE = $DATE"
echo "DATE2 = $DATE2"                >> /root/Log/website_creation_$DBNAMESHORT.log
echo "DATE2 = $DATE2"
echo "MPASS = $MPASS"                >> /root/Log/website_creation_$DBNAMESHORT.log
echo "MPASS = $MPASS"
echo "WPASS = $WPASS"                >> /root/Log/website_creation_$DBNAMESHORT.log
echo "WPASS = $WPASS"
echo "DBNAMESHORT = $DBNAMESHORT"    >> /root/Log/website_creation_$DBNAMESHORT.log
echo "DBNAMESHORT = $DBNAMESHORT"
echo "DBNAME = $DBNAME"              >> /root/Log/website_creation_$DBNAMESHORT.log
echo "DBNAME = $DBNAME"
echo "DBUSER = $DBUSER"              >> /root/Log/website_creation_$DBNAMESHORT.log
echo "DBUSER = $DBUSER"
echo "DBUSERPASS = $DBUSERPASS"      >> /root/Log/website_creation_$DBNAMESHORT.log
echo "DBUSERPASS = $DBUSERPASS"
echo "SQLCOMMAND1 = $SQLCOMMAND1"    >> /root/Log/website_creation_$DBNAMESHORT.log
echo "SQLCOMMAND1 = $SQLCOMMAND1"
echo "SQLCOMMAND2 = $SQLCOMMAND2"    >> /root/Log/website_creation_$DBNAMESHORT.log
echo "SQLCOMMAND2 = $SQLCOMMAND2"
echo "SQLCOMMAND3 = $SQLCOMMAND3"    >> /root/Log/website_creation_$DBNAMESHORT.log
echo "SQLCOMMAND3 = $SQLCOMMAND3"
echo "SQLCOMMAND4 = $SQLCOMMAND4"    >> /root/Log/website_creation_$DBNAMESHORT.log
echo "SQLCOMMAND4 = $SQLCOMMAND4"
echo "KEYS = $KEYS"                  >> /root/Log/website_creation_$DBNAMESHORT.log
echo "KEYS = $KEYS"
echo "RANDOM = $RANDOM"              >> /root/Log/website_creation_$DBNAMESHORT.log
echo "RANDOM = $RANDOM"
echo "RANDOM2 = $RANDOM2"            >> /root/Log/website_creation_$DBNAMESHORT.log
echo "RANDOM2 = $RANDOM2"

## ==== DISCRIBE STEPS FOR CERTBOT

echo ""
echo "NOTE: Use the following to check your connections"
echo "      and to create a certificate for your site."
echo "1. sudo apache2ctl configtest"
echo "2. sudo systemctl reload apache2"
echo "3. sudo certbot --apache"
echo "4. sudo systemctl status certbot.timer"
echo "5. sudo certbot renew --dry-run"
echo ""
echo "NOTE:  all logs can be found in /root/Log/website_creation_$DBNAMESHORT.log"
echo ""
echo "Thank you, and goodbye!"

