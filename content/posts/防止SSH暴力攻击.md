---
title: "防止SSH暴力攻击"
date: 2018-03-19T23:50:49+08:00
draft: false
---

## 解除登录限制
```bash
#!/bin/bash

IP=$1
if [ -n "$IP" ];then
    if [[ $IP =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]];then
        service denyhosts stop
        sed -i "/$IP/d" /etc/hosts.deny
        sed -i "/$IP/d" /var/lib/denyhosts/hosts-valid
        sed -i "/$IP/d" /var/lib/denyhosts/users-hosts
        sed -i "/$IP/d" /var/lib/denyhosts/hosts
        sed -i "/$IP/d" /var/lib/denyhosts/hosts-root
        sed -i "/$IP/d" /var/lib/denyhosts/hosts-restricted
        iptables -D INPUT -s $IP -j DROP
        echo $IP remove from Denyhosts
        service denyhosts start
    else
        echo "This is not IP"
    fi
else
    echo "IP is empty"
fi

```

## 记录登录日志
vim /etc/ssh/sshd_config
SyslogFacility AUTHPRIV
LogLevel INFO

[DenyHosts 阻止SSH暴力攻击][1]http://blog.csdn.net/wanglei_storage/article/details/50849070