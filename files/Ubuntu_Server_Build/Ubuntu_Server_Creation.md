# UBUNTU 20.04 / 22.04 BUILD

## QUICK REFERENCE
<pre>
apt-get update && apt-get upgrade
hostnamectl set-hostname example-hostname
dpkg-reconfigure tzdata
adduser example_user
usermod -aG sudo example_user
sudo ufw enable
sudo ufw logging on
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo apt-get install openssh-server apache2 mysql-server curl unzip vim

sudo mysql_secure_installation

NOTE: the following command installs the latest PHP.  See below to install older versions
sudo apt install php-{cli,common,curl,zip,gd,mysql,xml,mbstring,json,intl}

sudo apt install php libapache2-mod-php
        
EDIT FILE: /etc/apache2/apache2.conf
KeepAlive On
MaxKeepAliveRequests 50
KeepAliveTimeout 5

EDIT FILE: /etc/apache2/mods-available/mpm_prefork.conf
&ltIfModule mpm_prefork_module>
        StartServers            4
        MinSpareServers         3
        MaxSpareServers         40
        MaxRequestWorkers       200
        MaxConnectionsPerChild  10000
&lt/IfModule>

EDIT FILE: /etc/php/version/apache2/php.ini
upload_max_filesize = 200M
post_max_size = 200M
memory_limit = 500M
max_execution_time = 600
max_input_vars = 1000
max_input_time = 400

NOTE: enable Apache2 mods for wordpress if needed
sudo a2enmod ssl
sudo a2enmod headers
sudo a2enmod rewrite [this is for permalinks]
sudo a2dismod mpm_event [swapped for mpm_prefork]
sudo a2enmod mpm_prefork [enabled to replace mpm_event]
</pre>

<hr>

## STEPS AMPLIFIED WITH ADDITIONS FOR WEBSITES AND EMAILS

## ALL SERVERS [common configurations]

### UPDATE SERVER [UPDATE]
<pre>
apt-get update && apt-get upgrade 
</pre>
<br>

### HOSTNAME UPDATE [HOSTNAME]
<pre>
hostnamectl set-hostname example-hostname
NOTE:  (optional) do not use a subnet 
</pre>
<br>

### UPDATE HOSTS FILE [/etc/hosts]
<pre>
110.10.10.110 example-hostname.example.com example-hostname
2600:ipv6::a123:ipv6:ipv6:ipv6 example-hostname.example.com example-hostname
</pre>
<br>

### UPDATE LOCAL TIME ON SERVER [TIMEZONE]
<pre>
dpkg-reconfigure tzdata
date 
</pre>
<br>

### ADD A NEW USER [USER]
<pre>
adduser example_user
usermod -aG sudo example_user
</pre>
<br>

### CHANGE SSH PORT AND OPTIONS [SSH]
<pre>
[install ssh] sudo apt-get install openssh-server
/etc/ssh/sshd_config
PermitRootLogin no
PasswordAuthentication no
AddressFamily inet [LISTEN ON IPV4 ONLY]
# Port 22 [CHANGE PORT]
sudo systemctl restart sshd
</pre>
<br>

### REMOVE EXTRA RUNNING SERVERS IF NEEDED [SERVICES]
<pre>
sudo ss -atpu [SEE SERVICES RUNNING]
sudo apt purge package_name [REMOVE A SERVICE]
</pre>
<br>

### HIGHLY RECOMMEND CHANGING MYSQL BIN LOGGING SETTING
This is to ensure your log files don't fill up your hard drive.<br>
The transaction logs can and will stop your server from working... <br>

<pre>
SET BIN LOG EXPIRATION - METHOD 1
mysql> SET GLOBAL binlog_expire_logs_seconds = 259200;

TURN OFF BIN LOGGING (DO NOT DO THIS IF USING REPLICATION) - METHOD 2
Add this to the /etc/mysql/my.cnf

[mysqld]
disable_log_bin

YOU CAN ALSO PURGE THE LOGS PERIODICALLY
mysql> show binary logs;
mysql> PURGE BINARY LOGS BEFORE '2022-05-25 01:01:01';
mysql> show binary logs;
</pre>

<br>


<br>

<hr>

## THIS IS THE END OF THE COMMON CONFIGURATIONS
### THE NEXT SECTION IS FOR WEB SERVERS

<hr>
<br>
<br>

## WEB BUILD [WEB]

### [FIREWALL]
<pre>
sudo ufw status [UBUNTU FIREWALL]
sudo ufw enable
sudo ufw logging on
sudo ufw allow 22 [OR]
sudo ufw allow ssh
sudo ufw allow 80/tcp [OR]
sudo ufw allow http
sudo ufw allow from 198.51.100.0
sudo ufw allow from 198.51.100.0/24
sudo ufw allow from 198.51.100.0 to any port 22 proto tcp
sudo ufw delete allow 80
/etc/ufw/before.rules [RULES RUN BEFORE THE OTHERS]
/etc/ufw/before6.rules [RULES RUN BEFORE THE OTHERS]
/etc/ufw/after.rules [RULES RUN AFTER THE OTHERS]
/etc/ufw/after6.rules [RULES RUN AFTER THE OTHERS]
</pre>
<br>

### COMMON INSTALLS [INSTALLS]
<pre>
Sudo apt-get install curl
Sudo apt-get install unzip
</pre>
<br>

### [FAIL2BAN - OPTIONAL]
<pre>
apt-get install fail2ban
apt-get install sendmail
ufw allow ssh
ufw enable
</pre>
<br>

#### RESOURCE:
[Linode Tutorial](https://www.linode.com/docs/guides/using-fail2ban-to-secure-your-server-a-tutorial/) - secure your server
<br>
<br>

### APACHE / MYSQL INSTALLATION
#### LAMP STACK - QUICK - Linux, Apache, MySQL, PHP [LAMP]
<pre>
sudo apt install tasksel
sudo tasksel install lamp-server
</pre>
#### OPTIONAL - manual installation
<pre>
sudo apt install apache2
sudo a2enmod ssl
sudo a2enmod headers
sudo a2enmod rewrite [this is for permalinks]
sudo apt install php php-cli php-fpm php-json php-common php-mysql php-zip php-gd php-mbstring php-curl php-xml php-pear php-bcmath php-curl php-json php-cgi php-mysql
sudo apt install mysql-server
</pre>
#### OPTIONAL - MYSQL ROOT USER PASSWORD CHANGE [MYSQL]
<pre>
sudo mysql -- ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password by 'mynewpassword';
</pre>
#### OPTIONAL - SECURE MYSQL INSTALLATION - RECOMMENDED [MYSQL]
<pre>
sudo mysql_secure_installation
</pre>
<br>

### APACHE CONFIGURATIONS 
#### EDIT FILE: /etc/apache2/apache2.conf [APACHE]
<pre>
KeepAlive On
MaxKeepAliveRequests 50
KeepAliveTimeout 5
</pre>
<br>

#### EXIT FILE: /etc/apache2/mods-available/mpm_prefork.conf [APACHE]
<pre>
&ltIfModule mpm_prefork_module>
        StartServers            4
        MinSpareServers         3
        MaxSpareServers         40
        MaxRequestWorkers       200
        MaxConnectionsPerChild  10000
&lt/IfModule>
</pre>
<br>

#### APACHE FIREWALL AND MODULE ADDITIONS [APACHE]
<pre>
sudo ufw app info "Apache Full"
sudo ufw allow in "Apache Full"
sudo a2dismod mpm_event [already disabled]
sudo a2enmod mpm_prefork [already enabled]
sudo systemctl restart apache2
</pre>
<br>

### PHP 

#### INSTALL OLDER PHP VERSIONS [PHP WORDPRESS COMPATIBILITY]
<pre>
sudo apt update && sudo apt upgrade
sudo apt install software-properties-common
sudo add-apt-repository ppa:ondrej/php -y
sudo apt install php7.4
sudo apt install php7.4-{cli,common,curl,zip,gd,mysql,xml,mbstring,json,intl,fpm,bcmath,cgi}
</pre>
NOTE: Need to make sure 7.4 is the default if multiple versions are installed
<pre>
sudo update-alternatives --config php
</pre>
NOTE: you can un-install 7.4 using these commands:
<pre>
sudo apt autoremove --purge php7.4
sudo add-apt-repository --remove ppa:ondrej/php -y
</pre>

#### EDIT FILE: /etc/php/version/apache2/php.ini [PHP]
<pre>
upload_max_filesize = 200M
post_max_size = 200M
memory_limit = 500M
max_execution_time = 600
max_input_vars = 1000
max_input_time = 400
</pre>
<br>

### WEBSITE
#### CREATE A WEBSITE [WEBSITE]
<pre>
sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/example.com.conf
</pre>
<br>

#### INSERT INTO FILE FOR YOUR WEBSITE [WEBSITE]
<pre>
&ltDirectory /var/www/html/example.com/public_html>
        Require all granted
&lt/Directory>
&ltVirtualHost *:80>
        ServerName example.com
        ServerAlias www.example.com
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html/example.com/public_html

        ErrorLog /var/www/html/example.com/logs/error.log
        CustomLog /var/www/html/example.com/logs/access.log combined

&lt/VirtualHost>
</pre>
<br>

#### CREATE WEB DIRECTORIES [APACHE]
<pre>
sudo mkdir -p /var/www/html/example.com/{public_html,logs}
sudo chown -R www-data:www-data /var/www/html/example.com/public_html
sudo chmod -R 755 /var/www/html/example.com/public_html
</pre>
<br>

#### ENABLE WEBSITE [APACHE]
<pre>
sudo a2ensite example.com
</pre>
<br>

#### OPTIONAL: DISABLE DEFAULT SITE [APACHE]
<pre>
sudo a2dissite 000-default.conf
</pre>
<br>

#### RESTART APACHE [APACHE]
<pre>
sudo systemctl reload apache2
</pre>
<br>

#### CONFIGURE MARIADB [MYSQL]
<pre>
sudo mysql_secure_installation
</pre>
<br>

#### [OPTIONAL] AUTOMATIC WORDPRESS WEBSITE CREATION
<pre>
sudo mkdir /root/Log
wget https://raw.githubusercontent.com/fitzitsolutions/FITStutorials/main/files/Ubuntu_Web_Server_Scripts/create_new_website.sh
chmod +x create_new_website.sh
sudo ./create_new_website.sh
wget https://raw.githubusercontent.com/fitzitsolutions/FITStutorials/main/files/Ubuntu_Web_Server_Scripts/changeperms.sh
sudo ./changeperms.sh <your new website>
</pre>
<br>

<hr>

## OPTIONAL: PLAY AROUND WITH PHP AND MYSQL

#### CREATE A DATBASE [MYSQL]
<pre>
sudo mysql -u root
CREATE DATABASE webdata;
GRANT ALL ON webdata.* TO 'webuser' IDENTIFIED BY 'password';
CREATE USER 'user'@'localhost' IDENTIFIED BY 'password';
GRANT ALL ON *.* TO 'user'@'localhost';
</pre>
<br>

#### CREATE PHP CONFIGURATION FILE [PHP]
<pre>
vim /etc/php/7.2/apache2/php.ini
</pre>
<br>
<pre>
error_reporting = E_COMPILE_ERROR | E_RECOVERABLE_ERROR | E_ERROR | E_CORE_ERRORi
max_input_time = 30
error_log = /var/log/php/error.log
</pre>
<br>

#### CREATE PHP LOGS AND RESTART APACHE [PHP]
<pre>
sudo mkdir /var/log/php
sudo chown www-data /var/log/php
sudo systemctl restart apache2
</pre>
<br>

#### CREATE A TEST WEBPAGE FOR PHP [PHP]
```
vim /var/www/html/example.com/public_html/phptest.php
```
<br>

```

<html>
<head>
    <title>PHP Test</title>
</head>
    <body>
    <?php echo '<p>Hello World</p>';

    // In the variables section below, replace user and password with your own MySQL credentials as created on your server
    $servername = "localhost";
    $username = "webuser";
    $password = "password";

    // Create MySQL connection
    $conn = mysqli_connect($servername, $username, $password);

    // Check connection - if it fails, output will include the error message
    if (!$conn) {
        die('<p>Connection failed: </p>' . mysqli_connect_error());
    }
    echo '<p>Connected successfully</p>';
    ?>
</body>
</html>

```

#### CHECK THE STATUS OF APACHE [APACHE]
<pre>
sudo systemctl status apache2
</pre>
<br>


## [end of web build]

<br>
<br>

<hr>

## THIS IS THE END OF THE WEB BUILD
### THE NEXT SECTION IS FOR EMAIL SERVERS

<hr>
<br>
<br>

## EMAIL SERVER BUILD [EMAIL]
<br>

#### BUILD THE DNS RECORDS [DNS]
<pre>
A record - IP address
A record - mail. IP address
AAAA record - IP address
AAAA record - mail. IP address
MX record - @ to URL
MX record - mail. to URL
TXT record - DKIM entry
Dkim._domainkey and add the encryption 
TXT record - v=spf1 entry
v=spf1 mx mx:ssite.com ip4:110.10.10.110 ptr:site.com include:site.com ~all\009
TXT record - google site validation
Add to the Webmaster Tools dashboard and find the entry
CNAME record - WWW to URL
</pre>
<br>

#### INSTALL GZIP [EMAIL]
<pre>
sudo apt-get install gzip
</pre>
<br>

#### DOWNLOAD LATEST IREDMAIL INSTALLER [EMAIL]
<pre>
su root
mkdir /root/iredmail
cd /root/iredmail
# upload the iRedMail-x.y.z.tar.gz to this folder
tar zxf iRedMail…
cd /root/iredmail/iRedMail…
bash iRedMail.sh
# the GUI will guide you through the installation
</pre>
<br>

#### INSTALL SSL CERTIFICATES [EMAIL]
Obtain a Let’s Encrypt cert for free
<br>
https://certbot.eff.org/lets-encrypt/ubuntufocal-apache
<br>
Install the cert to all of the mail services
<br>
https://docs.iredmail.org/letsencrypt.html
<br>
<pre>
mv /etc/ssl/certs/iRedMail.crt{,.bak}       # Backup. Rename iRedMail.crt to iRedMail.crt.bak
mv /etc/ssl/private/iRedMail.key{,.bak}     # Backup. Rename iRedMail.key to iRedMail.key.bak
ln -s /etc/letsencrypt/live/mail.mydomain.com/fullchain.pem /etc/ssl/certs/iRedMail.crt
ln -s /etc/letsencrypt/live/mail.mydomain.com/privkey.pem /etc/ssl/private/iRedMail.key
</pre>
<br>

### IF NEEDED, TRANSFER ALL EMAIL ACCOUNTS FROM OLD SERVER [EMAIL]

[end email build]
