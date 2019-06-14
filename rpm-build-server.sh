!#/bin/bash
yum -y install rpm-build make gcc git 
mkdir -p /root/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS} 
cd ~/
echo '%_topdir %(echo $HOME)/rpmbuild' > ~/.rpmmacros

# cd ~/rpmbuild/SOURCES
git clone https://github.com/nic-instruction/custom-nrpe-2019
cd custom-nrpe-2019/
cp custom-nrpe-2019/nti-320-plugins-0.1.tar.gz .
cp custom-nrpe-2019/plugins/check_ldaps_cert_expiry.sh .
cp custom-nrpe-2019/nti-320-plugins.spec .
mv nti-320-plugins.spec ../SPECS
# cd ..
# rpmbuild -v -bb --clean SPECS/hello.spec
#ls -l RPMS/x86_64/helloworld-0.1-1.el7.x86_64.rpm
# yum -y install RPMS/x86_64/helloworld-0.1-1.el7.x86_64.rpm
# ls -l /
 

# cd /root/rpmbuild/SOURCES/
# wget http://downloads.xiph.org/releases/icecast/icecast-2.3.3.tar.gz
# git clone https://github.com/NagiosEnterprises/nrpe.git                       # Get the nrpe source from github
# git clone https://github.com/NagiosEnterprises/nagioscore.git                 # Get the nagios source from github

# tar -czvf nrpe-3.1.tar.gz /root/rpmbuild/SOURCES/nrpe                         # Tar up source (needed to create an RPM)
# tar -czvf nagioscore-4.3.1.tar.gz /root/rpmbuild/SOURCES/nagioscore           # Tar up source (needed to create an RPM)

# mv nagioscore nagioscore-4.3.1                                                # Clean up source dir by making a dirrectory
# mv nrpe nrpe-3.1                                                              # structure that will allow us to have multiple
# mkdir nagioscore                                                              # versions of source code
# mkdir nrpe
# mv nagioscore-4.3.1 nagioscore
# mv nrpe-3.1 nrpe

# cd ../SPECS                                                                   # head to the SPECS directory
# cp /usr/share/vim/vimfiles/template.spec .                                    # copy a template .spec file over from /usr/share
