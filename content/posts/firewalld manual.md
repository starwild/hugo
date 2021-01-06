---
title: "firewalld manual"
date: 2019-08-23T20:02:00+08:00
draft: false
tags: 
    - linux
---
    from https://www.cnblogs.com/xxoome/p/7115614.html

## 查看状态
```bash
# 查看服务状态
systemctl status firewalld
# 查看防火墙本身状态
firewall-cmd --state
```
 

## 开启、重启、关闭
```bash
# 开启
service firewalld start
# 重启
service firewalld restart
# 关闭
service firewalld stop
# 重载
firewall-cmd --reload
```

## 规则变更
```bash
# 查看防火墙规则
firewall-cmd --list-all
# 查询端口是否开放
firewall-cmd --query-port=8080/tcp
# 开放80端口
firewall-cmd --permanent --add-port=80/tcp
# 移除端口
firewall-cmd --permanent --remove-port=8080/tcp
```

## 附录
1. firewall-cmd 是Linux提供的操作firewall的一个工具
1. firewall-cmd 底层使用iptable或者nftable
1. firewall-cmd 是centos默认的防火墙管理工具
1. 其他类似工具还有ufw，出现在ubuntu及其衍生版本