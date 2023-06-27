#!/bin/bash
# update
apt update -y && apt upgrade -yq && apt autoremove -y
# install vim curl ufw
apt install vim curl ufw -y
# enable ufw
yes | ufw enable
# setting ufw rules
ufw default deny incoming
ufw default allow outgoing
ufw reload

# allow cloudflare IPv4 access
for ip in 'curl https://www.cloudflare.com/ips-v4'
do 
	ufw allow from $ip to any port 80
	ufw allow from $ip to any port 443
done

# allow cloudflare IPv6 access
for ip in 'curl https://www.cloudflare.com/ips-v6'
do 
	ufw allow from $ip to any port 80
	ufw allow from $ip to any port 443
done

# allow bashtion access
read -p "输入堡垒机数量" bashtions
for ((i=1; i<=$bashtions; i++))
do
	read -p "输入堡垒机IP" bashtion_ip
	ufw allow from $bashtion_ip to any port 9411
done

# allow special port
echo "<CTRL-D> 退出"
while read -p "输入其他要开放的端口: " port
do
	ufw allow $port
done

ufw reload
echo "ufw 规则设置如下："
ufw status

# add ssh key
mkdir -p /root/.ssh 
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDI3I3lZleT0wkrBwUWBNXhdecpLdF91AgeEKWDKaXiNOrg6DAe9tyOfpFIaxx1ek+H7Qc+TzShY/WUG/D7STlamWP6lKiV8U3WQkhq8ez0rVkXaDsv7RbaGpmbrENZCGrIJIVu4qk7xDkzxIaG6hJCiR+/HVGkwT+nHvAeYDhHo7fqXaYD0TeMpL4dfnZkUtzzNO+LK95ggQX4a69VTAy7dEihaNZ4ENcK5IBdrydJDafVL/Uo8NEDEaSYlUv9WKIb5dpmqJyvXPbfPh/pntGlrJGlItWZBIp7tPD3B4j4JRF4nkegPGorDDLEdmk/B3L4r11uW4ssC16VA2YLaHiN root@requactblack.ga' > /root/.ssh/authorized_keys
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDVly2zvIA9bgGZF6dxxSp9N1mA8XPFNnTujj35OsIUpUgMH/EKjKw8/VZbHtdzrgvFnvCL/C0OTpSZSeXw/azlorSfCTP2xlww0IgzJaboRKZLqDvU9QNRQPBoihzIxEIqH0a4G6bEWQtq1ajevdGPBuljnmMRYxnOYpLJf4Lw+h87sNIRnjNg8Actf7RHE6Xp6m9AvhO7YqkvvdixTuJK8H9h/tZIDfJfbU5m9uFPS6hJQQbyc1T0wTMknjTGNkjz9a2fi9+ZPtEHpVZoUC2aE02SP/ZtQxRLI6fN03C5EWQTjRFXx2EjIh3470C59tJUIrg3i8AsW26f32EdIQVD root@requactblack.ga' >> /root/.ssh/authorized_keys
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC7qHL3Mp5G+6WowFTb0waDTEY5TsFeQVByijmmBaA0bIqDAtDMX753RFAKvqxsHr523ZA+6kXhw/paVy6niu6iTIlDxWecfVzs3NeyMxA4invkf7dXHIeyjHwWvwt+EAGW5GxPI9gLyUNuntarYsBA/5rA23Y8QPdTDPYhWg9ggabHOZBlAc96oxoEZzK+qDJozjO2caxE7oeEHB5pTjRJT+VUS6IukQ/cK+C+PVGfAmCjflk/1QiugT9l8gZsy2QJ3Lk0r2bWJTnpwDlfC8wK52FVwaaDAprNZt5v6QiyGOfRHbe/ZYXKJUEHjrSRccjgZ9TgrEnLPD57UXQCk+URVdumM+lBOfNpBEH3ISfO0KFO7qgF5H2XOzAaV+PYQ77+7aToqa/1d6BJ8eVTwgUeQKkKdB0P52DKpv7XjwwBpE88HZKHbBSy6xdmtJ9dvQtPwWnv6ddIvGVZjJ2QnMFi+nzfmnMrrXc2EPtqmHhEGiPZvVgQNJlcZjcUv5sAZwM= root@instance-20220424-2300' >> /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys
# change the way of root login 
echo 'PermitRootLogin prohibit-password' >> /etc/ssh/sshd_config
systemctl restart sshd

# install x-ui
echo "----------------------------开始安装x-ui----------------------------"
read -p "请输入x-ui用户名、密码以及端口，以空格符分开" xui_usrname xui_pw xui_port
echo -e "y\n$xui_usrname\n$xui_pw\n$xui_port\n" | bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh) > /dev/null 2>&1
echo "x-ui 安装完成，请结束后使用x-ui命令查看运行状态"

# install mtproxy
echo "----------------------------开始安装mtproxy----------------------------"
mkdir /home/mtproxy && cd /home/mtproxy
read -p "输入mtproxy端口: " mtp_port
echo -e "$mtp_port\n\n\n\n" | curl -s -o mtproxy.sh https://raw.githubusercontent.com/ellermister/mtproxy/master/mtproxy.sh && chmod +x mtproxy.sh && bash mtproxy.sh > /dev/null 2>&1
