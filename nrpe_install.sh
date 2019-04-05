
#!/bin/bash
yum -y install nagios-nrpe-server nagios-plugins
sed -i 's/allowed_hosts=127.0.0.1/allowed_hosts=127.0.0.1, 10.142.0.15/g' /etc/nagios/nrpe.cfg
systemctl restart nagios-nrpe-server
