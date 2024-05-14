#!/bin/sh
wget --no-check-certificate https://gitcode.net/clion007/adss/raw/master/adss.sh -qO \
	/tmp/adss/adss.sh && chmod 775 /tmp/adss/adss.sh
if [ -s "/tmp/adss/adss.sh" ]; then
	source /tmp/adss/adss.sh && show_copyright
else
	echo
	echo -e "\e[1;36m  `date +'%Y-%m-%d %H:%M:%S'`: 网络异常，放弃本次更新。\e[0m"
	echo
	exit 1
fi
echo
echo -e "\e[1;36m 开始检测更新脚本及规则\e[0m"
echo
wget --no-check-certificate https://gitcode.net/clion007/adss/raw/master/updater/update.sh -qO \
      /tmp/adss/update.sh && chmod 775 /tmp/adss/update.sh
wget --no-check-certificate https://gitcode.net/clion007/adss/raw/master/updater/rules_update.sh -qO \
      /tmp/adss/rules_update.sh && chmod 775 /tmp/adss/rules_update.sh
if [ -s "/tmp/adss/update.sh" -a -s "/tmp/adss/rules_update.sh" ]; then
	if ( ! cmp -s /tmp/adss/update.sh /usr/share/adss/update.sh ); then
		echo " `date +'%Y-%m-%d %H:%M:%S'`: 检测到新版升级脚本......3秒后即将开始更新！"
		echo
		sleep 3
		echo -e "\e[1;36m 开始更新升级脚本\e[0m"
		mv -f /tmp/adss/update.sh /usr/share/adss/update.sh
		echo
		sh /usr/share/adss/update.sh
		echo " `date +'%Y-%m-%d %H:%M:%S'`: 升级脚本更新完成。"
		echo
	elif ( ! cmp -s /tmp/adss/rules_update.sh /usr/share/adss/rules_update.sh ); then
		echo " `date +'%Y-%m-%d %H:%M:%S'`: 检测到新版规则升级脚本......3秒后即将开始更新！"
		echo
		sleep 3
		echo -e "\e[1;36m 开始更新规则升级脚本\e[0m"
		mv -f /tmp/adss/rules_update.sh /usr/share/adss/rules_update.sh
		echo
		sh /usr/share/adss/rules_update.sh
		echo " `date +'%Y-%m-%d %H:%M:%S'`: 规则升级脚本更新完成。"
		echo
	else
		echo " `date +'%Y-%m-%d %H:%M:%S'`: 脚本已为最新，开始检测规则更新"
		echo
		sh /usr/share/adss/rules_update.sh
		echo " `date +'%Y-%m-%d %H:%M:%S'`: 规则已经更新完成。"
		echo
	fi
else
	echo " `date +'%Y-%m-%d %H:%M:%S'`: 脚本文件下载异常，放弃本次更新。"
	echo
	rm -rf /tmp/adss
	exit 1;
fi
rm -rf /tmp/adss
exit 0