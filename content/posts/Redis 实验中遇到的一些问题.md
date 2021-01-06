---
title: "Redis 实验中遇到的一些问题"
date: 2017-11-02T22:45:00+08:00
draft: false
---
如何在外网访问redis？
在实例配置文件中修改以下配置：
1. 注释bind命令。
```bash
# bind 127.0.0.1
```
2. 将保护模式改为no
```bash
protected-mode
```
3. 打通防火墙
```bash
sudo ufw all 6379
```