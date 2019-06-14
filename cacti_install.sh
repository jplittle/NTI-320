#!/bin/bash

###INSTALLS CACTI PACKAGES FOR NETWORK TRENDING INFORMATION
yum -y install cacti
#####OPEN SOURCE DATABASE VERSION OF ORACLE MYSQL
yum -y install mariadb-server
#####CACTI RUNS ON PHP: INSTALLING DEPENDENCIES NEEDED
#####THESE DEPENDENCIES MAY ALREDY BE INSTALLED
yum -y install php-process php-gd php mod_php
#####SIMPLE NETWORK MANAGEMENT PROTOCOL
yum -y install net-snmp net-snmp-utils

systemctl enable mariadb           # Enable db, apache and snmp (not cacti yet)
systemctl enable httpd
systemctl enable snmpd


systemctl start mariadb           # Start db, apache and snmp (not cacti yet)
systemctl start httpd
systemctl start snmpd

#####SET MYSQL-MARIADB PASSWD#####
db_password="P@ssw0rd1"
cacti_password="P@ssw0rd1"

##### Make a sql script to create a cacti db and grant the cacti user access to it
mysqladmin -u root password $db_password

#####SET TIMEZONE#####
# Transfer your local timezone info to mysql
mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u root -p$db_password mysql    

#####create cacti user and grant alll
echo "create database cacti;
GRANT ALL ON cacti.* TO cacti@localhost IDENTIFIED BY '$cacti_password';  # Set this to somthing better than 'cactipass'
FLUSH privileges;

GRANT SELECT ON mysql.time_zone_name TO cacti@localhost;            # Added to fix a timezone issue
flush privileges;" > stuff.sql

#####RUN SQL SCRIPT#####
mysql -p"$db_password" -u root < stuff.sql   
##rpm -ql cacti|grep cacti.sql     # Will list the location of the package cacti sql script
                                 # In this case, the output is /usr/share/doc/cacti-1.0.4/cacti.sql, run that to populate your db

#####SET VARIABLE FOR PATH SO IT UPDATES AUTOMATICALLY
mypath=$(rpm -ql cacti|grep cacti.sql)
mysql cacti < $mypath -u cacti -p"$cacti_password"
####WOULD'VE INPORTED NEW DATABSE INTO CACTI BUT ALREADY IMPORTED
##mysql -u cacti -p cacti < /usr/share/doc/cacti-1.0.4/cacti.sql

# Modify cacti credencials to use user cacti P@ssw0rd1
sed -i.bak "s,\$database_username = 'cactiuser',\$database_username = 'cacti',g" /etc/cacti/db.php
sed -i "s,\$database_password = 'cactiuser',\$database_password = '$cacti_password',g" /etc/cacti/db.php

# Open up AND CONFIGURE apache
sed -i 's/Require host localhost/Require all granted/' /etc/httpd/conf.d/cacti.conf
sed -i 's/Allow from localhost/Allow from all all/' /etc/httpd/conf.d/cacti.conf

# Fix the php.ini script WITH TIMEZONE
cp /etc/php.ini /etc/php.ini.orig
sed -i 's/;date.timezone =/date.timezone = America\/Regina/' /etc/php.ini

systemctl restart httpd.service

# Set up the cacti cron
sed -i 's/#//g' /etc/cron.d/cacti
setenforce 0

systemctl restart httpd.service
