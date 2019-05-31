
#!/bin/bash

yum -y install yum-utils rpmbuild



yumdownloader --source nrpe

yumdownloader --source nagios



#This will give you the source packages for nrpe and nagios on centos7

# Note: this process is much easier on other flavors of linux



rpm --showrc | grep topdir

# make sure your topdir is pointing somewhere sane

rpm -ivh ./nrpe-2.15-7.el7.src.rpm 

rpm -ivh ./nagios-4.2.4-2.el7.src.rpm 



# This will install into your existing build dir in the root home under rpmbuild.
