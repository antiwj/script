#!/bin/bash
apt update -y && apt upgrade -y && apt autoremove -y
apt install ufw vim curl -y > /dev/null
yes | ufw enable > /dev/null
ufw default deny incoming
ufw default deny outgoing
port=22
read -p "Enter your ssh Port (default 22): " port
ufw allow $port > /dev/null
ufw reload > /dev/null
mkdir -p /root/.ssh
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC7qHL3Mp5G+6WowFTb0waDTEY5TsFeQVByijmmBaA0bIqDAtDMX753RFAKvqxsHr523ZA+6kXhw/paVy6niu6iTIlDxWecfVzs3NeyMxA4invkf7dXHIeyjHwWvwt+EAGW5GxPI9gLyUNuntarYsBA/5rA23Y8QPdTDPYhWg9ggabHOZBlAc96oxoEZzK+qDJozjO2caxE7oeEHB5pTjRJT+VUS6IukQ/cK+C+PVGfAmCjflk/1QiugT9l8gZsy2QJ3Lk0r2bWJTnpwDlfC8wK52FVwaaDAprNZt5v6QiyGOfRHbe/ZYXKJUEHjrSRccjgZ9TgrEnLPD57UXQCk+URVdumM+lBOfNpBEH3ISfO0KFO7qgF5H2XOzAaV+PYQ77+7aToqa/1d6BJ8eVTwgUeQKkKdB0P52DKpv7XjwwBpE88HZKHbBSy6xdmtJ9dvQtPwWnv6ddIvGVZjJ2QnMFi+nzfmnMrrXc2EPtqmHhEGiPZvVgQNJlcZjcUv5sAZwM= root@instance-20220424-2300' >> /root/.ssh/authorized_keys
echo 'PermitRootLogin prohibit-password' >> /etc/ssh/sshd_config
echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config
systemctl restart sshd
