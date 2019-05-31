#!/bin/bash
# This is a script meant to let us test NRPE
# plugins we write
cd /usr/lib/systemd/system
status=$(systemctl is-active postgresql.service)    # Determines if postgresql.service is inactive or active
status1=$(systemctl is-enabled postgresql.service)  # Determines if postgresql.service is disabled or enabled

if  [ $status1 == "disabled" ] ; then                              # The if and elif order of checks matters. For example, if variable 
                                                                   # $status is checked first in the if loop instead of $status1, the script
                                                                   # will issue that postgress is running...but if someone were to disable postgres
                                                                   # this would issue a false postive ( postgres running, but recently disabled ).
    echo "STATUS:WARNING POSTGRES IS DISABLED"
    exit 1;
    
  elif [ $status == "active" ]; then
    echo "STATUS:OK POSTGRES IS RUNNING"
    exit 0;
    
  elif [ $status == "inactive" ]; then
    echo "STATUS:CRITICAL POSTGRES IS DOWN"
    exit 2;
    
else
   echo "STATUS:UNKNOWN"
   exit 3;
fi
