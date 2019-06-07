#!/bin/bash
# This should be the finishing script for a micro with a 50G hard drive

yum -y install rpm-build make gcc git                                         # install rpm tools, compiling tools and source tools
mkdir -p /root/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}                      # create the rpmbuild dirrectory structure 
                                                                              # (the docs say this happens by default, this is incorrect on centos 7)
cd ~/
echo '%_topdir %(echo $HOME)/rpmbuild' > ~/.rpmmacros                         # Set the rpmbuild path in an .rpmmacros file
cd ~/rpmbuild/SOURCES
###Not needed but to better automate what is needed
git clone https://github.com/nic-instruction/NTI-320.git
cd NTI-320/
cp NTI-320/rpm-info/hello_world_from_source/helloworld-0.1.tar.gz .
cp NTI-320/rpm-info/hello_world_from_source/helloworld.sh .
cp NTI-320/rpm-info/hello_world_from_source/hello.spec .
mv hello.spec ../SPECS
cd ..
##builds rpm
##want to exit with 0
rpmbuild -v -bb --clean SPECS/hello.spec

##did it work?
#ls -l RPMS/x86_64/helloworld-0.1-1.el7.x86_64.rpm

yum -y install RPMS/x86_64/helloworld-0.1-1.el7.x86_64.rpm

##did it work?
#ls -l /



#git clone https://github.com/NagiosEnterprises/nrpe.git                       # Get the nrpe source from github
#git clone https://github.com/NagiosEnterprises/nagioscore.git                 # Get the nagios source from github

#tar -czvf nrpe-3.1.tar.gz /root/rpmbuild/SOURCES/nrpe                         # Tar up the source (needed to create an RPM)
#tar -czvf nagioscore-4.3.1.tar.gz /root/rpmbuild/SOURCES/nagioscore           # Tar up the source (needed to create an RPM)

#mv nagioscore nagioscore-4.3.1                                                # Clean up our source dir by making a dirrectory
#mv nrpe nrpe-3.1                                                              # structure that will allow us to have multiple
#mkdir nagioscore                                                              # versions of our source code
#mkdir nrpe
#mv nagioscore-4.3.1 nagioscore
#mv nrpe-3.1 nrpe

#cd ../SPECS                                                                   # head to the SPECS directory
#cp /usr/share/vim/vimfiles/template.spec .                                    # copy a template .spec file over from /usr/share
