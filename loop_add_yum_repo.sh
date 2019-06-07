#!/bin/bash
# this is a script to add a yum repo on a given server/client.
#add to existing repos (ls /etc/yum.repos.d)dd

##repo server ip
ip="10.150.0.25"                                                    # Please replace with your repo server IP

#vim /etc/yum.repos.d/epel.repo
echo "[nti-320]
name=Extra Packages for Centos from NTI-320 7 - $basearch
#baseurl=http://download.fedoraproject.org/pub/epel/7/$basearch <- example epel repo
# Note, this is putting repodata at packages instead of 7 and our path is a hack around that.
baseurl=http://$ip/centos/7/extras/x86_64/Packages/
enabled=1
gpgcheck=0
" >> /etc/yum.repos.d/NTI-320.repo                                  
                                                                    # Now that the repo is added, list all repos and make sure
                                                                    # it shows up without error
yum repolist

isokay=`yum search "hello world" | grep "Matched: hello world"`

if [ -z "$isokay" ]; then
   echo "There's somthing wrong with your repo... check yum repolist to see if it shows up then try installing a package"
else
   echo "All is well and we found your test package: $isokay"   
fi
