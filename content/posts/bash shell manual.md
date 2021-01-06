---
title: "bash shell manual"
date: 2019-08-21T22:21:00+08:00
draft: false
---
<backspace> 删除 
<ctrl-l>    清空屏幕,
<ctrl+e>    光标跳至命令结尾
<ctrl+a>    光标跳至命令开始
<ctrl+b>    光标左移一个字母
<ctrl+f>    光标右移一个字母
<ctrl+t>    交换光标位置前的两个字符
<ctrl+h>    删除光标前一个字符
<ctrl+w>    移除光标前的一个单词
<ctrl+u>    清除光标前至行首间的所有内容
<ctrl+k>    清除光标后至行尾的内容
<ctrl+y>    粘贴或者恢复上次的删除
<ctrl+p>    前一个命令
<ctrl+n>    后一个命令
<ctrl+r>    历史命令搜索
<ctrl-c>    中断当前的命令并返回Shell
<ctrl-d>    中断当前的通信或从文件中退出
<ctrl+z>    暂停当前进程bg后台运行,fg转到前台


while [ 1 ]; do sleep 1; ll; done # 无限循环
while [ $i -lt 10 ]; do echo $i;let "i=$i+1"; done # 有限循环
cat raw.txt | while read line; do echo $line; done # readline
until [ 1 = 0 ]; do sleep 1; ll; done # 无限循环
for i in /media/m* ; do ls -l $i; done # 与目录资源结合
if [ 1 -eq 1 ]; then ll ;fi # test常用判断
if [[ 0 -eq 0 && 1 -eq 0 ]]; then ll ;fi
if [ 0 -eq 0 -a 1 -eq 0 ]; then ll ;fi
if [ ! -e /tmp/111 -a -z "$a" ]; then ll ;fi # 不存在111文件 且a变量长度为0 则执行ll


ps -ef | grep java | grep -v eclipse # 查看进程，筛选出java的，排除eclipse的
echo 'a:b:c' | tr -s ':' '*' # 替换字符:为*，输出 a*b*c
echo 'a:b:c' | awk -F ':' '{print $1 "+" $3 "+" $2}' # 按:切分后，按下标调整顺序，空格分割输出。a+c+b
awk -F':' '{print $1}' temp2.log | awk '{ arr[$1]++ } END { for( no in arr) { print no , arr[no] } }' | sort -n -t" " -k 2 -r # 一句话实现group by
grep -rn 'ReturnMessageListCount' info.log | awk -F"|" '$3 ==11 {print $0 }'
echo 'a:b:c' | sed -e 's#:#*#g' # 替换字符:为*，输出 a*b*c
zgrep " body size " push-receipt-service-info.1.log.gz | awk '{sum+=$NF}END{print sum}' 不解压过滤文本
sed -i 's/^[^{]*//g' 文件 #去除从行首到第一个{之前的字符。


sudo su admin # 切换为admin身份
sudo -u admin kill -9 xxx # 以admin身份执行kill命令
zip -9 -p haha -r bak.zip src # 以9级压缩比、haha为密码，压缩src目录，压缩后的文件是bak.zip
gunzip FileName.gz #解压缩