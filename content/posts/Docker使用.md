---
title: "Docker使用"
date: 2017-10-17T11:23:00+08:00
draft: false
---
```bash
# 使用docker安装neo4j
sudo apt install docker.io
docker pull neo4j
docker run -p 7474:7474 -p 7687:7687 -v $HOME/neo4j/data:/data neo4j
```