
#!/bin/bash
yum -y install nagios-nrpe-server nagios-plugins nrpe
sed -i 's/allowed_hosts=127.0.0.1/allowed_hosts=127.0.0.1, 10.150.0.2/g' /etc/nagios/nrpe.cfg
systemctl restart nrpe
