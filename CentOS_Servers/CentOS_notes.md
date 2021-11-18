# CENTOS 7 WEBPAGE AND EMAIL SERVER INSTALLS

## This reference is old... but still useful for CentOS
<hr>
<br>

### THE FLOW
- get the server ready with updates
- setup the hostname and fiirewall
- install required programs
- install a cert for SSL connections
- setup a webpage or create an email server
<hr>
<br>

### This can be done on all servers [both web and email]
<pre>
adduser
passwd
visudo
Yum update
selinux
sudo hostnamectl set-hostname
sudo vim /etc/ssh/sshd_config
firewall-cmd ports
reboot
</pre>
<hr>
<br>

### MariaDB Install [mySQL]
<pre>
dnf install mariadb mariadb-server
	systemctl start mariadb
	systemctl enable mariadb
	mysql_secure_installation
	mysql -u root -p
</pre>
<hr>
<br>

### Apache Install [APACHE]
<pre>
dnf install httpd mod_ssl
	systemctl start httpd
	systemctl enable httpd 
</pre>
<hr>
<br>

### PHP Install [PHP]
<pre>
dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
	dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm
	dnf module list php
	dnf module enable php:remi-7.4
	dnf install php php-cli php-common php-mysqlnd php-mcrypt php-gd php-uopz php-intl 
</pre>
<hr>
<br>

### Certbot Install [CERTBOT]
<pre>
dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm
dnf install certbot
	dnf install python3-certbot-apache
    certbot --apache -d url.com -d www.url.com  
</pre>
<hr>
<br>

### Install Email Server [IREDMAIL]
<pre>
sudo yum install wget tar epel-release 
wget iRedMail
wget iRedAdmin

[IREDMAIL CERTBOT]
yum -y install yum-utils
yum-config-manager --enable rhui-REGION-rhel-server-extras rhui-REGION-rhel-server-optional
sudo yum install certbot python2-certbot-nginx
</pre>
<hr>
<br>

¯\_(ツ)_/¯
## ALL OF THE REST OF THIS ARE REALLY OLD NOTES
	
[MYSQL COMMANDS FOR CREATING A DATBASE]
<pre>
mysql -u root -p
create database database_date;
GRANT ALL PRIVILEGES ON database_date20210115.* TO "user"@"localhost" IDENTIFIED BY "@password";
flush privileges;
</pre>
<hr>
<br>

### ALL SERVER INITIAL INSTALLS:
<pre>
	sudo yum -y install screen vim firewalld net-tools wget unzip epel-release bzip2 unzip
	sudo yum -y install nginx python2-certbot-nginx
	sudo yum -y install php-fpm php-common php-mbstring php-xmlrpc php-soap php-gd php-xml php-intl php-mysql php-cli php-mcrypt php-ldap php-zip php-curl
	# ALL OF THEM -- sudo yum -y install screen vim firewalld net-tools wget unzip bzip2 epel-release mariadb mariadb-server yum-utils nginx python2-certbot-nginx php-fpm php-common php-mbstring php-xmlrpc php-soap php-gd php-xml php-intl php-mysql php-cli php-mcrypt php-ldap php-zip php-curl
</pre>
<hr>
<br>

### OLD REPO INSTALLS FOR CENTOS
create repo
<pre>
	sudo vim /etc/yum.repos.d/unit.repo
	add this to file:
		[unit]
		name=unit repo
		baseurl=https://packages.nginx.org/unit/centos/$releasever/$basearch/
		gpgcheck=0
		enabled=1
	sudo yum install unit
	sudo yum install unit-php unit-python unit-go unit-perl unit-devel
</pre>
<hr>
<br>

### SELINUX DISABLE:
<pre>
	sudo vim /etc/selinux/config
	<change to disabled>
</pre>
<hr>
<br>

### FIREWALLD:
<pre>
	sudo service firewalld start
	sudo firewall-cmd --zone=public --permanent --add-port=80/tcp
	sudo firewall-cmd --zone=public --permanent --add-port=443/tcp
	sudo firewall-cmd --zone=public --permanent --add-port=10867/tcp
	sudo firewall-cmd --reload
	sudo systemctl enable firewalld
	sudo firewall-cmd --list-all
</pre>
<hr>
<br>

### SSHD PORT CHANGE:
<pre>
	sudo vim sshd_config 
	[change to different port]
	sudo service sshd restart
	[from client terminal:]
	ssh-copy-id -p<port> user@ipaddress
</pre>
<hr>
<br>

### MYSQLD (MARIADB):
<pre>
	sudo yum -y install mariadb mariadb-server
	sudo systemctl start mariadb
	sudo systemctl enable mariadb
	sudo mysql_secure_installation
	mysql -u root -p
</pre>
<hr>
<br>

### WEBPAGE INSTALLS:
#### APACHE -
<pre>
   		sudo yum -y install httpd mod_ssl python-certbot-apache
   		sudo systemctl start httpd
   		sudo systemctl enable httpd
</pre>	
#### NGINX - 
<pre>
   		sudo yum -Y install nginx python2-certbot-nginx
   		sudo apt install php-fpm php-common php-mbstring php-xmlrpc php-soap php-gd php-xml php-intl php-mysql php-cli php-mcrypt php-ldap php-zip php-curl
		sudo systemctl start nginx
		sudo systemctl enable nginx
</pre>
<hr>
<br>

### PHP 7.1:
<pre>
	sudo rpm -Uvh http://rpms.remirepo.net/enterprise/remi-release-7.rpm
	sudo yum -y install yum-utils
	sudo yum -y update
	sudo yum-config-manager --enable remi-php71
	sudo yum -y install php php71-php php-mbstring php-zip php71-php-opcache php71-php-mysql php71-php-pecl-imagick php71-php-intl php71-php-mcrypt php71-php-pdo php-ZendFramework-Db-Adapter-Pdo-Mysql php71-php-pecl-zip php71-php-mbstring php71-php-gd php71-php-xml
</pre>
<hr>
<br>

### PHP 7.2:
<pre>
	sudo yum-config-manager --enable remi-php72
	sudo yum -y install php php-opcache
	sudo systemctl restart httpd.service
</pre>
<hr>
<br>

### PHP 7.4 DEPENDENCIES (sudo def install php74)
<pre> 
 checkpolicy                      x86_64     2.9-1.el8                              baseos        348 k
 environment-modules              x86_64     4.5.2-1.el8                            baseos        421 k
 php74-php-cli                    x86_64     7.4.15-1.el8.remi                      remi-safe     3.1 M
 php74-php-common                 x86_64     7.4.15-1.el8.remi                      remi-safe     704 k
 php74-php-json                   x86_64     7.4.15-1.el8.remi                      remi-safe      80 k
 php74-runtime                    x86_64     1.0-3.el8.remi                         remi-safe     1.1 M
 policycoreutils-python-utils     noarch     2.9-9.el8                              baseos        251 k
 python3-audit                    x86_64     3.0-0.17.20191104git1c2f876.el8        baseos         86 k
 python3-libsemanage              x86_64     2.9-3.el8                              baseos        127 k
 python3-policycoreutils          noarch     2.9-9.el8                              baseos        2.2 M
 python3-setools                  x86_64     4.3.0-2.el8                            baseos        626 k
 scl-utils                        x86_64     1:2.0.2-12.el8                         appstream      47 k
 tcl
</pre>
<hr>
<br>

### PHP 7.4 INSTALL
<pre>
sudo dnf module list php
sudo dnf install dnf-utils http://rpms.remirepo.net/enterprise/remi-release-8.rpm
sudo dnf module reset php
sudo dnf module enable php:remi-7.4
sudo dnf install php74 
sudo def install php74-php-pecl-mcrypt php74-php-mbstring php74-libzip php74-php-pecl-mysql php74-php-intl php74-php-pecl-uopz php74-php-gd php74-php-xml
</pre>
<hr>
<br>

### OLD PHP INSTALLS AND CHECKS
<pre>
sudo dnf module list php
	sudo dnf module list php
	sudo dnf module reset phpc
	sudo dnf module enable php:remi-7.4
	dnf install php php-cli php-common 
	
sudo dnf install php74 php74-php-pecl-mcrypt php74-php-mbstring php74-libzip php74-php-pecl-mysql php74-php-intl php74-php-pecl-uopz php74-php-gd php74-php-xml

dnf install  php-fpm php-json
</pre>
<hr>
<br>

### CHECK INSTALLS:
<pre>
	sudo service httpd status
	sudo service nginx status
	sudo service mariadb status
	sudo service firewalld status
</pre>
<hr>
<br>

### APACHE CERTBOT INSTALL AND CERT CREATION
<pre>
sudo dnf install snapd
sudo systemctl enable snapd
sudo service snapd start
sudo snap install core; sudo snap refresh core
sudo ln -s /var/lib/snapd/snap /snap
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
sudo certbot --apache -d site.com -d www.site.com
sudo certbot renew --dry-run 
reboot
</pre>
<hr>
<br>

### SSH COORDINATION:
<pre>
	<on server>
	ssh-keygen
	ssh-copy-id -p<port> user@ipaddress
</pre>
<hr>
<br>

### MORE CERTBOT STUFF... CERTIFICATES:
<pre>
	yum -y install yum-utils
	yum-config-manager --enable rhui-REGION-rhel-server-extras rhui-REGION-rhel-server-optional
	sudo yum -y install python2-certbot-apache
	[EMAIL SERVER]
	sudo certbot certonly --webroot --dry-run -w /var/www/html -d mail.mydomain.com
	sudo certbot certonly --webroot -w /var/www/html -d mail.mydomain.com
	[WEB SERVER]
	sudo certbot --apache -d url.com -d www.url.com
  	sudo certbot --nginx -d url.com -d www.url.com
</pre>
<hr>
<br>

### EXAMPLE LIST OF PHP INSTALLS
<pre>
  php-common.x86_64 0:5.4.16-45.el7                                             
  php-fpm.x86_64 0:5.4.16-45.el7                                                
  php-gd.x86_64 0:5.4.16-45.el7                                                 
  php-imap.x86_64 0:5.4.16-7.el7                                                
  php-intl.x86_64 0:5.4.16-45.el7                                               
  php-ldap.x86_64 0:5.4.16-45.el7                                               
  php-mbstring.x86_64 0:5.4.16-45.el7                                           
  php-mcrypt.x86_64 0:5.4.16-7.el7                                              
  php-mysql.x86_64 0:5.4.16-45.el7                                              
  php-pear-Net-IDNA2.noarch 0:0.1.1-10.el7                                      
  php-pecl-apcu.x86_64 0:4.0.11-1.el7                                           
  php-pgsql.x86_64 0:5.4.16-45.el7                                              
  php-xml.x86_64 0:5.4.16-45.el7 
</pre>
<hr>
<br>

### COMMANDS TO VERIFY DISK SPACE

DISKS:
(OPTIONAL)
<pre>
	sudo fdisk /dev/sdb
	sudo mkfs.ext4 /dev/sdb1
	sudo mkdir /mnt/website
	sudo mount -o defaults /dev/sdb1 /mnt/website
</pre>

DISK COMMANDS:
<pre>
	df -h : show disk space 
	du -sh /var/www/html/.... : show directory size
	chsh -s /bin/bash user  : change shell login
</pre>

## EXTRA NOTES FOR MAIL SERVER UPGRADES 

#### ADDITIONAL ITEMS FOR MAIL SERVER SWAP:

### NEED TO KNOW SETTINGS:
<pre>
	HOSTNAME:
	FIRST DOMAIN:
	VMAIL LOCATION: default /var/vmail
	MYSQL ROOT PASS:
</pre>
	
### CHANGE HOSTNAME
<pre>
	hostnamectl set-hostname your-new-hostname
</pre>

### DOWNLOAD IREDMAIL PACKAGE
<pre>
	cd
	[find latest at: https://www.iredmail.org/download.html]
	wget https://bitbucket.org/zhb/iredmail/downloads/iRedMail-0.9.8.tar.bz2
</pre>

### UNZIP AND INSTALL IREDMAIL
<pre>
	sudo yum -y install bzip2
	tar xvf file.tar.bz2
	cd [into new directory]
	sudo bash iRedMail.sh
	[follow the prompts]
</pre>

### TRANSFER PRO FILE AFTER LOCAL DOWNLOAD
<pre>
	[from home computer]
	scp -P[port] zip.file.bz2 root@<ip address>
</pre>	

### UNZIP AND INSTALL PRO FILE
<pre>
	tar xvf zip.file.bz2
	cd [into new directory]
	cd tools
	sudo bash upgrade_iredadmin.sh
</pre>

### UPDATE CERTIFICATES AND SETTINGS FOR EACH PROGRAM
	
#### SSL - (NO NEED TO UPDATE)
<pre>
		PRIVATE: /etc/pki/tls/certs/iRedMail.crt
		PUBLIC:  /etc/pki/tls/private/iRedMail.key
</pre>

#### POSTFIX - (UPDATE CERTS)
<pre>
		CONFIG:  /etc/postfix/
			* main.cf: contains most configurations.
				add CERTS at line 
					# SSL key, certificate, CA
					smtpd_tls_key_file = /etc/letsencrypt/live/mail.website.com/privkey.pem
					smtpd_tls_cert_file = /etc/letsencrypt/live/mail.website.com/fullchain.pem
					smtpd_tls_CAfile = /etc/letsencrypt/live/mail.website.com/fullchain.pem
			master.cf: contains transport related settings.
			aliases: aliases for system accounts.
			helo_access.pcre: PCRE regular expressions of HELO check rules.
			ldap/*.cf: used to query mail accounts. LDAP backends only.
			mysql/*.cf: used to query mail accounts. MySQL/MariaDB backends only.
			pgsql/*.cf: used to query mail accounts. PostgreSQL backend only.
		LOG:     /var/log/maillog
</pre>	

#### DOVECOT - (UPDATE CERTS)
<pre>
		CONFIG:  /etc/dovecot/
			* dovecot.conf. It contains most configurations.
				add CERTS at line 
					#ssl_ca = /path/to/ca
					ssl_cert = fullchain.pem
					ssl_key = privkey.pem
					ssl_ca = fullchain.pem
			dovecot-ldap.conf: used to query mail users and passwords. LDAP backends only.
			dovecot-mysql.conf: used to query mail users and passwords. MySQL/MariaDB backends only.
			dovecot-pgsql.conf: used to query mail users and passwords. PostgreSQL backend only.
			dovecot-used-quota.conf: used to store and query real-time per-user mailbox quota.
			dovecot-share-folder.conf: used to store settings of shared IMAP mailboxes.
		LOG:     dovecot.log (SHOULD CONTAIN ALL LOGS)
			dovecot-imap.log: IMAP service related log.
			dovecot-pop3.log: POP3 service related log.
			dovecot-sieve.log: Managesieve service related log.
			dovecot-lda.log: Local mail delivery related log, including both sieve and LMTP.
			dovecot-master-users-password or dovecot-master-users: used to store Dovecot master user accounts.	
</pre>

#### APACHE - (UPDATE CERTS via CERTBOT)
<pre>
		CONFIG:  /etc/httpd/
			Main config file is /etc/httpd/conf/httpd.conf
			Module config files are placed under /etc/httpd/conf.d/ (old releases) or /etc/httpd/conf.modules.d/.
			Root directory used to store web applications is /var/www, document root is /var/www/html/.
			Log files are placed under /var/www/httpd/.
</pre>

#### NGINX -
<pre>
		CONFIG:  /etc/nginx/
			Main config files are nginx.conf and default.conf
		LOG:     /var/log/nginx/
</pre>	
	
#### PHP -
<pre>
		CONFIG:  /etc/php.ini
			UPDATE:
				memory_limit = 256M;
				post_max_size = 12M;
				upload_max_filesize = 10M;
				max_file_uploads = 20
			OR
				file_uploads = On
				max_execution_time = 180
				memory_limit = 256M
				upload_max_filesize = 64M
</pre>

#### OPENLDAP -
<pre>
		CONFIG:  /etc/openldap/slapd.conf
</pre>

#### MYSQL -
<pre>
		CONFIG:  /etc/my.cnf
</pre>

#### ROUNDCUBE -
<pre>
		ROOT:    /var/www/roundcubemail
		SYM:     /var/www/roundcubemail-x.y.z
		CONFIG:  config/config.inc.php	
		PLUGIN:  plugins/password/config.inc.php
</pre>
#### AMAVISD - (UPDATE DKIM_KEYS)
<pre>
		CONFIG:  /etc/amavisd/amavisd.conf
			UPDATE:
				$mydomain = "mail2.website.com";
				$myhostname = "mail.website.com";
				DKIM_KEY see below inputs
</pre>
#### SPAMASSASIN -
<pre>
		CONFIG:  /etc/mail/spamassassin/local.cf
</pre>
#### FAIL2BAN -
<pre>
		CONFIG:  /etc/fail2ban/jail.local
		FILTERS: /etc/fail2ban/filter.d/
		BANS:    /etc/fail2ban/action.d/
		LOG:     /var/log/messages
</pre>
#### SOGO -
<pre>
		CONFIG:  /etc/sogo/sogo.conf
		LOG:     /var/log/sogo/sogo.log
</pre>
#### MLMMJADMIN -
<pre>
		CONFIG:  /opt/mlmmjadmin/settings.py
		LOG:     /var/log/mlmmjadmin/mlmmjadmin.log
		DATA:    /var/vmail/mlmmj
</pre>
#### IREDAPD -
<pre>
		CONFIG:  /opt/iredapd/settings.py
		LOG:     /var/log/iredapd/iredapd.log
</pre>
#### IREDADMIN -
<pre>
		CONFIG:  /var/www/iredadmin/settings.py
</pre>	


### /opt/www/roundcube/config/config.inc.php

#### NOTE:  create images folder and copy the .png to it (no need to chmod)
<pre>
$config['skin_logo'] = "images/site_400x400.png";
$config['htmleditor'] = 4;
$config['show_images'] = 2;
$config['reply_mode'] = 1;
$config['product_name'] = 'Services';
</pre>

### /etc/amavisd/amavisd.conf
<pre>
DKIM_KEYS - (IN AMAVISD)
#-------------------------------------------------------------	
# Add dkim_key here.
dkim_key("site.com", "dkim", "/var/lib/dkim/site.com.pem");

# Note that signing mail for subdomains with a key of a parent
# domain is treated by recipients as a third-party key, which
# may 'hold less merit' in their eyes. If one has a choice,
# it is better to publish a key for each domain (e.g. host1.a.cn)
# if mail is really coming from it. Sharing a pem file
# for multiple domains may be acceptable, so you don't need
# to generate a different key for each subdomain, but you
# do need to publish it in each subdomain. It is probably
# easier to avoid sending addresses like host1.a.cn and
# always use a parent domain (a.cn) in 'From:', thus
# avoiding the issue altogether.
#dkim_key("host1.site.com", "dkim", "/var/lib/dkim/site.com.pem");
#dkim_key("host3.site.com", "dkim", "/var/lib/dkim/site.com.pem");

# Add new dkim_key for other domain.
#dkim_key('Your_New_Domain_Name', 'dkim', 'Your_New_Pem_File');

@dkim_signature_options_bysender_maps = ( {
    # ------------------------------------
    # For domain: site.com.
    # ------------------------------------
    # 'd' defaults to a domain of an author/sender address,
    # 's' defaults to whatever selector is offered by a matching key

    #'postmaster@site.com'    => { d => "site.com", a => 'rsa-sha256', ttl =>  7*24*3600 },
    #"spam-reporter@site.com"    => { d => "site.com", a => 'rsa-sha256', ttl =>  7*24*3600 },

    # explicit 'd' forces a third-party signature on foreign (hosted) domains
    "site.com"  => { d => "site.com", a => 'rsa-sha256', ttl => 10*24*3600 },
#   "site.com"  => { d => "site.com", a => 'rsa-sha256', ttl => 10*24*3600 },

    #"host2.site.com"  => { d => "host2.site.com", a => 'rsa-sha256', ttl => 10*24*3600 },
    # ---- End domain: site.com ----

    # catchall defaults
    '.' => { a => 'rsa-sha256', c => 'relaxed/simple', ttl => 30*24*3600 },
} );
</pre>


## SERVER CONNECTIONS FOR MAIL

### IREDMAIL SETTINGS
<pre>
	* POP3 service: port 110 over TLS (recommended), or port 995 with SSL.
	* IMAP service: port 143 over TLS (recommended), or port 993 with SSL.
	* SMTP service: port 587 over TLS.
	* CalDAV and CardDAV server addresses: https://<server>/SOGo/dav/<full email address>
</pre>

#### NGINX OUTPUT AFTER SUCCESSFUL INSTALL 
<pre>
Please choose whether or not to redirect HTTP traffic to HTTPS, removing HTTP access.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
1: No redirect - Make no further changes to the webserver configuration.
2: Redirect - Make all requests redirect to secure HTTPS access. Choose this for
new sites, or if you're confident your site works on HTTPS. You can undo this
change by editing your web server's configuration.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Select the appropriate number [1-2] then [enter] (press 'c' to cancel): 2
Redirecting all traffic on port 80 to ssl in /etc/nginx/sites-enabled/site.com.conf
Redirecting all traffic on port 80 to ssl in /etc/nginx/sites-enabled/site.com.conf

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Congratulations! You have successfully enabled https://site.com and
https://www.site.com

You should test your configuration at:
https://www.ssllabs.com/ssltest/analyze.html?d=site.com
https://www.ssllabs.com/ssltest/analyze.html?d=www.site.com
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

IMPORTANT NOTES:
 - Congratulations! Your certificate and chain have been saved at:
   /etc/letsencrypt/live/site.com/fullchain.pem
   Your key file has been saved at:
   /etc/letsencrypt/live/site.com/privkey.pem
   Your cert will expire on 2019-01-20. To obtain a new or tweaked
   version of this certificate in the future, simply run certbot again
   with the "certonly" option. To non-interactively renew *all* of
   your certificates, run "certbot renew"
 - Your account credentials have been saved in your Certbot
   configuration directory at /etc/letsencrypt. You should make a
   secure backup of this folder now. This configuration directory will
   also contain certificates and private keys obtained by Certbot so
   making regular backups of this folder is ideal.
 - If you like Certbot, please consider supporting our work by:

   Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
   Donating to EFF:                    https://eff.org/donate-le	
</pre>

## ERROR AFTER INITIAL CENTOS8 INSTALLTION
<pre>
Fatal error: Uncaught Error: 
Call to undefined method wpdb::show_errors() in /var/www/html/virtuals/site.com/wp-includes/wp-db.php:610 
Stack trace: 
#0 /var/www/html/virtuals/site.com/wp-includes/load.php(527): wpdb->__construct() 
#1 /var/www/html/virtuals/site.com/wp-settings.php(124): require_wp_db() 
#2 /var/www/html/virtuals/site.com/wp-config.php(90): require_once('/var/www/html/v...') 
#3 /var/www/html/virtuals/site.com/wp-load.php(37): require_once('/var/www/html/v...') 
#4 /var/www/html/virtuals/site.com/wp-blog-header.php(13): require_once('/var/www/html/v...') 
#5 /var/www/html/virtuals/site.com/index.php(17): require('/var/www/html/v...') 
#6 {main} thrown in /var/www/html/virtuals/site.com/wp-includes/wp-db.php on line 610

create database test_20210228;
GRANT ALL PRIVILEGES ON test_20210228.* TO "sitetest"@"localhost" IDENTIFIED BY "testpassword";
flush privileges;


[siteadmin@siteWEB1 ~]$ sudo dnf list installed | grep php
Password: 
oniguruma5php.x86_64                 6.9.6-1.el8.remi                         @remi-safe   
php-cli.x86_64                       7.4.15-1.el8.remi                        @remi-modular
php-common.x86_64                    7.4.15-1.el8.remi                        @remi-modular
php-fpm.x86_64                       7.4.15-1.el8.remi                        @remi-modular
php-gd.x86_64                        7.4.15-1.el8.remi                        @remi-modular
php-intl.x86_64                      7.4.15-1.el8.remi                        @remi-modular
php-json.x86_64                      7.4.15-1.el8.remi                        @remi-modular
*php-ldap.x86_64                      7.4.15-1.el8.remi                        @remi-modular
php-mbstring.x86_64                  7.4.15-1.el8.remi                        @remi-modular
php-mysqlnd.x86_64                   7.4.15-1.el8.remi                        @remi-modular
php-pdo.x86_64                       7.4.15-1.el8.remi                        @remi-modular
php-pecl-mcrypt.x86_64               1.0.4-1.el8.remi.7.4                     @remi-modular
*php-pecl-mysql.x86_64               1.0.0-0.23.20190415.d7643af.el8.remi.7.4 @remi-modular
*php-pecl-zip.x86_64                  1.19.2-1.el8.remi.7.4                    @remi-modular
*php-soap.x86_64                      7.4.15-1.el8.remi                        @remi-modular
php-xml.x86_64                       7.4.15-1.el8.remi                        @remi-modular
*php-xmlrpc.x86_64                    7.4.15-1.el8.remi                        @remi-modular

[siteadmin@siteweb site.com]$ sudo dnf list installed | grep php
oniguruma5php.x86_64               6.9.6-1.el8.remi                          @remi-safe   
*php.x86_64                         7.4.15-1.el8.remi                         @remi-modular
php-cli.x86_64                     7.4.15-1.el8.remi                         @remi-modular
php-common.x86_64                  7.4.15-1.el8.remi                         @remi-modular
php-fpm.x86_64                     7.4.15-1.el8.remi                         @remi-modular
php-gd.x86_64                      7.4.15-1.el8.remi                         @remi-modular
php-intl.x86_64                    7.4.15-1.el8.remi                         @remi-modular
php-json.x86_64                    7.4.15-1.el8.remi                         @remi-modular
php-mbstring.x86_64                7.4.15-1.el8.remi                         @remi-modular
php-mysqlnd.x86_64                 7.4.15-1.el8.remi                         @remi-modular
*php-opcache.x86_64                 7.4.15-1.el8.remi                         @remi-modular
*php-pdo.x86_64                     7.4.15-1.el8.remi                         @remi-modular
php-pecl-mcrypt.x86_64             1.0.4-1.el8.remi.7.4                      @remi-modular
*php-pecl-uopz.x86_64               6.1.2-1.el8.remi.7.4                      @remi-modular
*php-sodium.x86_64                  7.4.15-1.el8.remi                         @remi-modular
php-xml.x86_64                     7.4.15-1.el8.remi                         @remi-modular

AFTER ASTERISK INSTALLS:
Fatal error: Cannot redeclare wp_kses() (previously declared in /var/www/html/virtuals/site.com/wp-includes/kses.php:746) in /var/www/html/virtuals/site.com/wp-includes/kses.php on line 746
WordPress database error: [Table 'test_20210228.test_options' doesn't exist]
SELECT option_value FROM test_options WHERE option_name = 'WPLANG' LIMIT 1

WordPress database error: [Table 'test_20210228.test_options' doesn't exist]
SELECT option_value FROM test_options WHERE option_name = 'html_type' LIMIT 1

WordPress database error: [Table 'test_20210228.test_options' doesn't exist]
SELECT option_value FROM test_options WHERE option_name = 'blog_charset' LIMIT 1

WordPress database error: [Table 'test_20210228.test_options' doesn't exist]
SELECT option_value FROM test_options WHERE option_name = 'blog_public' LIMIT 1
</pre>
####--------------------------- END ----------------------------####




