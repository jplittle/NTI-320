
#!/bin/bash
yum -y install nagios-nrpe-server nagios-plugins nrpe
yum install -y nagios-nrpe-server nagios-plugins nrpe nagios-plugins-load nagios-plugins-ping nagios-plugins-disk nagios-plugins-http nagios-plugins-procs wget
wget -O /usr/lib64/nagios/plugins/check_mem.sh https://raw.githubusercontent.com/nic-instruction/NTI-320/master/nagios/check_mem.sh
chmod +x /usr/lib64/nagios/plugins/check_mem.sh
systemctl enable nrpe
systemctl start nrpe
sed -i 's/allowed_hosts=127.0.0.1/allowed_hosts=127.0.0.1, 10.150.0.2/g' /etc/nagios/nrpe.cfg
systemctl restart nrpe
 # sed #command[check_mem]=/usr/lib64/nagios/plugins/custom_check_mem -n $ARG1$,command[check_mem]=/usr/lib64/nagios/plugins/check_mem.sh -w 80 -c 90,g' /etc/nagios/nrpe.cfg
