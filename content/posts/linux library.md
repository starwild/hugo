---
title: "linux library"
date: 2020-05-10T20:50:00+08:00
draft: false
---

linux内的动态库、可执行程序统一用elf称呼

## 增加elf动态库查询位置
`export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:YOUR_PATH`

## 打印elf
`strings xxx.so`

## 读取elf依赖
`readelf xxx.so`

## 查看elf动态库链接
`ldd xxx.so`

## 定位动态库文件
`locate libGL.so`

## 打印载入动态库的过程
`export LD_DEBUG=libs`

## 打印出当前缓存文件所保存的所有共享库的名字
`ldconfig -p`
