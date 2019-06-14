#!/bin/bash

yum -y install rpm-build make gcc git                                         

mkdir -p /root/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}                      
                                                                            
cd ~/

echo '%_topdir %(echo $HOME)/rpmbuild' > ~/.rpmmacros                         

cd ~/rpmbuild/SOURCES

git clone https://github.com/nic-instruction/custom-nrpe-2019.git

cp custom-nrpe-2019/nti-320-plugins-0.1.tar.gz .
cp custom-nrpe-2019/plugins/check_ldaps_cert_expiry.sh .
cp custom-nrpe-2019/nti-320-plugins.spec .
cp nti-320-plugins.spec ../SPECS

cd ..

rpmbuild -v -bb --clean SPECS/nti-320-plugins.spec

##did it work?
#ls -l RPMS/x86_64/helloworld-0.1-1.el7.x86_64.rpm

yum -y install RPMS/x86_64/nti-320-plugins-0.1-1.el7.x86_64.rpm

##did it work?
#ls -l /
