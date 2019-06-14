#!/bin/bash

yum -y install cacti

yum -y install mariadb-server

yum -y install php-process php-gd php mod_php

yum -y install net-snmp net-snmp-utils

systemctl enable mariadb           
systemctl enable httpd
systemctl enable snmpd


systemctl start mariadb           
systemctl start httpd
systemctl start snmpd


db_password="P@ssw0rd1"
cacti_password="P@ssw0rd1"

mysqladmin -u root password $db_password

mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u root -p$db_password mysql    

echo "create database cacti;
GRANT ALL ON cacti.* TO cacti@localhost IDENTIFIED BY '$cacti_password';  # Set this to somthing better than 'cactipass'
FLUSH privileges;
GRANT SELECT ON mysql.time_zone_name TO cacti@localhost;            # Added to fix a timezone issue
flush privileges;" > stuff.sql

mysql -p"$db_password" -u root < stuff.sql       
                                 
mypath=$(rpm -ql cacti|grep cacti.sql)

mysql cacti < $mypath -u cacti -p"$cacti_password"

sed -i.bak "s,\$database_username = 'cactiuser',\$database_username = 'cacti',g" /etc/cacti/db.php
sed -i "s,\$database_password = 'cactiuser',\$database_password = '$cacti_password',g" /etc/cacti/db.php

sed -i 's/Require host localhost/Require all granted/' /etc/httpd/conf.d/cacti.conf
sed -i 's/Allow from localhost/Allow from all all/' /etc/httpd/conf.d/cacti.conf

cp /etc/php.ini /etc/php.ini.orig
sed -i 's/;date.timezone =/date.timezone = America\/Regina/' /etc/php.ini

systemctl restart httpd.service

sed -i 's/#//g' /etc/cron.d/cacti

setenforce 0

systemctl restart httpd.service
