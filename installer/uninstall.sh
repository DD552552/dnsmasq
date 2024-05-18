 #!/bin/sh
echo -e "\e[1;36m 开始卸载ADSS\e[0m"
echo 
if [ -f /var/lock/opkg.lock ]; then
  rm -f /var/lock/opkg.lock
fi
echo -e "\e[1;31m 删除残留文件夹以及配置 \e[0m"
echo 
rm -rf /usr/share/adss /etc/dnsmasq.d/*adss* /tmp/dnsmasq.d/*adss*
echo -e "\e[1;31m 删除相关计划任务\e[0m"
echo 
if [ -f /etc/crontabs/$USER-adss.bak ]; then
  mv -f /etc/crontabs/$USER-adss.bak /etc/crontabs/$USER
fi
/etc/init.d/cron reload > /dev/null 2>&1
echo -e "\e[1;31m 重启dnsmasq服务\e[0m"
killall dnsmasq > /dev/null 2>&1
/etc/init.d/dnsmasq restart > /dev/null 2>&1
rm -rf /tmp/adss
