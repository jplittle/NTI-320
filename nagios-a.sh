#!/bin/bash

# configuration for nagios-a
#####################
#   On the server   #
#####################

##### INSTALL NAGIOS #####
yum -y install nagios
systemctl enable nagios
systemctl start nagios

##### TURN OFF SE LINUX #####
setenforce 0

##### INSTALL APACHE #####
yum -y install httpd
systemctl enable httpd
systemctl start httpd

##### INSTALL NRPE #####
yum -y install nrpe
systemctl enable nrpe
systemctl start nrpe

##### INSTALL NAGIOS SERVER PLUGINS #####
yum -y install nagios-plugins-all

##### INSTALL NRPE SERVER PLUGINS #####
yum -y install nagios-plugins-nrpe

##### CREATE PASSWORD #####
htpasswd -b -c /etc/nagios/passwd nagiosadmin nagiosadmin

##### ENABLE ACCESS FOR LOGS #####
chmod 666 /var/log/nagios/nagios.log

##### RESTART NAGIOS #####
systemctl restart nagios

##### VERIFY NAGIOS CONFIG #####
/usr/sbin/nagios -v /etc/nagios/nagios.cfg

##### CHANGE DIRECTORY #####
cd /etc/nagios/

##### MAKE DIRECTORY #####
mkdir servers

#vim generate_config.sh
#chmod +x generate_config.sh
#./generate_config.sh host ip

usermod -a -G nagios cchang30
chmod 777 /etc/nagios/servers

#uncomment line 51 cfg_dir=/etc/nagios/servers
sed -i '51 s/^#//' nagios.cfg 

######Need to put the NRPE changes into config file#####
echo '########### NRPE CONFIG LINE #######################
define command{
command_name check_nrpe
command_line $USER1$/check_nrpe -H $HOSTADDRESS$ -c $ARG1$
}' >> /etc/nagios/objects/commands.cfg

#####RESTART NAGIOS#####
systemctl restart nagios
