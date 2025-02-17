#!/bin/bash

start_over() {

sudo apt update
sudo apt upgrade

echo "mysql root pw:  $mysqlrootpw"
echo "guacadmin  pw:  $guacadminpw"
echo "..working dir:  /home/$username"
sleep 2

cfid="This command will be entered..."
}

install_docker() {

cat <<EOF

===========================================
INSTALLING GPG KEYS FOR GUACAMOLE:

Ubuntu: https://download.docker.com/linux/ubuntu
Debian: https://download.docker.com/linux/debian
sudo apt install apt-transport-https ca-certificates curl gnupg lsb-release
curl -fsSL [url]/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] [url] $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl enable containerd
sudo usermod -aG docker [user]
===========================================


EOF

:<<END_COMMENT
read -p "Continue? [y/n]: " permit
case $permit in
	y)
		echo "Thank you, continuing..."
		;;
	n)
		echo "Exiting..."
		exit 1
		;;
	*)
		exit 1
		;;
esac
END_COMMENT

# inserted from NEW
sudo apt update
sudo apt install apt-transport-https ca-certificates curl gnupg lsb-release

cat <<EOF

1) Ubuntu
2) Debian
3) AWS-Linux

EOF
read -p "Enter your OS number:  " os_num
case $os_num in
        1)
                # Ubuntu
		curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
		echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
                ;;
        2)
                # Debian
		curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
		echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
                ;;
        3)
                # n/a for AWS ec2-user
                ;;
        *)
                echo "Invalid input. Exiting..."
                exit 1
                ;;
esac

# install docker
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose
# start docker
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl enable containerd
# add user to docker group (no need for sudo in commands)
case $os_num in
        1)
                sudo usermod -aG docker ubuntu
		echo ""
		echo "USER UBUNUT ADDED TO DOCKER"
		echo ""
                ;;
        2)
                sudo usermod -aG docker admin
		echo ""
                echo "USER ADMIN ADDED TO DOCKER"
                echo ""
                ;;
        3)
                sudo usermod -aG docker ec2-user
		echo ""
                echo "USER EC2-USER ADDED TO DOCKER"
                echo ""
                ;;
        *)
                echo "Invalid input. Exiting..."
                exit 1
                ;;
esac

cat <<EOF

THE VERSIONS SHOULD SHOW NEXT:
(if not, install incomplete)

EOF

sudo docker --version
sudo docker-compose --version
}

install_cloudflare() {

cat <<EOF

===========================================
INSTALLING A CLOUDFLARE TUNNEL
read -p "Paste the install copy/paste here:  " cfid
curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && 
sudo dpkg -i cloudflared.deb && 
\$cfid
===========================================


EOF

read -p "Continue? [y/n]: " permit
case $permit in
        y)
                echo "Thank you, continuing..."
                ;;
        n)
                echo "Exiting..."
                exit 1
		;;
        *)
                exit 1
		;;
esac


# add cloudflare to repo
read -p "Paste the install copy/paste here:  " cfid
curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && 
sudo dpkg -i cloudflared.deb && 
$cfid
}

download_images() {

cat <<EOF

===========================================
DOWNLOADING IMAGES FOR GUACAMOLE
docker pull guacamole/guacd
docker pull guacamole/guacamole
docker pull mysql/mysql-server
docker images
===========================================

EOF


read -p "Continue? [y/n]: " permit
case $permit in
        y)
                echo "Thank you, continuing..."
                ;;
        n)
                echo "Exiting..."
                exit 1
		;;
        *)
                exit 1
		;;
esac


#pull the images for docker
sudo docker pull guacamole/guacd
sudo docker pull guacamole/guacamole
sudo docker pull mysql/mysql-server
echo ""
echo "IMAGES"
sudo docker images
echo ""
}

run_mysql() {

cat <<EOF
===========================================
RUNNING MYSQL
docker run --name guacamole-database -e MYSQL_ROOT_PASSWORD=<secret> -e MYSQL_DATABASE=guacdb -d mysql/mysql-server
mkdir /home/$username/Guacamole
mkdir /home/$username/Guacamole/mysql
docker run --rm guacamole/guacamole /opt/guacamole/bin/initdb.sh --mysql > /home/$username/Guacamole/mysql/01-initdb.sql
docker cp /home/$username/Guacamole/mysql/01-initdb.sql guacamole-database:/docker-entrypoint-initdb.d
docker exec -it guacamole-database bash
===========================================

EOF

read -p "Continue? [y/n]: " permit
case $permit in
        y)
                echo "Thank you, continuing..."
                ;;
        n)
                echo "Exiting..."
                exit 1
		;;
        *)
                exit 1
		;;
esac

sudo docker run --name guacamole-database -e MYSQL_ROOT_PASSWORD=$mysqlrootpw -e MYSQL_DATABASE=guacdb -d mysql/mysql-server
mkdir /home/$username/Guacamole
mkdir /home/$username/Guacamole/mysql
# copy the database configuration from the image to the server box
sudo docker run --rm guacamole/guacamole /opt/guacamole/bin/initdb.sh --mysql > /home/$username/Guacamole/mysql/01-initdb.sql
# copy the database configuration to the docker image
sudo docker cp /home/$username/Guacamole/mysql/01-initdb.sql guacamole-database:/docker-entrypoint-initdb.d

echo ""
echo "DOCKER PS -A"
sudo docker ps -a
echo ""

echo "Counting to 20..."
counter=1
while [ $counter -le 20 ]; do
	printf "%d " $counter
	counter=$((counter + 1))
	sleep 1
done

cat <<EOF

===========================================
RUN THIS:
cd /docker-entrypoint-initdb.d/
ls
mysql -u root -p
ROOT PASSWORD: $mysqlrootpw
use guacdb;
source /docker-entrypoint-initdb.d/01-initdb.sql;
show tables;
create user guacadmin@'%' identified by '$guacadminpw';
grant SELECT,UPDATE,INSERT,DELETE on guacdb.* to guacadmin@'%';
flush privileges;
exit
===========================================

EOF

:<<END_COMMENT
ERROR SEEN DURING SUCCESSFUL INSTALLATION...
mysql> source /docker-entrypoint-initdb.d/01-initdb.sql;
ERROR 1050 (42S01): Table 'guacamole_connection_group' already exists
ERROR 1050 (42S01): Table 'guacamole_connection' already exists
ERROR 1050 (42S01): Table 'guacamole_entity' already exists
ERROR 1050 (42S01): Table 'guacamole_user' already exists
ERROR 1050 (42S01): Table 'guacamole_user_group' already exists
ERROR 1050 (42S01): Table 'guacamole_user_group_member' already exists
ERROR 1050 (42S01): Table 'guacamole_sharing_profile' already exists
ERROR 1050 (42S01): Table 'guacamole_connection_parameter' already exists
ERROR 1050 (42S01): Table 'guacamole_sharing_profile_parameter' already exists
ERROR 1050 (42S01): Table 'guacamole_user_attribute' already exists
ERROR 1050 (42S01): Table 'guacamole_user_group_attribute' already exists
ERROR 1050 (42S01): Table 'guacamole_connection_attribute' already exists
ERROR 1050 (42S01): Table 'guacamole_connection_group_attribute' already exists
ERROR 1050 (42S01): Table 'guacamole_sharing_profile_attribute' already exists
ERROR 1050 (42S01): Table 'guacamole_connection_permission' already exists
ERROR 1050 (42S01): Table 'guacamole_connection_group_permission' already exists
ERROR 1050 (42S01): Table 'guacamole_sharing_profile_permission' already exists
ERROR 1050 (42S01): Table 'guacamole_system_permission' already exists
ERROR 1050 (42S01): Table 'guacamole_user_permission' already exists
ERROR 1050 (42S01): Table 'guacamole_user_group_permission' already exists
ERROR 1050 (42S01): Table 'guacamole_connection_history' already exists
ERROR 1050 (42S01): Table 'guacamole_user_history' already exists
ERROR 1050 (42S01): Table 'guacamole_user_password_history' already exists
ERROR 1062 (23000): Duplicate entry 'USER-guacadmin' for key 'guacamole_entity.guacamole_entity_name_scope'
ERROR 1062 (23000): Duplicate entry '1' for key 'guacamole_user.guacamole_user_single_entity'
ERROR 1062 (23000): Duplicate entry '1-CREATE_CONNECTION' for key 'guacamole_system_permission.PRIMARY'
ERROR 1062 (23000): Duplicate entry '1-1-READ' for key 'guacamole_user_permission.PRIMARY'
END_COMMENT

sudo docker exec -it guacamole-database bash

:<<END_COMMENT
sudo docker exec -i guacamole-database bash << EOF
mysql -uroot -p -e "show databases; use guacdb; source /docker-entrypoint-initdb.d/01-initdb.sql; how tables; create user guacadmin@'%' identified by '$guacadminpw'; grant SELECT,UPDATE,INSERT,DELETE on guacdb.* to guacadmin@'%'; flush privileges; show tables;"
$mysqlrootpw
EOF
END_COMMENT

read -p "Did it run? [y/n]:  " diditrun
case $diditrun in
	y)
		echo "Continuing..."
		echo ""
		;;
	n)
		run_mysql
		;;
	*)
		echo "oops... continuing..."
		echo ""
		;;
esac

# showing the install logs to verify installation
sudo docker logs guacamole-database
# verify docker images
sudo docker ps

}

run_guacamole_server() {

cat <<EOF
===========================================
RUN THE GUACAMOLE SERVER / SHOW LOGS
docker run --name guacamole-server -d guacamole/guacd
docker logs --tail 10 guacamole-server
docker ps
===========================================


EOF

read -p "Continue? [y/n]: " permit
case $permit in
        y)
                echo "Thank you, continuing..."
                ;;
        n)
                echo "Exiting..."
                exit 1
		;;
        *)
                exit 1
		;;
esac

# run the guacamole server
sudo docker run --name guacamole-server -d guacamole/guacd
# show the logs for the guacamole server
sudo docker logs --tail 10 guacamole-server
# verify the image
sudo docker ps
}

run_guacamole_client() {

cat <<EOF
===========================================
RUN THE GUACAMOLE CLIENT
docker run --name guacamole-client --link guacamole-server:guacd --link guacamole-database:mysql -e MYSQL_DATABASE=guacdb -e MYSQL_USER=guacadmin -e MYSQL_PASSWORD=<secret> -d -p 8080:8080 guacamole/guacamole
docker ps

PUBLIC PORT = 80
===========================================


EOF

read -p "Continue? [y/n]: " permit
case $permit in
        y)
                echo "Thank you, continuing..."
                ;;
        n)
                echo "Exiting..."
                exit 1
		;;
        *)
                exit 1
		;;
esac

# run the guacamole client - CHANGE THE PASSWORD TO A ROOT VARIABLE
sudo docker run --name guacamole-client --link guacamole-server:guacd --link guacamole-database:mysql -e MYSQL_DATABASE=guacdb -e MYSQL_USER=guacadmin -e MYSQL_PASSWORD=$guacadminpw -d -p 8080:8080 guacamole/guacamole
# verify images once again
sudo docker ps
}

view_network() {

cat <<EOF
===========================================
LOOK AT NETWORK CONNECTIONS
ss -altnp | grep :8080
===========================================

EOF

# show network connections
ss -altnp
echo ""
echo ""
ss -altnp | grep :8080
}

# main script starts here and references functions

# WILL WANT TO CHANGE THIS TO A REFERENCE FILE IN /ROOT
#mysqlrootpw=$1
#guacadminpw=$2
#mysqlrootpw="u7w3G^DC&RP\$Ry\$BnhWc"
#guacadminpw="iQBEb\$3m*UG92%EEA7a\$"

read -s -p "Please choose a mysql root password:  " mysqlrootpw
echo ""
read -s -p "Please choose a guacadmin  password:  " guacadminpw
echo ""
read -p "What is your user name?  " username

cat <<EOF

===========================================
THIS SCRIPT WILL:
1) --> PASSWORDS: show what you entered
2) DOCKER:  Install on various OS versions
3) CLOUDFLARE:  Install a tunnel
4) IMAGES: install guacd / guacamole / mysql
5) MYSQL: create appropriate database
6) RUN: guacamole server
7) RUN: guacamole client
8) NETWORK: view 8080 connections
===========================================
The script will start at your selection

EOF

read -p "Where would you like to start the script? [1-8]:  " starthere
case $starthere in
        1)
                start_over
                install_docker
		install_cloudflare
		download_images
		run_mysql
		run_guacamole_server
		run_guacamole_client
		view_network
		;;
        2)
		install_docker
                install_cloudflare
                download_images
                run_mysql
                run_guacamole_server
                run_guacamole_client
                view_network
		;;
        3)
                install_cloudflare
                download_images
                run_mysql
                run_guacamole_server
                run_guacamole_client
                view_network
		;;
        4)
		download_images
                run_mysql
                run_guacamole_server
                run_guacamole_client
                view_network
		;;
        5)
		run_mysql
                run_guacamole_server
                run_guacamole_client
                view_network
		;;
        6)
		run_guacamole_server
                run_guacamole_client
                view_network
		;;
        7)
		run_guacamole_client
                view_network
		;;
        8)
                view_network
                ;;
        *)
                echo "Invalid entry, exiting..."
		echo ""
		exit 1
                ;;
esac

cat <<EOF

SCRIPT COMPLETE, EXITING...

EOF
