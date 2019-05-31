#!/bin/bash
# This is a script meant to let us test NRPE
# plugins we write

status=$(ps aux | grep -c "")                                  # Change the status to test different alert states

if [ $status -le 100" ]; then
    echo "STATUS:OK"
    exit 0;
    
  elif [ $status ge "150" ]; then
    echo "STATUS:CRITICAL"
    exit 2;
    
  elif [ $status gt "101" ] ; then
    echo "STATUS:WARNING"
    exit 1;
    
else
   echo "STATUS:UNKNOWN"
   exit 3;
fi
