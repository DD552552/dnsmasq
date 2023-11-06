# 超强大的dnsmasq防劫持去广告全自动脚本（ADSS）

**1、什么是ADSS？**

Auto DNS Smart Script，简称ADSS，是一个小巧，方便且全自动配置dnsmasq的工具，适用于家庭网络智能路由器端使用，配置简单、快速、免维护，它为家庭网络的路由器入口提供了可选择的基于dnsmasq的广告过滤功能和可选择的部分域名解析防污染功能。

**2、什么是Dnsmasq啊？**（转自百度百科）

DNSmasq是一个小巧且方便地用于配置DNS和DHCP的工具，适用于小型网络，它提供了DNS功能和可选择的DHCP功能。它服务那些只在本地适用的域名，这些域名是不会在全球的DNS服务器中出现的。DHCP服务器和DNS服务器结合，并且允许DHCP分配的地址能在DNS中正常解析，而这些DHCP分配的地址和相关命令可以配置到每台主机中，也可以配置到一台核心设备中（比如路由器），DNSmasq支持静态和动态两种DHCP配置方式。

**3、Dnsmasq有什么用？能为我解决什么**

默认的情况下，我们平时上网用的本地DNS服务器都是使用电信或者联通的，但是这样也导致了不少的问题，首当其冲的就是上网时经常莫名地弹出广告，或者莫名的流量被消耗掉导致网速变慢。其次是部分网站域名不能正常被解析，莫名其妙地打不开，或者时好时坏。
如果碰上不稳定的本地DNS，还可能经常出现无法解析的情况。除了要避免“坏”的DNS的影响，我们还可以利用DNS做些“好”事，例如管理局域网的DNS、给手机App Store加速、纠正错误的DNS解析记录、保证上网更加安全、去掉网页讨厌的广告等等。

**4、方案dnsmasq提供了什么？**

目前主要提供几个功能：
分域名DNS解析，提升加快不同网站的访问速度
国外域名加密解析自动扶墙，享受无墙的快感（已失效）
屏蔽恶心的运营商ip劫持、全面屏蔽广告
屏蔽掉大部分广告的hosts

写本脚本的缘由：

之前使用adbyby之类的插件严重影响网速，因此才想进一步优化通过dnsmasq和hosts优化屏蔽广告，通过各种努力的查找，终于找到一些更加完善的广告过滤dnsmasq和hosts规则，并进一步优化dnsmasq配置和计划任务的命令行和参数，加入著名的adbyby和ABP插件用的easylistchina规则，加入国外网站广告过滤malwaredomainlist规则，加入手机端著名广告过滤软件adaway用的规则。除了个别视频广告外（PC可以通过浏览器插件屏蔽），基本通过浏览器插件及adbyby等插件能屏蔽的广告应该都能屏蔽了。为了方便小白都能容易上手，已将所有代码编辑为全自动的sh脚本，运行一次，所有事情都搞定了。本人亲测，并已经通过测试。

重要提示：兲朝上网请通过https加密连接访问！该脚本和方法只适用于Openwrt系列内核的固件，包括但不限于pandorabox、LEDE、ddwrt、明月、石像鬼、newifi官方固件等，华硕、老毛子、梅林等Padavan系列固件请下载pavadan固件专用的脚本进行配置，tomato系列固件未经测试，且本人不太了解该固件，请慎用。本人用的是pandorabox最新稳定版，其它固件的可用性均由网友测试证实，并非本人亲测结果，仅供参考。如果不是以上所述的对应路由固件系统，小白就不用往下看了，以免浪费你宝贵的时间。如果你也愿意自己折腾，tomato、padavan等其它固件，可以参考 http://www.right.com.cn/forum/forum.php?mod=viewthread&tid=184121 帖子内容代码编写规则及文件目录架构自行修改我提供的代码适用到你的系统固件中，并欢迎联系我或上传到我的github线上项目分享出来造福后人，本人没有用这些固件，无法进行测试。

PS：
1.如果以前运行过类似脚本或命令，最好恢复出厂设置；
2.有的固件携带的wget命令不支持https下载，需要重装wget；
3.本脚本为路由使用，非交换机使用，如果你将路由器的lan口链接了上级路由器的lan口，此路由即变为交换机，无法使用本脚本，请在上级路由安装配置。

关于固件：7620的芯片，测试了各种固件，目前就潘多拉的的wifi驱动比较给力，其它的都很渣，不同芯片请自行测试，目前潘多拉的软件源已经恢复正常。此外，发现有一些固件（比如新版的pandorabox），在编译时自带了两个dnsmasq软件包，即dnsmasq和dnsmasq-full。同时两个都存在时，会导致DNS无法正常解析的问题，移除dnsmasq，保留dnsmasq-full，重启dnsmasq进程后解析恢复正常。

安装配置方法：
将下载的压缩包解压，用winSCP上传到路由器/tmp目录（其它也可以，只要后面输入运行目录对应上就行），在putty软件登录路由器后，输入sh /tmp/ADSS.sh回车，即可运行脚本根据需要选择配置路由器dnsmasq及hosts，完成后可以选择重启路由器，脚本中已经加入了dnsmasq进程重启命令，一般无需重启路由器即可生效。运行脚本显示乱码的问题请设置putty软件的编码为UTF-8。

注意：如果使用脚本中的软件更新以及安装功能，请确保使用官方的固件，不要用论坛上其它人编译的各种固件，经测试发现这些固件在刷新软件源时会有各种问题，导致无法正确安装软件。优酷PC网页视频正常播放一次再启用脚本规则（/etc/dnsmasq.conf中，addn-hosts代码前面添加一个#号，保存，重启一下dnsmasq进程，就关掉脚本的host规则了，优酷就能打开了。去掉#号，保存，重启dnsmasq进程，恢复使用规则，过滤广告。），就能正常播放并去广告，不会有禁用cookie的错误提示，去广告后爱奇艺PC网页视频发现遨游5浏览器可以正常播放并能直接跳过片头广告，其它浏览器好像不行。

至此，基本能完美的解决扶墙、DNS劫持以及各种广告的问题了。这种方法的弊端就是需要有人持续维护更新，脚本中选择使用的所有规则源都是有持续维护更新的，关于广告屏蔽导致有的网站被错杀无法打开的问题，请反馈或自己将地址添加到配置文件的whitelist文件中，运行update.sh脚本更新规则后即可访问。关于，扶墙问题，由于GWL的升级，本方法已基本失效，无需再问。此类问题与本脚本本身无关，以后不再对此类问题做一一解答，请见谅，谢谢！

感谢规则维护者提供的线上项目资源以及维护项目所做出的贡献！感谢lukme提供的脚本编译写法！感谢zshwq5为后续优化给的建议！

# 免责声明

本项目所有重定向数据仅用于个人学术研究与学习使用。从未用于产生盈利行为（包括“捐赠”等方式）
未经许可，请勿内置于软件内发布与传播。请勿用于产生任何盈利活动。
仅供个人免费使用。请遵守当地法律法规，文明上网。
