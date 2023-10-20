# 超强大的dnsmasq防劫持去广告全自动脚本（ADSI）

1、什么是ADSS？

Auto DNS Smart Script，简称ADSI，是一个小巧，方便且全自动配置dnsmasq的工具，适用于家庭网络智能路由器端使用，配置简单、快速、免维护，它为家庭网络的路由器入口提供了可选择的基于dnsmasq的广告过滤功能和可选择的部分域名解析防污染功能。

2、什么是Dnsmasq啊？（转自百度百科，不知道就百度）

DNSmasq是一个小巧且方便地用于配置DNS和DHCP的工具，适用于小型网络，它提供了DNS功能和可选择的DHCP功能。它服务那些只在本地适用的域名，这些域名是不会在全球的DNS服务器中出现的。DHCP服务器和DNS服务器结合，并且允许DHCP分配的地址能在DNS中正常解析，而这些DHCP分配的地址和相关命令可以配置到每台主机中，也可以配置到一台核心设备中（比如路由器），DNSmasq支持静态和动态两种DHCP配置方式。

3、Dnsmasq有什么用？能为我解决什么

默认的情况下，我们平时上网用的本地DNS服务器都是使用电信或者联通的，但是这样也导致了不少的问题，首当其冲的就是上网时经常莫名地弹出广告，或者莫名的流量被消耗掉导致网速变慢。其次是部分网站域名不能正常被解析，莫名其妙地打不开，或者时好时坏。
如果碰上不稳定的本地DNS，还可能经常出现无法解析的情况。除了要避免“坏”的DNS的影响，我们还可以利用DNS做些“好”事，例如管理局域网的DNS、给手机App Store加速、纠正错误的DNS解析记录、保证上网更加安全、去掉网页讨厌的广告等等。

4、方案dnsmasq提供了什么？

目前主要提供几个功能：
分域名DNS解析，提升加快不同网站的访问速度
国外域名加密解析自动扶墙，享受无墙的快感
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
将下载的压缩包解压，用winSCP上传到路由器/tmp目录（其它也可以，只要后面输入运行目录对应上就行），在putty软件登录路由器后，输入sh /tmp/dnsmasq_all.sh回车，即可运行脚本根据需要选择配置路由器dnsmasq及hosts，完成后可以选择重启路由器，脚本中已经加入了dnsmasq进程重启命令，一般无需重启路由器即可生效。运行脚本显示乱码的问题请参考2楼设置putty软件。此外，本脚本的相关文件都是放在github线上项目中的，配置过程中需要能正常访问github网站，如果不能正常配置，请检查网络环境是否可以正常访问github网站。

注意：如果使用脚本中的软件更新以及安装功能，请确保使用官方的固件，不要用论坛上其它人编译的各种固件，经测试发现这些固件在刷新软件源时会有各种问题，导致无法正确安装软件。暂时不知道原因！优酷PC网页视频正常播放一次再启用脚本规则（/etc/dnsmasq.conf中，addn-hosts代码前面添加一个#号，保存，重启一下dnsmasq进程，就关掉脚本的host规则了，优酷就能打开了。去掉#号，保存，重启dnsmasq进程，恢复使用规则，过滤广告。），就能正常播放并去广告，不会有禁用cookie的错误提示，去广告后爱奇艺PC网页视频发现遨游5浏览器可以正常播放并能直接跳过片头广告，其它浏览器好像不行。

至此，基本能完美的解决扶墙、DNS劫持以及各种广告的问题了。这种方法的弊端就是需要有人持续维护更新，脚本中选择使用的所有规则源都是有持续维护更新的，关于广告屏蔽导致有的网站被错杀无法打开的问题，请到 https://github.com/vokins/yhosts 向规则维护者反馈。关于，墙外网站访问异常，可以到 https://github.com/sy618/hosts 向规则维护作者反馈，一般用https安全链接访问不会有问题，如果确实遇到问题，只能等待作者更新规则，找到合适的IP。此类问题需要规则源中的规则更新才能解决，与本脚本无关，以后不再对此类问题做一一解答，请见谅，谢谢！

特别感谢sy618、vokins提供的线上项目资源以及维护项目所做出的贡献！感谢lukme提供的脚本编译写法！感谢zshwq5为后续优化给的建议！

# 免责声明

本项目所有重定向数据仅用于个人学术研究与学习使用。从未用于产生盈利行为（包括“捐赠”等方式）
未经许可，请勿内置于软件内发布与传播。请勿用于产生任何盈利活动。
仅供个人免费使用。请遵守当地法律法规，文明上网。

# 更新日志

2017-6-11 更新

修复之前已知的bug，重新写了4个不同的脚本文件：fqad.sh、fq.sh、fqad_auto.sh、fq_auto.sh，并实现更加人性化可视化选择安装和一键自动还原设置功能。不带auto的脚本运行时，需要输入设置lan IP等参数，带auto的脚本仅供路由器lan IP为192.168.1.1的网友使用。

2017.6.13 更新优化

昨天修改增加墙外网站指定到443端口访问，希望可以借助ngnix反向代理，实现墙外网站的https安全链接自动跳转，结果出现了一些bug，现在已经对相关错误进行了修复，修复了之前脚本中，创建规则自动更新脚本输出错误的问题，修复了之前脚本中自动备份相关设置代码的问题，现在可以实现重新安装脚本时，自动备份原有配置，以便需要时运行脚本自动卸载恢复之前的配置。新脚本实现了墙外网站指定到443端口进行访问，并新增了单独的扶墙规则自动更新脚本，只是目前ngnix反向代理自动跳转还没有成功，如果有懂这一块的网友，欢迎联系我一起参与脚本的优化。谢谢！

2017.6.16 更新优化

修正了所用广告规则源中，部分正常网页被误杀的问题，比如淘宝和京东的正常访问。如有还有发现其它正常非广告网页被误杀，欢迎各位网友反馈进行优化。

2017.6.17 更新优化

之前扶墙网站指定到443端口访问，导致优兔等网站访问异常，看来这个方法不行，已经修复，去除了端口指定。

2017.7.30 更新优化

有网友反应sy618和racaljk地址有冲突导致部分网站访问问题，暂时修改为只使用sy618的扶墙规则。优化上游DNS解析服务器，优化视频及手机、电视APP广告过滤规则，加强了adaway规则的完善，增加4个规则更新源，更新后的规则文件有2M多点，是原来的十倍，更全面过滤各种广告。


2017.7.31 修正优化

今天发现昨天更新添加的规则中，又一个规则源有点问题，连搜狐视频的主页都被误杀了，已经去掉该规则源，修正搜狐视频正常访问问题。此外，关于PC优酷和搜狐视频，虽然过滤的广告，但是仍然有个黑屏，提示广告无法播放然后等到广告时间结束才能播放的问题，参考网上其它网友提供的解决方法如下：
以win7为例（其它系统请自行查找相应目录），打开系统盘，此处默认为C盘，找到目录C:\Users\PC用户名\AppData\Roaming\Macromedia\Flash Player\#SharedObjects\TNTRWDGD，里面有两个文件夹分别名为static.youku.com和images.sohu.com，新建文本文件，分别命名为这两个文件夹的名字，然后删除这两个文件夹，再将新建改名的文本文件的txt后缀删除，然后在看优酷和搜狐视频的时候就不会有那个广告无法播放提示的黑屏，无需等广告时间后，而是直接进入播放界面，从而完美去片头广告。经测试有效，但是优酷需要用IE内核浏览器才有效，chrome内核模式还是有那个广告无法播放的黑屏提示，无法直接进入播放界面。

2017.8.1 修正优化


1、考虑到昨天删除的规则源过滤规则全面，恢复了规则源的使用，并修复搜狐视频访问的问题，如果有正常网页被误杀的情况，请反馈给我修复；
2、修复安装下载adaway规则缓存时提示cat: can't open '/tmp/adaway5': No such file or directory错误的问题；
3、其它小问题的修复，包括hosts及dnsmasq统一转为unix格式（发现有一些规则源文件为dos格式），统一不同源hosts格式等。

2017.8.5 修复更新

1、之前添加了规则文件unix格式化后发现出了一些问题，导致规则失效，现已经修复正常，并保留了规则格式为unix格式，以免路由识别规则错误，广告规则格式进一步统一化；
2、添加去广告的黑名单功能，如果发现规则未能过滤的广告页面，可以找到广告域名地址，用winSCP登录路由器，进入/etc/dnsmasq文件夹，找到blacklist文件，手动添加需要过滤的广告域名地址3、添加去广告的白名单功能，如果发现规则中有误杀的网站或者是不想过滤的网站，可以用winSCP登录路由器，进入/etc/dnsmasq文件夹，找到whitelist文件，手动添加域名地址到白名单；
4、广告黑名单和白名单均非立即生效，请在添加域名地址后，putty登录路由器，运行/bin/sh /etc/fqad_update.sh规则更新脚本后方能生效，也可以等路由器自动更新计划任务运行后生效。

2017.8.7 修复更新

1、优化扶墙规则处理脚本代码；
2、修复一些小问题。

2017.8.9 重大更新

1、小问题的修复；
2、全部脚本代码优化与调整，将wget检测安装及全脚本自动卸载功能从具体脚本移除，集成到4合一脚本，脚本配置更加高效；
3、提高智能自动化程度，新增自动识别路由环境网关IP功能，无需再手动输入网关IP地址，不管你的是几级路由都能自动识别，欢迎有多级路由的坛友测试反馈；
4、调整脚本更新和规则更新时间自定义功能，首次手动输入后以后脚本更新会自动识别，如果运行全自动安装配置，每天检查更新的时间为早上5:25分，如果需要修改，请winSCP登录路由器后，进入/etc/crontabs/Update_time.conf配置文件修改，只需要输入小时时间即可。
5、新增脚本自动检测更新功能，真正实现一次配置，永久自动维护，包括脚本的自动升级维护以及所有规则的升级自动维护；
6、本次更新调整是一个很艰难的决定，由于脚本架构调整，不能再用以前的4合一脚本重新运行进行升级了，如果需要升级，需重新下载新的4合一脚本进行配置，但完成后能自动检测脚本的更新，并进行自动更新维护，如果不升级，以前的4合一脚本还是能继续使用，只是功能不如新的4合一脚本功能完善；
7、修改本脚本花费了大量的精力，并且以后能自动检测更新脚本，为大家节省了大量的维护精力，适当提高了脚本的nb售价，还请见谅！

2017.8.10 优化更新

1、一些小问题的修复；
2、进一步完善了脚本自动更新功能。
3、之前由于一个广告规则网站访问奇慢，导致运行脚本到下载adaway处卡住的问题，暂时取消了那个规则的应用，不会再卡住不动；

2017.8.11 更新

1. 新增wget可选安装功能，对于无法安装软件的官改固件，可跳过检测安装；
2. 考虑到Openwrt自带的dnsmasq解析效率的低下，安装dnsmasq-full会大幅提高解析的速度，因此4合一脚本新增可选自动判定卸载系统自带dnsmasq软件包，并安装dnsmasq-full软件包的功能。下载8月9号更新4合一版本的网友无需重新下载新的4合一脚本，可以自己web登录到路由器的系统软件包管理页面中手动卸载自带的dnsmasq软件包，并查找安装dnsmasq-full即可。
3. 如果不是openwrt、lede等支持在线安装软件的固件（潘多拉在线软件包链接已失效），请选择输入n跳过检测系统软件卸载安装的步骤，直接进入dnsmasq的安装配置。如果多次尝试卸载安装软件失败，请手动安装并跳过该选项，直接进入dnsmasq安装配置；
4. 新增可选系统中已装软件的一键升级功能。使用条件同上，需要有可用在线软件包资源支持。

此外，今天发现pandorabox的软件包链接已经失效，我手动修改了新的链接地址，1610稳定版还是无法刷新得到正确的软件列表，更早的版本未知，从而导致无法在运行脚本时正确安装所需的软件，故已经抛弃了pandorabox，入坑了LEDE的固件。那些不确定是否可以安装软件的固件，请不要尝试变更系统自带的wget和dnsmasq软件。输入n跳过直接尝试进入dnsmasq的配置。

2017.8.14 更新优化

1. 规则的优化，尤其优化了手机及电视盒子APP内置广告的过滤规则；
2. 脚本的优化，本次优化无需重新下载4合一脚本安装，运行一下update脚本或者等待计划任务自动更新即可。

2017.8.21 重要更新优化

1. 优化之前配置文件备份之后，再次运行脚本备份配置文件失败的问题；
2. 优化复杂网络环境中网关设定的问题。之前有网友反应，获取非192.168.1.1网关环境中，网关错误的问题，我自己修改网关测试，没有问题，但是还是恢复了自定义脚本中脚本安装时，可以输入设置网关的设定，并优化脚本更新代码，使脚本在更新时，能自动识别第一次设定的网关，避免因脚本更新致使网关出现错误；
3. 脚本配置好以后，如果需要修改网关，请重新运行自定义安装脚本，或winSCP登录路由器，到/etc/dnsmasq/lanip（记事本即可打开）文件修改保存；
4.修正之前运行自动更新脚本后无法访问网络DNS解析异常的问题；
5.修正脚本更新的一些bug及其它已知bug，个人知识和细心度有限，bug在所难免，尽量发现了就修复，欢迎大家反馈；
6. 白名单和黑名单修改为追加模式，自动更新脚本后，会保留之前自己添加的白名单和黑名单，无需再次添加；
7. 其它小问题的修复和优化；
8. 本次更新无需重新下载运行，会在计划任务自动完成。


2017.8.22 更新优化：新增独立的广告过滤脚本

1. 新增网友建议的独立去广告全自动维护脚本，将原来的4合一脚本调整为6合一脚本，加入自定义配置单独广告过滤及全自动配置功能。本来不想做这个独立的广告过滤脚本的，因为网上的类似脚本已经比较多，但是考虑到可能都没有我的这个全面和智能化的程度，因此接受了网友的建议；
2. 进一步调整优化备份还原功能，让备份还原配置文件更智能，避免不必要的覆盖备份导致本来需要备份的休息丢失的情况；
3. 进一步修改优化代码执行效率，调整用户自定义广告黑名单和白名单文件为/etc/dnmasq/userblacklist和userwhitelist，需要调整的网友可以自己前往文件打开添加自定义域名，原来已经在blacklist及whitelist中添加了的广告域名地址会自动更新到新的自定义规则文件中，无需大家手动去复制过去，自定义的设置永只需一次便会久生效，以后都会自动在更新规则时应用到广告过滤规则中，无需重复设置；
4.新增线上我自己维护的白名单和黑名单功能，本人会将发现的未能过滤以及误杀的规则在线上进行更新，并自动下载应用到大家的本地规则当中，无需大家手动添加；
5.由于每次加入新功能或进行功能的调整都可能涉及到代码运行架构的调整，往往容易出错，因此这次特意对所有脚本进行了全面多次的测试，修复了已经测试发现的所有bug，如果发现新的错误问题，欢迎大家反馈；
6. 一些配置文件排版上的合理调整，让大家查看配置文件更容易理解；
7. 一些小的脚本运行时输出信息视觉上调整优化，此外，关于大家说的下载adaway规则的时候卡住的情况，其实是因为这里在后台要进行比较复杂的处理，这里和你的网速以及路由器的计算性能都有关系，稍微等一会儿就好了，实在不行如果卡死了（应该不太出现），就重新运行一下吧，此处做统一解答，请大家不要在问我类似的问题，谢谢；
8. 进一步优化dnsmasq配置文件设置代码，从而避免之前已经使用其它软件，比如防火墙，ss，广告插件，KMS服务器等，修改过dnsmasq的配置，再使用本脚本以及脚本自动更新后，之前已有相关配置丢失导致那些软件的使用异常的情况发生；
9. 本次更新无需如果不需要单独的去广告脚本，无需重新下载6合一安装配置脚本，会在计划任务后台自动更新完成。

2017.8.23 更新优化

1. 进一步优化了备份、卸载恢复以及计划任务配置代码的运行逻辑；
2. 进一步优化了上游配置文件的创建配置逻辑，提高脚本配置效率；
3. 抓取了电视应用魔力视频和猫范TV的广告源，现在验证，已经过滤了，优化了优酷的过滤，网站、APP我这里测试都可以屏蔽了。

2017.8.25 更新修复

修复了上次调整后产生的，etc文件夹下没有配置文件夹导致无法写入配置文件的bug。

2017.8.26 新增Padavan脚本

感谢坛友蓝色小小的贡献和分享，新增padavan系列固件使用的脚本。

2017.8.27 修复更新

修复2个bug。

2017.9.08 修复更新

1. 修复路由器执行定时重启后，反复重启的bug;
2. 手动可选安装配置路由器定时重启任务，支持自定义时间，自动安装配置默认判定添加定时重启任务，重启时间为每天早上6：05分，可进入路由器计划任务修改。

2017.9.13 修复更新

修复可选配置脚本中选择不添加路由器定时重启计划任务，依然会自动添加的bug。

2017.9.20 修复更新

今天升级最新的pandorabox（2017.9.17版）后，配置中又发现了一些小bug，主要涉及dnsmasq配置文件备份修改以及计划任务，已经对发现的bug进行了修复。

2017.10.8 修复更新

1. 发现一个可能出现导致DNS解析错误的bug，已经修复；
2. 优化广告误杀白名单。

2017.10.9 更新优化

1. 优化自定义的黑名单广告过滤模式，由原先的通过hosts规则过滤模式改为通过dnsmasq规则过滤模式。因为hosts规则不支持通配符的识别，而dnsmasq规则支持，因此优化后支持在自定义广告黑名单中添加域名时使用通配符；
2. 优化广告黑名单，发现爱奇艺的广告又失效了，暂时没有找到过滤办法。

2017.11.15 补充说明

现在脚本已经基本没有什么问题了，以后可能就不考虑更新了。广告规则，我还是会持续维护和修正，如果你们在使用本脚本，都会自动更新。由于我们伟大的长城的进一步升级，目前扶墙暂时看不到希望，Sy618等一系列的谷狗host规则的维护网友，也停止了对扶墙规则的更新和维护，暂时没有找到可以使用的规则源。因此，以后只剩下广告过滤的功能了。谢谢大家长期以来的支持，不用再问我为啥不能翻的问题，我暂时也帮不到大家。再见！

2017.12.1 修复更新

更新修复了去广告脚本规则自动更新中的一个小bug，本次更新非关键错误更新，不影响功能，会在路由器定时任务自动更新，无需手动更新。

2018.3.5 维护更新

1. 维护更新小bug，本次更新非关键错误更新，不影响功能，会在路由器定时任务自动更新，无需手动更新。
2.优化更新网页播放优酷视频广告过滤失败的问题，已经抓取更新最新地址更新规则，现在可以正常去广告了。

2019.7.19 维护更新

1. 移除失效的广告规则，本次更新非关键错误更新，不影响功能，会在路由器定时任务自动更新，无需手动更新。
2. 更新优酷，腾讯视频广告规则。

2020.5.3 维护更新

1. 移除失效的广告规则，优化更新规则源;
2. 更新优酷，腾讯，爱奇异，芒果TV，电视端广告，视频广告规则；3. 优化全自动脚本自动识别路由器的内网网关，支持多内网网关qun自动配置；
4. 本次更新非关键错误更新，不影响功能，会在路由器定时任务自动更新，无需手动更新。

2020.5.5 重要更新

1. 对脚本的结构进行了重要更新，让代码复用效率更高，保存的用于检查更新的脚本文件更小;
2. 修复3号更新后产生的一些bug，修复规则源问题，昨天花了一天时间反复测试，终于填了所有的坑；
3. 优化脚本更新机制，修复一些可能会因为更新而产生的问题；
4. 本次更新两年来的最重要的一次更新，加强，完善，优化了功能，但无需手动进行更新，会在路由器定时任务自动更新；
5. 因为昨天的更新规则源地址不当产生的bug可能会导致DNS解析问题，如果已经无法正确解析，建议手动登录路由器执行卸载操作后重新运行原下载的多合一脚本配置一下即可;
6. 考虑到由于现在存放代码的域名也被污染，会导致下载配置文件失败的情况，进一步优化全自动安装配置的脚本，会在配置前检测网络环境并对存放代码域名的解析自动纠正，避免提前手动修正的麻烦。

2020.5.13 维护更新

1. 修复规则更新可能导致无法启动dnsmasq的bug;
2. 本次为关键错误更新，如果无法通过自动更新完成更新，请手动登录putty，运行sh /etc/dnsmasq/fqad_update或ad_update.sh(具体运行哪个可以登录winSCP，etc/dnsmasq路径查看update文件的文件名)。

2020.5.24 维护更新

1. 修复5.5日调整脚本结构后导致的白名单失效的bug，感谢网友freeskyfly的指正！
2. 本次为关键错误更新，但无需手动更新，会在路由器定时任务自动更新规则时自动更新。

2020.6.6 维护更新

1. 修复5.5日调整脚本结构后导致的白名单处理的逻辑错误！
2. 本次为关键错误更新，但无需手动更新，会在路由器定时任务自动更新规则时自动更新。

2021.1.16 维护更新

1. 优化了网络环境检测脚本能否安装，修复了备份的一些bug！
2. 本次为关键错误更新，但无需手动更新，会在路由器定时任务自动更新规则时自动更新。

2021.4.29 维护更新

1. 停止维护fq相关版本，优化修复了ad脚本升级和规则更新中的一些bug！
2. 更新了部分视频广告规则。
3. 本次为非关键错误更新，无需手动更新，会在路由器定时任务自动更新规则时自动更新。

2021.5.8 维护更新

1. 由于github服务器污染原来越严重，访问很不稳定，改为国内服务器存放代码，自此停止该项目在github的维护。
2. 优化修复了ad脚本升级和规则更新中的一些小bug！
3. 由于原来由vokins维护的yhosts规则现在改由VeleSila接手更新和维护，规则地址已经变化，启用新的VeleSila维护的yhosts广告规则。
4. 本次为非关键错误更新，无需手动更新，会在路由器定时任务自动更新规则时自动更新。
