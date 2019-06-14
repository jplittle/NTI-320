#!/bin/bash

yum -y install nagios
systemctl enable nagios
systemctl start nagios

setenforce 0

yum -y install httpd
systemctl enable httpd
systemctl start httpd

yum -y install nrpe
systemctl enable nrpe
systemctl start nrpe

yum -y install nagios-plugins-all

yum -y install nagios-plugins-nrpe

dd if=/dev/zero of=/swap bs=1024 count=2097152

mkswap /swap && chown root. /swap && chmod 0600 /swap && swapon /swap

echo /swap swap swap defaults 0 0 >> /etc/fstab

echo vm.swappiness = 0 >> /etc/sysctl.conf && sysctl -p

htpasswd -b -c ~/temp/password nagiosadmin nagiosadmin

chmod 666 /var/log/nagios/nagios.log

sed -i '51 s/^#//' /etc/nagios/nagios.cfg

systemctl restart nagios

echo '########### NRPE CONFIG LINE #######################
        define command{
        command_name check_nrpe
        command_line $USER1$/check_nrpe -H $HOSTADDRESS$ -c $ARG1$
}' >> /etc/nagios/objects/commands.cfg

touch /var/www/html/index.html

chmod 755 /var/www/html/index.html

systemctl restart nagios

mkdir /etc/nagios/servers

sed '51i\ cfg_dir=/etc/nagios/servers'

usermod -a -G nagios mnicho18

chmod 777 /etc/nagios/servers
