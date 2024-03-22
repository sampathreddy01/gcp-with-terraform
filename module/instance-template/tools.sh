#!/bin/bash
# export INSTZONE=$(curl http://metadata.google.internal/computeMetadata/v1/instance/zone -H "Metadata-Flavor: Google")
# export ZONE=`basename $INSTZONE`
# export INSTIP=`gcloud compute addresses list --filter=name:mq01-$ZONE-ip --format="value(address:label=address)"`
# export INSTNAME=$(curl http://metadata.google.internal/computeMetadata/v1/instance/name -H "Metadata-Flavor: Google")
# gcloud compute instances network-interfaces update $INSTNAME --zone=$ZONE --aliases="$INSTIP/32"
# ip addr add $INSTIP/32 dev eth0

sudo mkdir -p /mnt/disks/MY_DIR
sudo mount  /dev/sdb2 /mnt/sdb2
# sudo chmod a+w /mnt/disks/MY_DIR
cd /mnt/sdb2
touch new.txt
sudo mkdir -p new_test_folder
cd new_test_folder
touch hello.java

sudo mkdir -p /test/files
cd /test/files
touch test.json

#curl-install
sudo yum install curl -y

#install-wget
sudo yum install wget -y

# # #install-java8
sudo yum install java-1.8.0-openjdk-devel -y

#install-java11
sudo yum install java-11-openjdk-devel -y

#install python3
yum install python3 -y

#install ruby
sudo yum install ruby -y

#install screen
yum install screen -y

#install SqlMap
yum install python3 pip -y
sudo pip3 install sqlmap

#install tcpdump
yum install tcpdump -y

#install nmap
yum install nmap -y

#install metasploit
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
chmod +x msfinstall
./msfinstall

#install hexedit
sudo yum install hexedit -y 

#install nikto
yum install nikto -y

sleep 2m