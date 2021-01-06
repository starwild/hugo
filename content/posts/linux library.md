---
title: "linux library"
date: 2020-05-10T20:50:00+08:00
draft: false
---

## 定位动态库文件
`locate libGL.so`

## 打印载入动态库的过程
`export LD_DEBUG=libs`

## 打印出当前缓存文件所保存的所有共享库的名字
`ldconfig -p`
