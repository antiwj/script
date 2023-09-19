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
echo 'Port $port' >> /etc/ssh/sshd_config
host=null
read -p "Enter your bashtion IP:(q to quit) " host
while [ $host != q ]
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
ufw deny 22  > /dev/null
ufw reload > /dev/null
echo "That's your ufw rules:"
ufw status
mkdir -p /root/.ssh 
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDI3I3lZleT0wkrBwUWBNXhdecpLdF91AgeEKWDKaXiNOrg6DAe9tyOfpFIaxx1ek+H7Qc+TzShY/WUG/D7STlamWP6lKiV8U3WQkhq8ez0rVkXaDsv7RbaGpmbrENZCGrIJIVu4qk7xDkzxIaG6hJCiR+/HVGkwT+nHvAeYDhHo7fqXaYD0TeMpL4dfnZkUtzzNO+LK95ggQX4a69VTAy7dEihaNZ4ENcK5IBdrydJDafVL/Uo8NEDEaSYlUv9WKIb5dpmqJyvXPbfPh/pntGlrJGlItWZBIp7tPD3B4j4JRF4nkegPGorDDLEdmk/B3L4r11uW4ssC16VA2YLaHiN root@requactblack.ga' >> /root/.ssh/authorized_keys
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDVly2zvIA9bgGZF6dxxSp9N1mA8XPFNnTujj35OsIUpUgMH/EKjKw8/VZbHtdzrgvFnvCL/C0OTpSZSeXw/azlorSfCTP2xlww0IgzJaboRKZLqDvU9QNRQPBoihzIxEIqH0a4G6bEWQtq1ajevdGPBuljnmMRYxnOYpLJf4Lw+h87sNIRnjNg8Actf7RHE6Xp6m9AvhO7YqkvvdixTuJK8H9h/tZIDfJfbU5m9uFPS6hJQQbyc1T0wTMknjTGNkjz9a2fi9+ZPtEHpVZoUC2aE02SP/ZtQxRLI6fN03C5EWQTjRFXx2EjIh3470C59tJUIrg3i8AsW26f32EdIQVD root@requactblack.ga' >> /root/.ssh/authorized_keys
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC7qHL3Mp5G+6WowFTb0waDTEY5TsFeQVByijmmBaA0bIqDAtDMX753RFAKvqxsHr523ZA+6kXhw/paVy6niu6iTIlDxWecfVzs3NeyMxA4invkf7dXHIeyjHwWvwt+EAGW5GxPI9gLyUNuntarYsBA/5rA23Y8QPdTDPYhWg9ggabHOZBlAc96oxoEZzK+qDJozjO2caxE7oeEHB5pTjRJT+VUS6IukQ/cK+C+PVGfAmCjflk/1QiugT9l8gZsy2QJ3Lk0r2bWJTnpwDlfC8wK52FVwaaDAprNZt5v6QiyGOfRHbe/ZYXKJUEHjrSRccjgZ9TgrEnLPD57UXQCk+URVdumM+lBOfNpBEH3ISfO0KFO7qgF5H2XOzAaV+PYQ77+7aToqa/1d6BJ8eVTwgUeQKkKdB0P52DKpv7XjwwBpE88HZKHbBSy6xdmtJ9dvQtPwWnv6ddIvGVZjJ2QnMFi+nzfmnMrrXc2EPtqmHhEGiPZvVgQNJlcZjcUv5sAZwM= root@instance-20220424-2300' >> /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys
echo 'PermitRootLogin prohibit-password' >> /etc/ssh/sshd_config
systemctl restart sshd
