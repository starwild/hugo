---
title: "linux网卡"
date: 2017-11-02T21:56:00+08:00
draft: false
---
```bash
# 找到可用的网卡
$ ifconfig -a
# 添加网卡
$ sudo vim /etc/network/interfaces
# 写入内容
iface enp0s9 inet dhcp
# 启动网卡
$ ifup enp0s9
```