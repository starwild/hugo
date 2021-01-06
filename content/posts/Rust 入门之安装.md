---
title: "Rust 入门之安装"
date: 2020-02-16T22:03:00+08:00
draft: false
---
## 准备工具

官方网站 https://www.rust-lang.org/。
镜像站点 https://lug.ustc.edu.cn/wiki/mirrors/help/rust-crates

export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup

set RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
set RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup

## 安装
启动安装程序rustup-init.exe, 或安装脚本。
https://static.rust-lang.org/rustup/dist/x86_64-pc-windows-msvc/rustup-init.exe
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

## 镜像
在 $HOME/.cargo/config 配置镜像， 
```ini
[source.crates-io]
registry = "https://github.com/rust-lang/crates.io-index"
replace-with = 'ustc'
[source.ustc]
registry = "git://mirrors.ustc.edu.cn/crates.io-index"
```
