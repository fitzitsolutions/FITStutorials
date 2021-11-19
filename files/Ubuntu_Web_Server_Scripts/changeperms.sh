#!/bin/bash

echo "USAGE:" 
echo "1. ensure execution permissions on this shell script"
echo "2. type: ./changeperms.sh <website>"
echo "This script will:"
echo "CHANGE PERMISSIONS TO /var/www/html/$1/public_html"
echo ""

read -p "Do you want to run this shell? [y/n]" answer
if [[ $answer = y ]] ; then

echo "Changing permissions to $1"
echo ""

chown -R www-data:www-data /var/www/html/$1/public_html
find /var/www/html/$1/public_html -type d -exec chmod 750 {} \;
find /var/www/html/$1/public_html -type f -exec chmod 640 {} \;
ls -alh /var/www/html/$1/public_html/wp-content

echo "done..."

fi
