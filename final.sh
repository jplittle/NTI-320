

#!/bin/bash
###Clients, NFS server, and rsyslog server does NOT need the https and https tags!!!!!!!
# sudo su
# yum install git
# yum install wget
#--private-network-ip=10.128.0.5

################
# Servers
################

###########
# SysLog
###########
gcloud compute instances create rsyslog-server-final \
--private-network-ip=10.150.0.5 \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-east4-c \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=rsyslog-server.sh


#############
# Postgres
#############
gcloud compute instances create postgres-final \
--private-network-ip=10.150.0.6 \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-east4-c \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=postgres1.sh

############
# LDAP Server
############
gcloud compute instances create ldap-server-final \
--private-network-ip=10.150.0.7 \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-east4-c \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=LDAP-automate.sh

#############
# NFS Server
#############
gcloud compute instances create nfs-server-final \
--private-network-ip=10.150.0.8 \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-east4-c \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nfs-server-automate.sh

#############
# Django Server
##############
gcloud compute instances create django-server-final \
--private-network-ip=10.150.0.9 \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-east4-c \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=django-server.sh
