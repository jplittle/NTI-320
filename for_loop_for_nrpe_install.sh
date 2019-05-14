for servername in $( gcloud compute instances list | awk '{print $1}' | sed "1 d" | grep -v nagios-a );  do 

    gcloud compute ssh --zone us-east4-c jamesplittle25@$servername --command='sudo wget https://raw.githubusercontent.com/jplittle/NTI-320/master/nrpe_install.sh'

done
#sudo yum -y install wget && 
