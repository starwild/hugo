---
title: "openssl ca make"
date: 2019-08-23T20:58:00+08:00
draft: false
---
# 简单版
自签名证书
原文链接：https://blog.csdn.net/zheyiw/article/details/88909697

1，自制CA私钥
openssl genrsa -des3 -out ca.key 4096
2，自制CA证书
openssl req -new -x509 -days 3650 -key ca.key -out ca.crt

3，自制Server私钥，生成免密码版本
openssl genrsa -des3 -out server.key 4096
openssl rsa -in server.key -out server.nosecret.key
4，制作csr文件
openssl req -new -key server.key -out server.csr
5，用CA证书私钥对csr签名（CA不能用X509，这点需要注意）生成Server证书
openssl ca -days 3650 -in server.csr -cert ca.crt -keyfile ca.key -out server.crt

提示文件打开失败可以参考以下指令
sudo mkdir /etc/ssl/newcerts
touch /etc/ssl/index.txt
touch /etc/ssl/serial
echo "01" > /etc/ssl/serial
echo "01" > /etc/ssl/index.txt


