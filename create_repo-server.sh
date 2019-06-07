#!/bin/bash

yum -y install createrepo                                                          # Install createrepodd

mkdir -p /repos/centos/7/extras/x86_64/Packages/                                   # Make your repo dir

##copy from build
##suggested to copy from build server to NFS and create share for other servers
##or can cp to home, scp to cloud cli, and scp to repo-server
##create the rpm on build server and then copy to home directory of build server
##cp /root/rpmbuild/RPMS/x86_64/helloworld-0.1-1.el7.x86_64.rpm /home/g42dfyt/
##chown it to be owned by you
##chown g42dfyt /home/g42dfyt/helloworld-0.1-1.el7.x86_64.rpm
##go to google cloud command line
##gcloud compute scp g42dfyt@build-a:/home/g42dfyt/helloworld-0.1-1.el7.x86_64.rpm .
#Did you mean zone [us-west1-a] for instance: [build-a] (Y/n)?  n
##gcloud compute scp helloworld-0.1-1.el7.x86_64.rpm g42dfyt@repo-serv:/home/g42
##dfyt
##Did you mean zone [us-west1-a] for instance: [repo-serv] (Y/n)?  n
cp helloworld-0.1-1.el7.x86_64.rpm /repos/centos/7/extras/x86_64/Packages   # Nicole will provide this package to us on the day of the final

createrepo --update /repos/centos/7/extras/x86_64/Packages/                        # Update after every change




yum -y install httpd                                                              # Now install apache so you can serve your repo over the web

##disable selinux
setenforce 0

systemctl enable httpd

systemctl start httpd
##cretae symbolic link between repo centos and web centos
##/var/www/ centos points to repos
ln -s  /repos/centos /var/www/html/centos                                         # Link your repos in
##always copy config files to .bak before editting
cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.bak                      # Make a copy of our origonal httpd.conf

sed -i '144i     Options All' /etc/httpd/conf/httpd.conf;                          # Configure apache
sed -i '145i    # Disable directory index so that it will index our repos' /etc/httpd/conf/httpd.conf;
sed -i '146i     DirectoryIndex disabled' /etc/httpd/conf/httpd.conf;

sed -i 's/^/#/' /etc/httpd/conf.d/welcome.conf                                    # Disables the defualt welcome page in the recommended way

##-R makes recursive chown
chown -R apache:apache /repos/

systemctl restart httpd


# At this point you should be able to see your repository structure when you hit the website

# Last step is to configure your new yum repository on a client:
