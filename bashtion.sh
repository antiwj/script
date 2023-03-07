#!/bin/bash
host=null
port=22
read -p "Enter your target host (q to quit) and ssh port (default 22),space between your host and port : " host port
localport=11001
while [ $host != q ]
do
	ssh -A -fCNL *:$localport:$host:$port localhost -p $bhost -i /root/.ssh/bashtion
	ufw allow $localport > /dev/null
	localport=`expr $localport + 1`
	echo -e "\033[33m $localhost:$localport \033[0m\t That's your host ssh tunnel"
	read -p "Enter your target host (q to quit) and ssh port (default 22),space between your host and port : " host port
done
