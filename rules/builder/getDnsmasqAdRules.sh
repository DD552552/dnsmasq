 #!/bin/sh
echo -e "\e[1;36m 开始下载Dnsmasq广告规则\e[0m"
echo 
echo -e "\e[1;36m 下载anti-AD广告规则\e[0m"
curl "https://raw.gitmirror.com/privacy-protection-tools/anti-AD/master/adblock-for-dnsmasq.conf" -sLSo /tmp/adss/antiAD.conf
sed -i 's/$/&127.0.0.1/g' /tmp/adss/antiAD.conf
echo 
echo -e "\e[1;36m 下载Cats-Team广告规则\e[0m"
curl "https://raw.gitmirror.com/Cats-Team/AdRules/main/smart-dns.conf" -sLSo /tmp/adss/cats.conf
sed -i "s/\/#/\/127.0.0.1/g" /tmp/adss/cats.conf
sed -i "s/address \//address=\//g" /tmp/adss/cats.conf
echo 
echo -e "\e[1;36m 下载notrackAd广告规则,文件较大请耐心等待\e[0m"
curl "https://raw.gitmirror.com/notracking/hosts-blocklists/master/domains.txt" -sLSo /tmp/adss/notrackAdDomain.conf
echo 
echo -e "\e[1;36m 下载neodevhost广告规则\e[0m"
curl https://neodev.team/dnsmasq.conf -sLSo /tmp/adss/neodevhost.conf
echo 
sleep 3
echo -e "\e[1;36m 创建广告黑名单缓存\e[0m"
curl https://raw.gitmirror.com/clion007/adss/master/rules/adss/adblacklist -sLSo /tmp/adss/adblacklist
awk '!a[$0]++{print}' /tmp/adss/adblacklist > /tmp/adss/blacklist 
rm -rf /tmp/adss/adblacklist
sed -i '/./{s|^|address=/|;s|$|/127.0.0.1|}' /tmp/adss/blacklist #支持通配符
echo 
echo -e "\e[1;36m 合并规则缓存\e[0m"
cat /tmp/adss/antiAD.conf /tmp/adss/notrackAdDomain.conf /tmp/adss/cats.conf /tmp/adss/neodevhost.conf /tmp/adss/blacklist >> /tmp/adss/dnsAd 
echo 
echo -e "\e[1;36m 删除dnsmasq临时文件\e[0m"
rm -rf /tmp/adss/antiAD.conf /tmp/adss/notrackAdDomain.conf /tmp/adss/cats.conf /tmp/adss/neodevhost.conf /tmp/adss/blacklist
echo 
echo -e "\e[1;36m 删除注释和本地规则\e[0m"
sed -i '/localhost/d' /tmp/adss/dnsAd # 删除本地规则
sed -i 's/^#/d' /tmp/adss/dnsAd # 删除注释行
sed -i 's/#.*//g' /tmp/adss/dnsAd # 删除行尾注释
sed -i '/^$/d' /tmp/adss/dnsAd # 删除空行
echo 
echo -e "\e[1;36m 统一广告规则格式\e[0m"
sed -i "s/\/0.0.0.0/\/127.0.0.1/g" /tmp/adss/dnsAd
sed -i "s/[ ][ ]*/ /g" /tmp/adss/dnsAd # 删除多余空格，只保留一个空格
