!#/bin/bash
# Centos 7 Machine
# sudo su
yum -y install nagios
systemctl enable nagios
setenforce 0
systemctl start nagios
yum -y install httpd
systemctl enable httpd
systemctlstart httpd
yum -y install nrpe
systemctl enable nrpe
systemctl start nrpe
yum -y install nagios-plugins-all
yum -y install nagios-plugins-nrpe
htpasswd -b -c /etc/nagios/passwd nagiosadmin nagiosadmin
# password set to 12qwaszx+1
dd if=/dev/zero of=/swap bs=1024 count=2097152
mkswap /swap && chown root. /swap && chmod 0600 /swap && swapon /swap
echo /swap swap swap defaults 0 0 >> /etc/fstab
echo vm.swappiness = 0 >> /etc/sysctl.conf && sysctl -p
chmod 666 /var/log/nagios/nagios.log
sed -i '51 s/^#//' /etc/nagios/nagios.cfg
systemctl restart nagios
echo 'define command{
                                command_name check_nrpe
                                command_line /usr/lib64/nagios/plugins/check_nrpe -H $HOSTADDRESS$ -c $ARG1$
                                }' >> /etc/nagios/objects/commands.cfg
# verify ( prefly )
/usr/sbin/nagios -v /etc/nagios/nagios.cfg
chmod 777 /etc/nagios/servers
systecmctl restart nagios
#cd /etc/nagios
#sed -i "s/#cfg_dir=/etc/nagios/servers/cfg_dir=/etc/nagios/servers" nagios.cfg
#sudo mkdir servers
#sudo chmod -R 755 servers
#systecmctl restart nagios

# Baby Web server - For Google cloud make sure it is in the same zone as the Nagios server
# yum -y install httpd
# systemctl enable httpd
# systemctl start httpd


