---
title: "开发环境的Mysql安装"
date: 2018-03-16T11:46:00+08:00
draft: false
---
1. 初始化
	mysql --initialize
1. 配置文件
	[client]
	default-character-set=utf8
	[mysqld]
	port=3306
	default-storage-engine=INNODB
	character-set-server=utf8
	collation-server=utf8_general_ci
1. 启动
	mysql --console --explict_default_for_timestamp=true
1. 连接
	mysql -uroot -p
1. 管理
	mysqladmin -uroot -p password
	mysqladmin -uroot shutdown
