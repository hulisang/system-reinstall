#!/bin/sh

MAINIP=$(ip route get 1 | awk '{print $7;exit}')
GATEWAYIP=$(ip route | grep default | awk '{print $3}')
SUBNET=$(ip -o -f inet addr show | awk '/scope global/{sub(/[^.]+\//,"0/",$4);print $4}' | head -1 | awk -F '/' '{print $2}')
value=$(( 0xffffffff ^ ((1 << (32 - $SUBNET)) - 1) ))
NETMASK="$(( (value >> 24) & 0xff )).$(( (value >> 16) & 0xff )).$(( (value >> 8) & 0xff )).$(( value & 0xff ))"

wget --no-check-certificate -qO network-reinstall.sh 'https://down.vpsaff.net/linux/dd/network-reinstall.sh' && chmod a+x network-reinstall.sh

#Disabled SELinux
if [ -f /etc/selinux/config ]; then
	SELinuxStatus=$(sestatus -v | grep "SELinux status:" | grep enabled)
	[[ "$SELinuxStatus" != "" ]] && setenforce 0
fi

clear
echo "                                                              "
echo "##############################################################"
echo "#                                                            #"
echo "#  Network reinstall OS                                      #"
echo "#                                                            #"
echo "#  Last Modified: 2022-07-08                                 #"
echo "#  Linux默认密码：hxc1314520                               #"
echo "#  Supported by hulisang                                 #"
echo "#                                                            #"
echo "##############################################################"
echo "                                                              "
echo "IP: $MAINIP/$SUBNET"
echo "网关: $GATEWAYIP"
echo "网络掩码: $NETMASK"
echo ""
echo "请选择您需要的镜像包:"
echo "  0) 升级本脚本"
echo "  1) Debian 9（Stretch） 用户名：root 密码：hxc1314520"
echo "  2) Debian 10（Buster） 用户名：root 密码：hxc1314520"
echo "  3) Debian 11（Bullseye）用户名：root 密码：hxc1314520 ,推荐1G内存以上使用"
echo "  4) CentOS 7 x64 (DD) 用户名：root 密码：Pwd@CentOS"
echo "  5) CentOS 7 用户名：root 密码：hxc1314520, 要求2G RAM以上才能使用"
echo "  6) Ubuntu 16.04 LTS (Xenial Xerus) 用户名：root 密码：hxc1314520"
echo "  7) Ubuntu 18.04 LTS (Bionic Beaver) 用户名：root 密码：hxc1314520"
echo "  8) Ubuntu 20.04 LTS (Focal Fossa) 用户名：root 密码：hxc1314520 ,推荐2G内存以上使用"
echo "  9) Fedora 32 用户名：root 密码：hxc1314520, 要求2G RAM以上才能使用"
echo "  10) Fedora 33 用户名：root 密码：hxc1314520, 要求2G RAM以上才能使用"
echo "  11) Fedora 34 用户名：root 密码：hxc1314520, 要求2G RAM以上才能使用"
echo "  12) Fedora 35 用户名：root 密码：hxc1314520, 要求2G RAM以上才能使用"
echo "  13) RockyLinux 8 用户名：root 密码：hxc1314520, 要求2G RAM以上才能使用"
echo "  14) AlmaLinux 8 用户名：root 密码：hxc1314520, 要求2G RAM以上才能使用"
echo "  自定义安装请使用：bash network-reinstall.sh -dd '您的直连'"
echo ""
echo -n "请输入编号: "
read N
case $N in
  0) wget --no-check-certificate -qO network-reinstall-os.sh "https://down.vpsaff.net/linux/dd/network-reinstall-os.sh" && chmod +x network-reinstall-os.sh && wget --no-check-certificate -qO network-reinstall.sh 'https://down.vpsaff.net/linux/dd/network-reinstall.sh' && chmod a+x network-reinstall.sh ;;
  1) bash network-reinstall.sh -d 9 -p hxc1314520 ;;
  2) bash network-reinstall.sh -d 10 -p hxc1314520 ;;
  3) bash network-reinstall.sh -d 11 -p hxc1314520 ;;
  4) echo "Password: Pwd@CentOS" ; read -s -n1 -p "Press any key to continue..." ; bash network-reinstall.sh -dd 'https://down.vpsaff.net/linux/dd/images/centos-7-image' ;;
  5) bash network-reinstall.sh -c 7 -p hxc1314520 ;;
  6) bash network-reinstall.sh -u 16.04 -p hxc1314520 ;;
  7) bash network-reinstall.sh -u 18.04 -p hxc1314520 ;;
  8) bash network-reinstall.sh -u 20.04 -p hxc1314520 ;;
  9) bash network-reinstall.sh -f 32 -p hxc1314520 ;;
  10) bash network-reinstall.sh -f 33 -p hxc1314520 ;;
  11) bash network-reinstall.sh -f 34 -p hxc1314520 ;;
  12) bash network-reinstall.sh -f 35 -p hxc1314520 ;;
  13) bash network-reinstall.sh -r 8 -p hxc1314520 ;;
  14) bash network-reinstall.sh -a 8 -p hxc1314520 ;;
  *) echo "Wrong input!" ;;
esac