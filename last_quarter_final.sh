#!/bin/bash
###Clients, NFS server, and rsyslog server does NOT need the https and https tags!!!!!!!
# sudo su
# yum install git
# yum install wget


################
# Servers
################

###########
# SysLog
###########
gcloud config set project NTI-320
gcloud compute instances create rsyslog-server-final \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-east1-b \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=rsyslog-server.sh


#############
# Postgres
#############
gcloud compute instances create postgres-final \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-west1-a \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=postgres1.sh

############
# LDAP Server
############
gcloud compute instances create ldap-server-final \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-west1-a \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=LDAP-automate.sh

#############
# NFS Server
#############
gcloud compute instances create nfs-server-final \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-west1-a \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nfs-server-automate.sh

#############
# Django Server
##############
gcloud compute instances create django-server-final \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-west1-a \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=django-server.sh

##############
# Clients
##############

gcloud compute instances create ldap-client-final \
--image-family ubuntu-1804-lts \
--image-project ubuntu-os-cloud \
--zone us-west1-a \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=LDAP-client.sh

gcloud compute instances create nfs-client-final \
--image-family ubuntu-1804-lts \
--image-project ubuntu-os-cloud \
--zone us-west1-a \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nfs-clienta.sh
