#!/bin/bash
#based on yutorial: https://www.tecmint.com/install-rsyslog-centralized-logging-in-centos-ubuntu/

# postgres server
#purpose:location for server logs
sudo yum update -y && yum install -y rsyslog
sudo systemctl start rsyslog
sudo systemctl enable rsyslog
sudo systemctl status rsyslog
#make backup
cp /etc/rsyslog.conf /etc/rsyslog.conf.back
#edit
#To configure rsyslog as a network/central logging server, you need to set the protocol tdp/udp it 
#sudo vim /etc/rsyslog.conf
sed -i 's/#$ModLoad imudp/$ModLoad imudp/g' /etc/rsyslog.conf
sed -i 's/#$UDPServerRun 514/$UDPServerRun 514/g' /etc/rsyslog.conf
sed -i 's/#$ModLoad imtcp/$ModLoad imtcp/g' /etc/rsyslog.conf
sed -i 's/#$Input/TCPServerRun 514/$Input/TCPServerRun 514/g' /etc/rsyslog.conf
#define the ruleset for processing remote logs in the following format
#did not work, so do not add
#*.* ?RemoteLogs 
#& ~
systemctl restart rsyslog
#see tcp, udp, listening, number, port and look for rsyslog
ss -tulnp | grep "rsyslog"
#interface w SELinux but not working
sudo semanage -a -t syslogd_port_t -p udp 514
sudo semanage -a -t syslogd_port_t -p tcp 514
#not needed for automation
#sudo systemctl status rsyslog
#setting up machine to run as client rsyslog to server rsyslog
#install this on a server
#rsyslog should be first server up

#client automation
sudo yum update -y && yum install -y rsyslog 	
sudo systemctl start rsyslog
sudo systemctl enable rsyslog
# on the client add to end of file
echo "*.* @@ldap-rsyslog-1:514" >> /etc/rsyslog.conf
sudo systemctl status rsyslog
tail -f /var/log/messages
