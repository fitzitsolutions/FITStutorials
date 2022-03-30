# DAMN VULNERABLE WEB APP INSTALLATION

## WEBSITE TO DOWNLOAD

<br>

https://dvwa.co.uk/ <br>
Download the zip file...

<br><hr><br>

## INSTRUCTIONS

<br>

Put unzipped files in the html directory

<br><hr><br>

## CHANGE PERMISSIONS TO APACHE FOLDER

<br>

```
sudo chown -R www-data:www-data /var/www/html
sudo find /var/www/html -type d -exec chmod 750 {} \;
sudo find /var/www/html -type f -exec chmod 640 {} \;
sudo ls -alh /var/www/html
```

<br><hr><br>

## INSTALL REQUIRED APPLICATIONS

<br>

```
sudo apt install php php-cli php-fpm php-json php-common php-mysql php-zip php-gd php-mbstring php-curl php-xml php-pear php-bcmath php-curl php-json php-cgi php-mysql
sudo apt-get -y install apache2 mariadb-server php php-mysqli php-gd libapache2-mod-php
sudo apt instlal vim
sudo apt install mlocate
```

<br><hr><br>

## CONFIGURE MYSQL

<br>

```
sudo mysql_secure_installation
mysql -u root -p
CREATE USER 'dvwa'@'127.0.0.1' IDENTIFIED BY 'tpzpassword';
GRANT ALL on dvwa.* TO 'dvwa' IDENTIFIED BY 'tpzpassword';
flush privileges;
```

<br><hr><br>

## CREATE THE CONFIGURATION FILE FOR DVWA

<br>

in /var/www/html/dvwa/

<br>

```
cp config.inc.php.dist config.inc.php
```

<br><hr><br>

## CONFIGURE PHP FOR DVWA

<br>

```
sudo vim /etc/php/7.4/apache2/php.ini
```

<br>

Add the following to the bottom...

```
allow_url_include=On
$_DVWA[ 'recaptcha_public_key' ]  = '6LdK7xITAAzzAAJQTfL7fu6I-0aPl8KHHieAT_yJg';
$_DVWA[ 'recaptcha_private_key' ] = '6LdK7xITAzzAAL_uw9YXVUOPoIHPZLfw2K1n5NVQ';
```

<br><hr><br>

## GO TO DVWA AND COMPLETE SETUP TO LOGIN

go to the ip/dvwa/setup.php to begin...
should see all greens...

<br><hr><br>

## DEFAULT USER/PASS

```
admin:password
```