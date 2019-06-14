#! /bin/bash

   
    sudo su  
    yum -y install python-pip
    pip install virtualenv
    pip install --upgrade pip
    ##mkdir and cd into
    mkdir /opt/django
    cd /opt/django/
    yum install python36
    virtualenv -p python36 django
    ##still in 2.7.5 && need to source to 3.6
    python --version
    source django/bin/activate
    pip install django
    django-admin --version    
    ##start project
    django-admin startproject project1
    ##change ownership from root to a user
    chown -R <user> django 
    chown -R <user> project1
    su - <user>  
    ##activate django install and run server
    source /opt/django/django/bin/activate
    /opt/django/project1/manage.py runserver 0.0.0.0:8000&
    
sudo yum update -y && yum install -y rsyslog 	#CentOS 7
sudo systemctl start rsyslog
sudo systemctl enable rsyslog
#on the client
#add to end of file
echo "*.* @@rsyslog-server-final:514" >> /etc/rsyslog.conf
sudo systemctl status rsyslog
tail -f /var/log/messages
