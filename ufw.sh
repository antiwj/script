#!/bin/bash
apt update -y && apt uipgrade -yq && apt autoremove -y
apt install vim curl ufw -y
yes | ufw enable
ufw default deny incoming
ufw default allow outgoing
ufw reload
ufw allow 22
ufw reload
read -p "Enter the ssh port which you want to set: " port
host=null
read -p "Enter your bashtion IP:(q to quit) " host
while [ $bashtion != q ]
do
	echo -e "Bashtion Host IP is this: \n" $host
	ufw allow from $host to any port $port > /dev/null
	read -p "Enter your bashtion IP:(q to quit) " host
done
sport=null
read -p "Enter the port which you want to open to anyone:(q to quit) " sport
while [ $sport != q ]
do
        echo -e "Port is : \n" $sport
        ufw allow  $sport > /dev/null
        read -p "Enter the port which you want to open to anyone:(q to quit) " sport
done
ufw allow from 173.245.48.0/20 to any port 80 > /dev/null
ufw allow from 173.245.48.0/20 to any port 443 > /dev/null
ufw allow from 103.21.244.0/22 to any port 80 > /dev/null
ufw allow from 103.21.244.0/22 to any port 443 > /dev/null
ufw allow from 103.22.200.0/22 to any port 80 > /dev/null
ufw allow from 103.22.200.0/22 to any port 443 > /dev/null
ufw allow from 103.31.4.0/22 to any port 80 > /dev/null
ufw allow from 103.31.4.0/22 to any port 443 > /dev/null
ufw allow from 141.101.64.0/18 to any port 80 > /dev/null
ufw allow from 141.101.64.0/18 to any port 443 > /dev/null
ufw allow from 108.162.192.0/18 to any port 80 > /dev/null
ufw allow from 108.162.192.0/18 to any port 443 > /dev/null
ufw allow from 190.93.240.0/20 to any port 80 > /dev/null
ufw allow from 190.93.240.0/20 to any port 443 > /dev/null
ufw allow from 188.114.96.0/20 to any port 80 > /dev/null
ufw allow from 188.114.96.0/20 to any port 443 > /dev/null
ufw allow from 197.234.240.0/22 to any port 80 > /dev/null
ufw allow from 198.41.128.0/17 to any port 80 > /dev/null
ufw allow from 162.158.0.0/15 to any port 80 > /dev/null
ufw allow from 104.16.0.0/13 to any port 80 > /dev/null
ufw allow from 104.24.0.0/14 to any port 80 > /dev/null
ufw allow from 172.64.0.0/13 to any port 80 > /dev/null
ufw allow from 131.0.72.0/22 to any port 80 > /dev/null
ufw allow from 2400:cb00::/32 to any port 80 > /dev/null
ufw allow from 2606:4700::/32 to any port 80 > /dev/null
ufw allow from 2803:f800::/32 to any port 80 > /dev/null
ufw allow from 2405:b500::/32 to any port 80 > /dev/null
ufw allow from 2405:8100::/32 to any port 80 > /dev/null
ufw allow from 2a06:98c0::/29 to any port 80 > /dev/null
ufw allow from 2c0f:f248::/32 to any port 80 > /dev/null
ufw allow from 197.234.240.0/22 to any port 443 > /dev/null
ufw allow from 198.41.128.0/17 to any port 443 > /dev/null
ufw allow from 162.158.0.0/15 to any port 443 > /dev/null
ufw allow from 104.16.0.0/13 to any port 443 > /dev/null
ufw allow from 104.24.0.0/14 to any port 443 > /dev/null
ufw allow from 172.64.0.0/13 to any port 443 > /dev/null
ufw allow from 131.0.72.0/22 to any port 443 > /dev/null
ufw allow from 2400:cb00::/32 to any port 443 > /dev/null
ufw allow from 2606:4700::/32 to any port 443 > /dev/null
ufw allow from 2803:f800::/32 to any port 443 > /dev/null
ufw allow from 2405:b500::/32 to any port 443 > /dev/null
ufw allow from 2405:8100::/32 to any port 443 > /dev/null
ufw allow from 2a06:98c0::/29 to any port 443 > /dev/null
ufw allow from 2c0f:f248::/32 to any port 443 > /dev/null
ufw deny 22  > /dev/null
ufw reload > /dev/null
echo "That's your ufw rules:"
ufw status
mkdir -p /root/.ssh 
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDI3I3lZleT0wkrBwUWBNXhdecpLdF91AgeEKWDKaXiNOrg6DAe9tyOfpFIaxx1ek+H7Qc+TzShY/WUG/D7STlamWP6lKiV8U3WQkhq8ez0rVkXaDsv7RbaGpmbrENZCGrIJIVu4qk7xDkzxIaG6hJCiR+/HVGkwT+nHvAeYDhHo7fqXaYD0TeMpL4dfnZkUtzzNO+LK95ggQX4a69VTAy7dEihaNZ4ENcK5IBdrydJDafVL/Uo8NEDEaSYlUv9WKIb5dpmqJyvXPbfPh/pntGlrJGlItWZBIp7tPD3B4j4JRF4nkegPGorDDLEdmk/B3L4r11uW4ssC16VA2YLaHiN root@requactblack.ga' >> /root/.ssh/authorized_keys
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDVly2zvIA9bgGZF6dxxSp9N1mA8XPFNnTujj35OsIUpUgMH/EKjKw8/VZbHtdzrgvFnvCL/C0OTpSZSeXw/azlorSfCTP2xlww0IgzJaboRKZLqDvU9QNRQPBoihzIxEIqH0a4G6bEWQtq1ajevdGPBuljnmMRYxnOYpLJf4Lw+h87sNIRnjNg8Actf7RHE6Xp6m9AvhO7YqkvvdixTuJK8H9h/tZIDfJfbU5m9uFPS6hJQQbyc1T0wTMknjTGNkjz9a2fi9+ZPtEHpVZoUC2aE02SP/ZtQxRLI6fN03C5EWQTjRFXx2EjIh3470C59tJUIrg3i8AsW26f32EdIQVD root@requactblack.ga' >> /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys
echo 'PermitRootLogin prohibit-password' >> /etc/ssh/sshd_config
systemctl restart sshd
