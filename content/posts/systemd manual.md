---
title: "systemd manual"
date: 2019-08-24T16:52:00+08:00
draft: false
tags: 
    - linux
---
使用脚本启动主程序，在使用systemd时，需要删除nohup启动，切保证启动脚本中不会报错。


参考
    http://www.jinbuguo.com/systemd/systemd.index.html
    http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-part-two.html

cp test.service /usr/lib/systemd/system

systemctl daemon-reload
systemctl enable test
systemctl start test
systemctl disable test
systemctl stop test
systemctl restart test
systemctl reload test

test.service
```bash
[Unit]
Description=
Documentation=
After=network.target
Wants=

[Service]
#EnvironmentFile=
WorkingDirectory=/home/z/Workspace/systemd/
ExecStart=/bin/bash /home/z/Workspace/systemd/start.sh
# simple fork oneshot 
Type=simple
# control-group process mixed none
# KillMode= control-group 
# RemainAfterExit=yes 进程退出后服务仍然执行
# on-success on-failure always on
Restart=always
RestartSec=10s

[Install]
WantedBy=multi-user.target
```