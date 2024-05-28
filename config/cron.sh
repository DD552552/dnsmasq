#!/bin/sh
CRON_FILE=/etc/crontabs/$USER
grep "adss" $CRON_FILE > /dev/null
if [ ! $? -eq 0 ]; then
  echo -e "\e[1;31m 添加规则自动更新任务\e[0m"
  echo "# 每天 04:25 更新ADSS规则
25 4 * * * sh /usr/share/adss/update.sh > /dev/null 2>&1" >> $CRON_FILE
  echo 
  echo -e "\e[1;36m 设置网络不通重启任务\e[0m"
  echo 
  echo "# 每天 04:55 检测网络，如果不通重启路由器
55 4 * * * ping -c2 -w5 baidu.com || (touch /etc/banner && reboot)" >> $CRON_FILE
  /etc/init.d/cron reload > /dev/null
fi
