#!/bin/bash
# This is a script meant to let us test NRPE
# plugins we write
cd /usr/lib/systemd/system
status=$(systemctl is-active postgresql.service)    # Determines if postgresql.service is inactive or active
status1=$(systemctl is-enabled postgresql.service)  # Determines if postgresql.service is disabled or enabled

if [ $status == "active" ]; then
    echo "STATUS:OK POSTGRES IS RUNNING"
    exit 0;
    
  elif [ $status == "inactive" ]; then
    echo "STATUS:CRITICAL POSTGRES IS DOWN"
    exit 2;
    
  elif [ $status1 == "disabled" ] ; then
    echo "STATUS:WARNING POSTGRES IS DISABLED"
    exit 1;
    
else
   echo "STATUS:UNKNOWN"
   exit 3;
f
