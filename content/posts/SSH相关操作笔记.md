---
title: "SSH相关操作笔记"
date: 2018-03-16T21:59:00+08:00
draft: false
---
1. ssh登录
ssh root@localhost
ssh -l root -p 22 localhost
2. ssh免密码登录
ssh-keygen
ssh-copy-id -i ~/.ssh/id_rsa.pub root@localhost
3. 复制文件
scp root@localhsot:/root/hello.zip ~/hello.zip
