---
title: "记一次grub引导配置"
date: 2020-02-05T16:24:43+08:00
draft: false
---
Centos7 启动过程中进入grub2的启动菜单。菜单中默认的第一个启动项的内核已经不存在，启动失败。
尝试更改/boot/efi/centos/grub.conf， 发现与启动菜单中的内核版本号对不上。
使用fdisk -l 查看，发现有单独的efi分区/sda1 。
当前系统的/boot/分区挂载的是/sda2。
所以前面修改的/boot/efi/centos/grub.conf其实是/sda2中的文件。
尝试挂载/sda1，系统提示unknown filesystem type vfat
搜索答案无果，偶然发现 fdisk 提示 分区为 msdos 格式。
使用 `mount -t msdos /dev/sda1 /mnt/` 挂载成功。
修改grub.conf配置文件，注释无效的第一个启动项，系统重启成功。