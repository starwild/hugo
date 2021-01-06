---
title: "Shell实例手册"
date: 2018-03-16T15:24:36+08:00
draft: false
---
Shell实例手册

0说明{

    手册制作: 雪松
    更新日期: 2013-12-06
    欢迎系统运维加入Q群: 198173206

    请使用"notepad++"打开此文档,"alt+0"将函数折叠后方便查阅
    请勿删除信息，转载请说明出处，抵制不道德行为。
    错误在所难免，还望指正！

    # shell实例手册最新下载地址:
    http://hi.baidu.com/quanzhou722/item/f4a4f3c9eb37f02d46d5c0d9

    # LazyManage系统批量管理软件下载(shell):
    http://hi.baidu.com/quanzhou722/item/4ccf7e88a877eaccef083d1a
    
    # python实例手册下载地址:
    http://hi.baidu.com/quanzhou722/item/cf4471f8e23d3149932af2a7

}

1文件{
    
    touch file              # 创建空白文件
    rm -rf 目录名           # 不提示删除非空目录(-r:递归删除 -f强制)
    dos2unix                # windows文本转linux文本  
    unix2dos                # linux文本转windows文本
    enca filename           # 查看编码  安装 yum install -y enca 
    md5sum                  # 查看md5值
    ln 源文件 目标文件      # 硬链接
    ln -s 源文件 目标文件   # 符号连接
    readlink -f /data       # 查看连接真实目录
    cat file | nl |less     # 查看上下翻页且显示行号  q退出
    head                    # 查看文件开头内容
    head -c 10m             # 截取文件中10M内容
    split -C 10M            # 将文件切割大小为10M
    tail -f file            # 查看结尾 监视日志文件
    file                    # 检查文件类型
    umask                   # 更改默认权限
    uniq                    # 删除重复的行
    uniq -c                 # 重复的行出现次数
    uniq -u                 # 只显示不重复行
    paste a b               # 将两个文件合并用tab键分隔开
    paste -d'+' a b         # 将两个文件合并指定'+'符号隔开
    paste -s a              # 将多行数据合并到一行用tab键隔开
    chattr +i /etc/passwd   # 设置不可改变位
    more                    # 向下分面器
    locate 字符串           # 搜索
    wc -l file              # 查看行数
    cp filename{,.bak}      # 快速备份一个文件
    \cp a b                 # 拷贝不提示 既不使用别名 cp -i
    rev                     # 将行中的字符逆序排列
    comm -12 2 3            # 行和行比较匹配
    iconv -f gbk -t utf8 原.txt > 新.txt    # 转换编码
    rename 原模式 目标模式 文件             # 重命名 可正则
    watch -d -n 1 'df; ls -FlAt /path'      # 实时某个目录下查看最新改动过的文件
    cp -v  /dev/dvd  /rhel4.6.iso9660       # 制作镜像
    diff suzu.c suzu2.c  > sz.patch         # 制作补丁
    patch suzu.c < sz.patch                 # 安装补丁
    
    sort排序{
    
        -t  # 指定排序时所用的栏位分隔字符
        -n  # 依照数值的大小排序
        -r  # 以相反的顺序来排序
        -f  # 排序时，将小写字母视为大写字母
        -d  # 排序时，处理英文字母、数字及空格字符外，忽略其他的字符
        -c  # 检查文件是否已经按照顺序排序
        -b  # 忽略每行前面开始处的空格字符
        -M  # 前面3个字母依照月份的缩写进行排序
        -k  # 指定域
        -m  # 将几个排序好的文件进行合并
        +<起始栏位>-<结束栏位>   # 以指定的栏位来排序，范围由起始栏位到结束栏位的前一栏位。
        -o  # 将排序后的结果存入指定的文
        n   # 表示进行排序
        r   # 表示逆序

        sort -n               # 按数字排序
        sort -nr              # 按数字倒叙
        sort -u               # 过滤重复行
        sort -m a.txt c.txt   # 将两个文件内容整合到一起
        sort -n -t' ' -k 2 -k 3 a.txt     # 第二域相同，将从第三域进行升降处理
        sort -n -t':' -k 3r a.txt         # 以:为分割域的第三域进行倒叙排列
        sort -k 1.3 a.txt                 # 从第三个字母起进行排序
        sort -t" " -k 2n -u  a.txt        # 以第二域进行排序，如果遇到重复的，就删除

    }

    find查找{

        # linux文件无创建时间
        # Access 使用时间  
        # Modify 内容修改时间  
        # Change 状态改变时间(权限、属主)
        # 时间默认以24小时为单位,当前时间到向前24小时为0天,向前48-72小时为2天
        # -and 且 匹配两个条件 参数可以确定时间范围 -mtime +2 -and -mtime -4
        # -or 或 匹配任意一个条件

        find /etc -name http         # 按文件名查找
        find . -type f               # 查找某一类型文件
        find / -perm                 # 按照文件权限查找
        find / -user                 # 按照文件属主查找
        find / -group                # 按照文件所属的组来查找文件
        find / -atime -n             # 文件使用时间在N天以内
        find / -atime +n             # 文件使用时间在N天以前
        find / -mtime -n             # 文件内容改变时间在N天以内
        find / -mtime +n             # 文件内容改变时间在N天以前
        find / -ctime +n             # 文件状态改变时间在N天前
        find / -ctime -n             # 文件状态改变时间在N天内
        find / -size +1000000c -print                           # 查找文件长度大于1M字节的文件
        find /etc -name "passwd*" -exec grep "xuesong" {} \;    # 按名字查找文件传递给-exec后命令
        find . -name 't*' -exec basename {} \;                  # 查找文件名,不取路径
        find . -type f -name "err*" -exec  rename err ERR {} \; # 批量改名(查找err 替换为 ERR {}文件
        find 路径 -name *name1* -or -name *name2*               # 查找任意一个关键字

    }

    vim编辑器{

        gconf-editor       # 配置编辑器
        /etc/vimrc         # 配置文件路径
        vim +24 file       # 打开文件定位到指定行
        vim file1 file2    # 打开多个文件    
        vim -O2 file1 file2    # 垂直分屏
        vim -on file1 file2    # 水平分屏
        sp filename        # 上下分割打开新文件
        vsp filename       # 左右分割打开新文件
        Ctrl+W [操作]      # 多个文件间操作  大写W  # 操作: 关闭当前窗口c  屏幕高度一样=  增加高度+  移动光标所在屏 右l 左h 上k 下j 中h  下一个w  
        :n                 # 编辑下一个文件
        :2n                # 编辑下二个文件
        :N                 # 编辑前一个文件
        :rew               # 回到首文件
        :set nu            # 打开行号
        :set nonu          # 取消行号
        200G               # 跳转到200
        :nohl              # 取消高亮
        :set autoindent    # 设置自动缩进
        :set ff            # 查看文本格式
        :set binary        # 改为unix格式
        ctrl+ U            # 向前翻页
        ctrl+ D            # 向后翻页
        %s/字符1/字符2/g   # 全部替换    
        X                  # 文档加密
    
    }

    归档解压缩{

        tar zxvpf gz.tar.gz -C 放到指定目录 包中的目录       # 解包tar.gz 不指定目录则全解压
        tar zcvpf /$path/gz.tar.gz * # 打包gz 注意*最好用相对路径
        tar zcf /$path/gz.tar.gz *   # 打包正确不提示
        tar ztvpf gz.tar.gz          # 查看gz
        tar xvf 1.tar -C 目录        # 解包tar
        tar -cvf 1.tar *             # 打包tar
        tar tvf 1.tar                # 查看tar
        tar -rvf 1.tar 文件名        # 给tar追加文件
        tar --exclude=/home/dmtsai -zcvf myfile.tar.gz /home/* /etc      # 打包/home, /etc ，但排除 /home/dmtsai
        tar -N "2005/06/01" -zcvf home.tar.gz /home      # 在 /home 当中，比 2005/06/01 新的文件才备份
        tar -zcvfh home.tar.gz /home                     # 打包目录中包括连接目录
        zgrep 字符 1.gz              # 查看压缩包中文件字符行
        bzip2  -dv 1.tar.bz2         # 解压bzip2
        bzip2 -v 1.tar               # bzip2压缩
        bzcat                        # 查看bzip2
        gzip A                       # 直接压缩文件 # 压缩后源文件消失
        gunzip A.gz                  # 直接解压文件 # 解压后源文件消失
        gzip -dv 1.tar.gz            # 解压gzip到tar
        gzip -v 1.tar                # 压缩tar到gz
        unzip zip.zip                # 解压zip
        zip zip.zip *                # 压缩zip
        # rar3.6下载:  http://www.rarsoft.com/rar/rarlinux-3.6.0.tar.gz
        rar a rar.rar *.jpg          # 压缩文件为rar包
        unrar x rar.rar              # 解压rar包
        7z a 7z.7z *                 # 7z压缩
        7z e 7z.7z                   # 7z解压

    }
    
    文件ACL权限控制{

        getfacl 1.test                      # 查看文件ACL权限
        setfacl -R -m u:xuesong:rw- 1.test  # 对文件增加用户的读写权限 -R 递归

    }
    
    svn更新代码{

        --force # 强制覆盖
        /usr/bin/svn --username user --password passwd co  $Code  ${SvnPath}src/                 # 检出整个项目
        /usr/bin/svn --username user --password passwd export  $Code$File ${SvnPath}src/$File    # 导出个别文件

    }

    恢复rm删除的文件{

        # debugfs针对 ext2   # ext3grep针对 ext3   # extundelete针对 ext4
        df -T   # 首先查看磁盘分区格式
        umount /data/     # 卸载挂载,数据丢失请首先卸载挂载,或重新挂载只读
        ext3grep /dev/sdb1 --ls --inode 2         # 记录信息继续查找目录下文件inode信息
        ext3grep /dev/sdb1 --ls --inode 131081    # 此处是inode
        ext3grep /dev/sdb1 --restore-inode 49153  # 记录下inode信息开始恢复目录

    }
    
}

2软件{

    rpm{

        rpm -ivh lynx          # rpm安装
        rpm -e lynx            # 卸载包
        rpm -e lynx --nodeps   # 强制卸载
        rpm -qa                # 查看所有安装的rpm包
        rpm -qa | grep lynx    # 查找包是否安装
        rpm -ql                # 软件包路径
        rpm -Uvh               # 升级包
        rpm --test lynx        # 测试
        rpm -qc                # 软件包配置文档
        rpm --import  /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6     # 导入rpm的签名信息

    }

    yum{

        yum list                 # 查找所有列表
        yum install 包名         # 安装包和依赖包
        yum -y update            # 升级所有包版本,依赖关系，系统版本内核都升级
        yum -y update 软件包名   # 升级指定的软件包
        yum -y upgrade           # 不改变软件设置更新软件，系统版本升级，内核不改变
        yum search mail          # yum搜索相关包
        yum grouplist            # 软件包组
        yum -y groupinstall "Virtualization"   # 安装软件包组
        
    }

    yum扩展源{

        # 包下载地址:http://download.fedoraproject.org/pub/epel   # 选择版本
        wget http://download.fedoraproject.org/pub/epel/5/i386/epel-release-5-4.noarch.rpm
        rpm -Uvh epel-release-5-4.noarch.rpm

    }

    自定义yum源{

        find /etc/yum.repos.d -name "*.repo" -exec mv {} {}.bak \;
        
        vim /etc/yum.repos.d/yum.repo
        [yum]
        #http
        baseurl=http://10.0.0.1/centos5.5
        #挂载iso
        #mount -o loop CentOS-5.8-x86_64-bin-DVD-1of2.iso /data/iso/
        #本地
        #baseurl=file:///data/iso/
        enable=1

        #导入key
        rpm --import  /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5

    }

    编译{

        源码安装{

            ./configure --help                   # 查看所有编译参数
            ./configure  --prefix=/usr/local/    # 配置参数
            make                                 # 编译
            make install                         # 安装包
            make clean                           # 清除编译结果

        }

        perl程序编译{

            perl Makefile.PL
            make
            make test
            make install

        }

        python程序编译{

            python file.py

        }
        
        编译c程序{

            gcc -g hello.c -o hello

        }
    
    }
    
}

3系统{

    wall        　  　          # 给其它用户发消息
    whereis ls                  # 查找命令的目录
    which                       # 查看当前要执行的命令所在的路径
    clear                       # 清空整个屏幕
    reset                       # 重新初始化屏幕
    cal                         # 显示月历
    echo -n 123456 | md5sum     # md5加密
    mkpasswd                    # 随机生成密码   -l位数 -C大小 -c小写 -d数字 -s特殊字符
    netstat -anlp | grep port   # 是否打开了某个端口
    ntpdate stdtime.gov.hk      # 同步时间
    tzselect                    # 选择时区 #+8=(5 9 1 1) # (TZ='Asia/Shanghai'; export TZ)括号内写入 /etc/profile
    /sbin/hwclock -w            # 保存到硬件
    /etc/shadow                 # 账户影子文件
    LANG=en                     # 修改语言
    vim /etc/sysconfig/i18n     # 修改编码  LANG="en_US.UTF-8"
    export LC_ALL=C             # 强制字符集
    vi /etc/hosts               # 查询静态主机名
    alias                       # 别名
    watch uptime                # 监测命令动态刷新
    ipcs -a                     # 查看Linux系统当前单个共享内存段的最大值
    lsof |grep /lib             # 查看加载库文件
    ldconfig                    # 动态链接库管理命令
    dist-upgrade                # 会改变配置文件,改变旧的依赖关系，改变系统版本 
    /boot/grub/grub.conf        # grub启动项配置
    sysctl -p                   # 修改内核参数/etc/sysctl.conf，让/etc/rc.d/rc.sysinit读取生效
    mkpasswd -l 8  -C 2 -c 2 -d 4 -s 0            # 随机生成指定类型密码
    echo 1 > /proc/sys/net/ipv4/tcp_syncookies    # 使TCP SYN Cookie 保护生效  # "SYN Attack"是一种拒绝服务的攻击方式

    开机启动脚本顺序{

        /etc/profile
        /etc/profile.d/*.sh
        ~/bash_profile
        ~/.bashrc
        /etc/bashrc

    }

    进程管理{

        ps -eaf               # 查看所有进程
        kill -9 PID           # 强制终止某个PID进程
        kill -15 PID          # 安全退出 需程序内部处理信号
        cmd &                 # 命令后台运行
        nohup cmd &           # 后台运行不受shell退出影响
        ctrl+z                # 将前台放入后台(暂停)
        jobs                  # 查看后台运行程序
        bg 2                  # 启动后台暂停进程
        fg 2                  # 调回后台进程
        pstree                # 进程树
        vmstat 1 9            # 每隔一秒报告系统性能信息9次
        sar                   # 查看cpu等状态
        lsof file             # 显示打开指定文件的所有进程
        lsof -i:32768         # 查看端口的进程
        renice +1 180         # 把180号进程的优先级加1
        ps aux |grep -v USER | sort -nk +4 | tail       # 显示消耗内存最多的10个运行中的进程，以内存使用量排序.cpu +3    
        
        top{

            前五行是系统整体的统计信息。
            第一行: 任务队列信息，同 uptime 命令的执行结果。内容如下：
                01:06:48 当前时间
                up 1:22 系统运行时间，格式为时:分
                1 user 当前登录用户数
                load average: 0.06, 0.60, 0.48 系统负载，即任务队列的平均长度。
                三个数值分别为 1分钟、5分钟、15分钟前到现在的平均值。

            第二、三行:为进程和CPU的信息。当有多个CPU时，这些内容可能会超过两行。内容如下：
                Tasks: 29 total 进程总数
                1 running 正在运行的进程数
                28 sleeping 睡眠的进程数
                0 stopped 停止的进程数
                0 zombie 僵尸进程数
                Cpu(s): 0.3% us 用户空间占用CPU百分比
                1.0% sy 内核空间占用CPU百分比
                0.0% ni 用户进程空间内改变过优先级的进程占用CPU百分比
                98.7% id 空闲CPU百分比
                0.0% wa 等待输入输出的CPU时间百分比
                0.0% hi
                0.0% si

            第四、五行:为内存信息。内容如下：
                Mem: 191272k total 物理内存总量
                173656k used 使用的物理内存总量
                17616k free 空闲内存总量
                22052k buffers 用作内核缓存的内存量
                Swap: 192772k total 交换区总量
                0k used 使用的交换区总量
                192772k free 空闲交换区总量
                123988k cached 缓冲的交换区总量。
                内存中的内容被换出到交换区，而后又被换入到内存，但使用过的交换区尚未被覆盖，
                该数值即为这些内容已存在于内存中的交换区的大小。
                相应的内存再次被换出时可不必再对交换区写入。

            进程信息区,各列的含义如下:  # 显示各个进程的详细信息

            序号 列名    含义
            a   PID      进程id
            b   PPID     父进程id
            c   RUSER    Real user name
            d   UID      进程所有者的用户id
            e   USER     进程所有者的用户名
            f   GROUP    进程所有者的组名
            g   TTY      启动进程的终端名。不是从终端启动的进程则显示为 ?
            h   PR       优先级
            i   NI       nice值。负值表示高优先级，正值表示低优先级
            j   P        最后使用的CPU，仅在多CPU环境下有意义
            k   %CPU     上次更新到现在的CPU时间占用百分比
            l   TIME     进程使用的CPU时间总计，单位秒
            m   TIME+    进程使用的CPU时间总计，单位1/100秒
            n   %MEM     进程使用的物理内存百分比
            o   VIRT     进程使用的虚拟内存总量，单位kb。VIRT=SWAP+RES
            p   SWAP     进程使用的虚拟内存中，被换出的大小，单位kb。
            q   RES      进程使用的、未被换出的物理内存大小，单位kb。RES=CODE+DATA
            r   CODE     可执行代码占用的物理内存大小，单位kb
            s   DATA     可执行代码以外的部分(数据段+栈)占用的物理内存大小，单位kb
            t   SHR      共享内存大小，单位kb
            u   nFLT     页面错误次数
            v   nDRT     最后一次写入到现在，被修改过的页面数。
            w   S        进程状态。
                D=不可中断的睡眠状态
                R=运行
                S=睡眠
                T=跟踪/停止
                Z=僵尸进程
            x   COMMAND  命令名/命令行
            y   WCHAN    若该进程在睡眠，则显示睡眠中的系统函数名
            z   Flags    任务标志，参考 sched.h

        }

        linux操作系统提供的信号{
            
            kill -l                    # 查看linux提供的信号
            trap "echo aaa"  2 3 15    # shell使用 trap 捕捉退出信号

            # 发送信号一般有两种原因:
            #   1(被动式)  内核检测到一个系统事件.例如子进程退出会像父进程发送SIGCHLD信号.键盘按下control+c会发送SIGINT信号
            #   2(主动式)  通过系统调用kill来向指定进程发送信号                             
            # 进程结束信号 SIGTERM 和 SIGKILL 的区别:  SIGTERM 比较友好，进程能捕捉这个信号，根据您的需要来关闭程序。在关闭程序之前，您可以结束打开的记录文件和完成正在做的任务。在某些情况下，假如进程正在进行作业而且不能中断，那么进程可以忽略这个SIGTERM信号。
            # 如果一个进程收到一个SIGUSR1信号，然后执行信号绑定函数，第二个SIGUSR2信号又来了，第一个信号没有被处理完毕的话，第二个信号就会丢弃。

            SIGHUP  1          A     # 终端挂起或者控制进程终止
            SIGINT  2          A     # 键盘终端进程(如control+c)
            SIGQUIT 3          C     # 键盘的退出键被按下
            SIGILL  4          C     # 非法指令
            SIGABRT 6          C     # 由abort(3)发出的退出指令
            SIGFPE  8          C     # 浮点异常
            SIGKILL 9          AEF   # Kill信号  立刻停止
            SIGSEGV 11         C     # 无效的内存引用
            SIGPIPE 13         A     # 管道破裂: 写一个没有读端口的管道
            SIGALRM 14         A     # 闹钟信号 由alarm(2)发出的信号 
            SIGTERM 15         A     # 终止信号,可让程序安全退出 kill -15
            SIGUSR1 30,10,16   A     # 用户自定义信号1
            SIGUSR2 31,12,17   A     # 用户自定义信号2
            SIGCHLD 20,17,18   B     # 子进程结束自动向父进程发送SIGCHLD信号
            SIGCONT 19,18,25         # 进程继续（曾被停止的进程）
            SIGSTOP 17,19,23   DEF   # 终止进程
            SIGTSTP 18,20,24   D     # 控制终端（tty）上按下停止键
            SIGTTIN 21,21,26   D     # 后台进程企图从控制终端读
            SIGTTOU 22,22,27   D     # 后台进程企图从控制终端写
            
            缺省处理动作一项中的字母含义如下:
                A  缺省的动作是终止进程
                B  缺省的动作是忽略此信号，将该信号丢弃，不做处理
                C  缺省的动作是终止进程并进行内核映像转储(dump core),内核映像转储是指将进程数据在内存的映像和进程在内核结构中的部分内容以一定格式转储到文件系统，并且进程退出执行，这样做的好处是为程序员提供了方便，使得他们可以得到进程当时执行时的数据值，允许他们确定转储的原因，并且可以调试他们的程序。
                D  缺省的动作是停止进程，进入停止状况以后还能重新进行下去，一般是在调试的过程中（例如ptrace系统调用）
                E  信号不能被捕获
                F  信号不能被忽略
        }

    }

    日志管理{

        history                      # 历时命令默认1000条
        HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "   # 让history命令显示具体时间
        history  -c                  # 清除记录命令
        cat $HOME/.bash_history      # 历史命令记录文件
        last                         # 查看登陆过的用户信息
        who /var/log/wtmp            # 查看登陆过的用户信息
        lastlog                      # 用户最后登录的时间
        lastb -a                     # 列出登录系统失败的用户相关信息
        /var/log/btmp                # 登录失败二进制日志记录文件
        tail -f /var/log/messages    # 系统日志
        tail -f /var/log/secure      # ssh日志

    }

    selinux{

        sestatus -v                    # 查看selinux状态
        getenforce                     # 查看selinux模式
        setenforce 0                   # 设置selinux为宽容模式(可避免阻止一些操作)
        semanage port -l    # 查看selinux端口限制规则
        semanage port -a -t http_port_t -p tcp 8000  # 在selinux中注册端口类型
        vi /etc/selinux/config         # selinux配置文件
        SELINUX=enfoceing              # 关闭selinux 把其修改为  SELINUX=disabled

    }

    查看剩余内存{

        free -m
        #-/+ buffers/cache:       6458       1649
        #6458M为真实使用内存  1649M为真实剩余内存(剩余内存+缓存+缓冲器)
        #linux会利用所有的剩余内存作为缓存，所以要保证linux运行速度，就需要保证内存的缓存大小

    }
    
    系统信息{

        uname -a              # 查看Linux内核版本信息
        cat /proc/version     # 查看内核版本
        cat /etc/issue        # 查看系统版本
        lsb_release -a        # 查看系统版本  需安装 centos-release
        locale -a             # 列出所有语系
        hwclock               # 查看时间
        who                   # 当前在线用户
        w                     # 当前在线用户
        whoami                # 查看当前用户名
        logname               # 查看初始登陆用户名
        uptime                # 查看服务器启动时间
        sar -n DEV 1 10       # 查看网卡网速流量
        dmesg                 # 显示开机信息
        lsmod                  # 查看内核模块

    }
    
    硬件信息{

        more /proc/cpuinfo                                       # 查看cpu信息
        cat /proc/cpuinfo | grep name | cut -f2 -d: | uniq -c    # 查看cpu型号和逻辑核心数
        getconf LONG_BIT                                         # cpu运行的位数
        cat /proc/cpuinfo | grep physical | uniq -c              # 物理cpu个数
        cat /proc/cpuinfo | grep flags | grep ' lm ' | wc -l     # 结果大于0支持64位
        cat /proc/cpuinfo|grep flags                             # 查看cpu是否支持虚拟化   pae支持半虚拟化  IntelVT 支持全虚拟化
        more /proc/meminfo                                       # 查看内存信息
        dmidecode                                                # 查看全面硬件信息
        dmidecode | grep "Product Name"                          # 查看服务器型号
        dmidecode | grep -P -A5 "Memory\s+Device" | grep Size | grep -v Range       # 查看内存插槽
        cat /proc/mdstat                                         # 查看软raid信息
        cat /proc/scsi/scsi                                      # 查看Dell硬raid信息(IBM、HP需要官方检测工具)
        lspci                                                    # 查看硬件信息
        lspci|grep RAID                                          # 查看是否支持raid
        lspci -vvv |grep Ethernet                                # 查看网卡型号
        lspci -vvv |grep Kernel|grep driver                      # 查看驱动模块
        modinfo tg2                                              # 查看驱动版本(驱动模块)
        ethtool -i em1                                           # 查看网卡驱动版本

    }
    
    终端快捷键{

        Ctrl+A        　    # 行前
        Ctrl+E        　    # 行尾
        Ctrl+S        　    # 终端锁屏
        Ctrl+Q        　　  # 解锁屏
        Ctrl+D      　　    # 退出

    }

    开机启动模式{

        vi /etc/inittab
        id:3:initdefault:    # 3为多用户命令
        #ca::ctrlaltdel:/sbin/shutdown -t3 -r now   # 注释此行 禁止 ctrl+alt+del 关闭计算机

    }

    终端提示显示{

        echo $PS1                   # 环境变量控制提示显示
        PS1='[\u@ \H \w \A \@#]\$'
        PS1='[\u@\h \W]\$'

    }

    定时任务{

        at 5pm + 3 days /bin/ls  # 单次定时任务 指定三天后下午5:00执行/bin/ls
    
        crontab -e               # 编辑周期任务
        #分钟  小时    天  月  星期   命令或脚本
        1,30  1-3/2    *   *   *      命令或脚本  >> file.log 2>&1
        echo "40 7 * * 2 /root/sh">>/var/spool/cron/root    # 直接将命令写入周期任务
        crontab -l                                          # 查看自动周期性任务
        crontab -r                                          # 删除自动周期性任务
        cron.deny和cron.allow                               # 禁止或允许用户使用周期任务
        service crond start|stop|restart                    # 启动自动周期性服务

    }

    date{

        date -s 20091112                     # 设日期
        date -s 18:30:50                     # 设时间
        date -d "7 days ago" +%Y%m%d         # 7天前日期
        date -d "5 minute ago" +%H:%M        # 5分钟前时间
        date -d "1 month ago" +%Y%m%d        # 一个月前
        date +%Y-%m-%d -d '20110902'         # 日期格式转换
        date +%Y-%m-%d_%X                    # 日期和时间
        date +%N                             # 纳秒
        date -d "2012-08-13 14:00:23" +%s    # 换算成秒计算(1970年至今的秒数)
        date -d "@1363867952" +%Y-%m-%d-%T   # 将时间戳换算成日期
        date -d "1970-01-01 UTC 1363867952 seconds" +%Y-%m-%d-%T  # 将时间戳换算成日期
        date -d "`awk -F. '{print $1}' /proc/uptime` second ago" +"%Y-%m-%d %H:%M:%S"    # 格式化系统启动时间(多少秒前)

    }

    最大连接数{

        ulimit -SHn 65535  # 修改最大打开文件数(等同最大连接数)
        ulimit -a          # 查看
        
        /etc/security/limits.conf         # 进程最大打开文件数
        # nofile 可以被理解为是文件句柄数 文件描述符 还有socket数
        * soft nofile 65535
        * hard nofile 65535
        # 最大进程数
        * soft nproc 65535
        * hard nproc 65535

        # 如果/etc/security/limits.d/有配置文件，将会覆盖/etc/security/limits.conf里的配置
        # 即/etc/security/limits.d/的配置文件里就不要有同样的参量设置
        /etc/security/limits.d/90-nproc.conf    # centos6.3的最大进程数文件
        * soft nproc 65535       
        * hard nproc 65535

    }
    
    sudo{

        visudo     # sudo命令权限添加
        用户  别名(可用all)=NOPASSWD:命令1，命令2
        wangming linuxfan=NOPASSWD:/sbin/apache start,/sbin/apache restart
        UserName ALL=(ALL) ALL
        peterli        ALL=(ALL)       NOPASSWD:/sbin/service
        Defaults requiretty             # sudo不允许后台运行,注释此行既允许
        Defaults !visiblepw             # sudo不允许远程,去掉!既允许

    }

    grub开机启动项添加{

        vim /etc/grub.conf
        title ms-dos
        rootnoverify (hd0,0)
        chainloader +1

    }

    stty{

        #stty时一个用来改变并打印终端行设置的常用命令

        stty iuclc          # 在命令行下禁止输出大写
        stty -iuclc         # 恢复输出大写
        stty olcuc          # 在命令行下禁止输出小写
        stty -olcuc         # 恢复输出小写
        stty size           # 打印出终端的行数和列数
        stty eof "string"   # 改变系统默认ctrl+D来表示文件的结束 
        stty -echo          # 禁止回显
        stty echo           # 打开回显
        stty -echo;read;stty echo;read  # 测试禁止回显
        stty igncr          # 忽略回车符
        stty -igncr         # 恢复回车符
        stty erase '#'      # 将#设置为退格字符
        stty erase '^?'     # 恢复退格字符
        
        定时输入{
        
            timeout_read(){
                timeout=$1
                old_stty_settings=`stty -g`　　# save current settings
                stty -icanon min 0 time 100　　# set 10seconds,not 100seconds
                eval read varname　　          # =read $varname
                stty "$old_stty_settings"　　  # recover settings
            }
        
            read -t 10 varname    # 更简单的方法就是利用read命令的-t选项
        
        }

        检测用户按键{

            #!/bin/bash
            old_tty_settings=$(stty -g)   # 保存老的设置(为什么?). 
            stty -icanon
            Keypress=$(head -c1)          # 或者使用$(dd bs=1 count=1 2> /dev/null)
            echo "Key pressed was \""$Keypress"\"."
            stty "$old_tty_settings"      # 恢复老的设置. 
            exit 0

        }

    }

    iptables{

        内建三个表：nat mangle 和 filter
        filter预设规则表，有INPUT、FORWARD 和 OUTPUT 三个规则链
        vi /etc/sysconfig/iptables    # 配置文件
        INPUT    # 进入
        FORWARD  # 转发
        OUTPUT   # 出去
        ACCEPT   # 将封包放行
        REJECT   # 拦阻该封包
        DROP     # 丢弃封包不予处理
        -A         # 在所选择的链(INPUT等)末添加一条或更多规则
        -D       # 删除一条
        -E       # 修改
        -p         # tcp、udp、icmp    0相当于所有all    !取反
        -P       # 设置缺省策略(与所有链都不匹配强制使用此策略)
        -s         # IP/掩码    (IP/24)    主机名、网络名和清楚的IP地址 !取反
        -j         # 目标跳转，立即决定包的命运的专用内建目标
        -i         # 进入的（网络）接口 [名称] eth0
        -o         # 输出接口[名称] 
        -m         # 模块
        --sport  # 源端口
        --dport  # 目标端口
        
        iptables -F                        # 将防火墙中的规则条目清除掉  # 注意: iptables -P INPUT ACCEPT
        iptables-restore < 规则文件        # 导入防火墙规则
        /etc/init.d/iptables save          # 保存防火墙设置
        /etc/init.d/iptables restart       # 重启防火墙服务
        iptables -L -n                     # 查看规则
        iptables -t nat -nL                # 查看转发

        iptables实例{
            
            iptables -L INPUT                   # 列出某规则链中的所有规则
            iptables -X allowed                 # 删除某个规则链 ,不加规则链，清除所有非内建的
            iptables -Z INPUT                   # 将封包计数器归零
            iptables -N allowed                 # 定义新的规则链
            iptables -P INPUT DROP              # 定义过滤政策
            iptables -A INPUT -s 192.168.1.1    # 比对封包的来源IP   # ! 192.168.0.0/24  ! 反向对比
            iptables -A INPUT -d 192.168.1.1    # 比对封包的目的地IP
            iptables -A INPUT -i eth0           # 比对封包是从哪片网卡进入
            iptables -A FORWARD -o eth0         # 比对封包要从哪片网卡送出 eth+表示所有的网卡
            iptables -A INPUT -p tcp            # -p ! tcp 排除tcp以外的udp、icmp。-p all所有类型
            iptables -D INPUT 8                 # 从某个规则链中删除一条规则
            iptables -D INPUT --dport 80 -j DROP         # 从某个规则链中删除一条规则
            iptables -R INPUT 8 -s 192.168.0.1 -j DROP   # 取代现行规则
            iptables -I INPUT 8 --dport 80 -j ACCEPT     # 插入一条规则
            iptables -A INPUT -i eth0 -j DROP            # 其它情况不允许
            iptables -A INPUT -p tcp -s IP -j DROP       # 禁止指定IP访问
            iptables -A INPUT -p tcp -s IP --dport port -j DROP               # 禁止指定IP访问端口
            iptables -A INPUT -s IP -p tcp --dport port -j ACCEPT             # 允许在IP访问指定端口
            iptables -A INPUT -p tcp --dport 22 -j DROP                       # 禁止使用某端口
            iptables -A INPUT -i eth0 -p icmp -m icmp --icmp-type 8 -j DROP   # 禁止icmp端口
            iptables -A INPUT -i eth0 -p icmp -j DROP                         # 禁止icmp端口
            iptables -t filter -A INPUT -i eth0 -p tcp --syn -j DROP                  # 阻止所有没有经过你系统授权的TCP连接
            iptables -A INPUT -f -m limit --limit 100/s --limit-burst 100 -j ACCEPT   # IP包流量限制
            iptables -A INPUT -i eth0 -s 192.168.62.1/32 -p icmp -m icmp --icmp-type 8 -j ACCEPT  # 除192.168.62.1外，禁止其它人ping我的主机
            iptables -A INPUT -p tcp -m tcp --dport 80 -m state --state NEW -m recent --update --seconds 5 --hitcount 20 --rttl --name WEB --rsource -j DROP  # 可防御cc攻击(未测试)

        }

        iptables配置实例文件{

            # Generated by iptables-save v1.2.11 on Fri Feb  9 12:10:37 2007
            *filter
            :INPUT ACCEPT [637:58967]
            :FORWARD DROP [0:0]
            :OUTPUT ACCEPT [5091:1301533]
            # 允许的IP或IP段访问 建议多个
            -A INPUT -s 127.0.0.1 -p tcp -j ACCEPT
            -A INPUT -s 192.168.0.0/255.255.0.0 -p tcp -j ACCEPT
            # 开放对外开放端口
            -A INPUT -p tcp --dport 80 -j ACCEPT
            # 指定某端口针对IP开放
            -A INPUT -s 192.168.10.37 -p tcp --dport 22 -j ACCEPT
            # 拒绝所有协议(INPUT允许)
            -A INPUT -p tcp -m tcp --tcp-flags FIN,SYN,RST,PSH,URG RST -j DROP
            # 允许已建立的或相关连的通行
            iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
            # 拒绝ping
            -A INPUT -p tcp -m tcp -j REJECT --reject-with icmp-port-unreachable
            COMMIT
            # Completed on Fri Feb  9 12:10:37 2007

        }

        iptables配置实例{

            # 允许某段IP访问任何端口
            iptables -A INPUT -s 192.168.0.3/24 -p tcp -j ACCEPT
            # 设定预设规则 (拒绝所有的数据包，再允许需要的,如只做WEB服务器.还是推荐三个链都是DROP)
            iptables -P INPUT DROP
            iptables -P FORWARD DROP
            iptables -P OUTPUT ACCEPT
            # 注意: 直接设置这三条会掉线
            # 开启22端口
            iptables -A INPUT -p tcp --dport 22 -j ACCEPT
            # 如果OUTPUT 设置成DROP的，要写上下面一条
            iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT 
            # 注:不写导致无法SSH.其他的端口一样,OUTPUT设置成DROP的话,也要添加一条链
            # 如果开启了web服务器,OUTPUT设置成DROP的话,同样也要添加一条链
            iptables -A OUTPUT -p tcp --sport 80 -j ACCEPT
            # 做WEB服务器,开启80端口 ,其他同理
            iptables -A INPUT -p tcp --dport 80 -j ACCEPT
            # 做邮件服务器,开启25,110端口
            iptables -A INPUT -p tcp --dport 110 -j ACCEPT
            iptables -A INPUT -p tcp --dport 25 -j ACCEPT
            # 允许icmp包通过,允许ping
            iptables -A OUTPUT -p icmp -j ACCEPT (OUTPUT设置成DROP的话) 
            iptables -A INPUT -p icmp -j ACCEPT  (INPUT设置成DROP的话)
            # 允许loopback!(不然会导致DNS无法正常关闭等问题) 
            IPTABLES -A INPUT -i lo -p all -j ACCEPT (如果是INPUT DROP)
            IPTABLES -A OUTPUT -o lo -p all -j ACCEPT(如果是OUTPUT DROP)

        }

        添加网段转发{

            # 例如通过vpn上网
            echo 1 > /proc/sys/net/ipv4/ip_forward       # 在内核里打开ip转发功能
            iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -j MASQUERADE  # 添加网段转发
            iptables -t nat -A POSTROUTING -s 10.0.0.0/255.0.0.0 -o eth0 -j SNAT --to 192.168.10.158  # 原IP网段经过哪个网卡IP出去
            iptables -t nat -nL                # 查看转发

        }
            
        端口映射{
            
            # 内网通过有外网IP的机器映射端口
            echo 1 > /proc/sys/net/ipv4/ip_forward       # 在内核里打开ip转发功能
            route add -net 10.10.20.0 netmask 255.255.255.0 gw 10.10.20.111     # 内网需要添加默认网关，并且网关开启转发
            iptables -t nat -A PREROUTING -d 192.168.10.158  -p tcp --dport 9999 -j DNAT --to 10.10.20.55:22
            iptables -t nat -nL                # 查看转发

        }

    }

}

4服务{

    /etc/init.d/sendmail start                   # 启动服务  
    /etc/init.d/sendmail stop                    # 关闭服务
    /etc/init.d/sendmail status                  # 查看服务当前状态
    /date/mysql/bin/mysqld_safe --user=mysql &   # 启动mysql后台运行
    vi /etc/rc.d/rc.local                        # 开机启动执行  可用于开机启动脚本
    /etc/rc.d/rc3.d/S55sshd                      # 开机启动和关机关闭服务连接    # S开机start  K关机stop  55级别 后跟服务名
    ln -s -f /date/httpd/bin/apachectl /etc/rc.d/rc3.d/S15httpd   # 将启动程序脚本连接到开机启动目录
    ipvsadm -ln                                  # lvs查看后端负载机并发
    ipvsadm -C                                   # lvs清除规则
    xm list                                      # 查看xen虚拟主机列表
    virsh                                        # 虚拟化(xen\kvm)管理工具  yum groupinstall Virtual*
    ./bin/httpd -M                               # 查看httpd加载模块
    httpd -t -D DUMP_MODULES                     # rpm包httpd查看加载模块
    echo 内容| /bin/mail -s "标题" 收件箱 -- -f 发件人       # 发送邮件
    "`echo "内容"|iconv -f utf8 -t gbk`" | /bin/mail -s "`echo "标题"|iconv -f utf8 -t gbk`" 收件箱     # 解决邮件乱码
    /usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg   # 检测nagios配置文件

    chkconfig{

        chkconfig 服务名 on|off|set              # 设置非独立服务启状态
        chkconfig --level 35   httpd   off       # 让服务不自动启动
        chkconfig --level 35   httpd   on        # 让服务自动启动 35指的是运行级别
        chkconfig --list                         # 查看所有服务的启动状态
        chkconfig --list |grep httpd             # 查看某个服务的启动状态
        chkconfig –-list [服务名称]              # 查看服务的状态

    }

    httpd{

        编译参数{

            # so模块用来提供DSO支持的apache核心模块
            # 如果编译中包含任何DSO模块，则mod_so会被自动包含进核心。
            # 如果希望核心能够装载DSO，但不实际编译任何DSO模块，则需明确指定"--enable-so=static"

            ./configure --prefix=/usr/local/apache --enable-so --enable-mods-shared=most --enable-rewrite --enable-forward  # 实例编译

            --with-mpm=worker # 已worker方式运行
            --with-apxs=/usr/local/apache/bin/apxs  # 制作apache的动态模块DSO rpm包 httpd-devel  #编译模块 apxs -i -a -c mod_foo.c
            --enable-so # 让Apache可以支持DSO模式
            --enable-mods-shared=most # 告诉编译器将所有标准模块都动态编译为DSO模块
            --enable-rewrite # 支持地址重写功能
            --enable-module=most # 用most可以将一些不常用的，不在缺省常用模块中的模块编译进来
            --enable-mods-shared=all # 意思是动态加载所有模块，如果去掉-shared话，是静态加载所有模块
            --enable-expires # 可以添加文件过期的限制，有效减轻服务器压力，缓存在用户端，有效期内不会再次访问服务器，除非按f5刷新，但也导致文件更新不及时
            --enable-deflate # 压缩功能，网页可以达到40%的压缩，节省带宽成本，但会对cpu压力有一点提高
            --enable-headers # 文件头信息改写，压缩功能需要
            --disable-MODULE  # 禁用MODULE模块(仅用于基本模块)
            --enable-MODULE=shared  # 将MODULE编译为DSO(可用于所有模块) 
            --enable-mods-shared=MODULE-LIST   # 将MODULE-LIST中的所有模块都编译成DSO(可用于所有模块) 
            --enable-modules=MODULE-LIST   # 将MODULE-LIST静态连接进核心(可用于所有模块)
            
            # 上述 MODULE-LIST 可以是:
            1、用引号界定并且用空格分隔的模块名列表  --enable-mods-shared='headers rewrite dav'
            2、"most"(大多数模块)  --enable-mods-shared=most 
            3、"all"(所有模块)

        }

        转发{

            #针对非80端口的请求处理
            RewriteCond %{SERVER_PORT} !^80$
            RewriteRule ^/(.*)         http://fully.qualified.domain.name:%{SERVER_PORT}/$1 [L,R]

            RewriteCond %{HTTP_HOST} ^ss.aa.com [NC]
            RewriteRule  ^(.*)  http://www.aa.com/so/$1/0/p0?  [L,R=301]
            #RewriteRule 只对?前处理，所以会把?后的都保留下来
            #在转发后地址后加?即可取消RewriteRule保留的字符
            #R的含义是redirect，即重定向，该请求不会再被apache交给后端处理，而是直接返回给浏览器进行重定向跳转。301是返回的http状态码，具体可以参考http rfc文档，跳转都是3XX。
            #L是last，即最后一个rewrite规则，如果请求被此规则命中，将不会继续再向下匹配其他规则。    

        }

    }

    mysql源码安装{
    
        groupadd mysql
        useradd mysql -g mysql -M -s /bin/false
        tar zxvf mysql-5.0.22.tar.gz
        cd mysql-5.0.22
        ./configure  --prefix=/usr/local/mysql \
        --with-client-ldflags=-all-static \
        --with-mysqld-ldflags=-all-static \
        --with-mysqld-user=mysql \
        --with-extra-charsets=all \
        --with-unix-socket-path=/var/tmp/mysql.sock
        make  &&   make  install
        # 生成mysql用户数据库和表文件，在安装包中输入
        scripts/mysql_install_db  --user=mysql
        vi ~/.bashrc
        export PATH="$PATH: /usr/local/mysql/bin"
        # 配置文件,有large,medium,small三个，根据机器性能选择
        cp support-files/my-medium.cnf /etc/my.cnf
        cp support-files/mysql.server /etc/init.d/mysqld
        chmod 700 /etc/init.d/mysqld
        cd /usr/local
        chmod 750 mysql -R
        chgrp mysql mysql -R
        chown mysql mysql/var -R
        cp  /usr/local/mysql/libexec/mysqld mysqld.old
        ln -s /usr/local/mysql/bin/mysql /sbin/mysql
        ln -s /usr/local/mysql/bin/mysqladmin /sbin/mysqladmin
        ln -s -f /usr/local/mysql/bin/mysqld_safe /etc/rc.d/rc3.d/S15mysql5
        ln -s -f /usr/local/mysql/bin/mysqld_safe /etc/rc.d/rc0.d/K15mysql5
        
    }

    mysql常用命令{
        
        ./mysql/bin/mysqld_safe --user=mysql &   # 启动mysql服务
        ./mysql/bin/mysqladmin -uroot -p -S ./mysql/data/mysql.sock shutdown    # 停止mysql服务
        mysqlcheck -uroot -p -S mysql.sock --optimize --databases account       # 检查、修复、优化MyISAM表
        mysqlbinlog slave-relay-bin.000001              # 查看二进制日志(报错加绝对路径)
        mysqladmin -h myhost -u root -p create dbname   # 创建数据库

        flush privileges;             # 刷新
        show databases;               # 显示所有数据库
        use dbname;                      # 打开数据库
        show tables;                  # 显示选中数据库中所有的表
        desc tables;                  # 查看表结构
        drop database name;           # 删除数据库
        drop table name;              # 删除表
        create database name;         # 创建数据库
        select 列名称 from 表名称;    # 查询
        show grants for repl;         # 查看用户权限
        show processlist;             # 查看mysql进程
        select user();                # 查看所有用户
        show slave status\G;          # 查看主从状态
        show variables;               # 查看所有参数变量
        show table status             # 查看表的引擎状态
        drop table if exists user                       # 表存在就删除
        create table if not exists user                 # 表不存在就创建
        select host,user,password from user;            # 查询用户权限 先use mysql
        create table ka(ka_id varchar(6),qianshu int);  # 创建表
        SHOW VARIABLES LIKE 'character_set_%';          # 查看系统的字符集和排序方式的设定
        show variables like '%timeout%';                # 查看超时(wait_timeout)
        delete from user where user='';                 # 删除空用户
        delete from user where user='sss' and host='localhost' ;    # 删除用户
        ALTER TABLE mytable ENGINE = MyISAM ;                       # 改变现有的表使用的存储引擎
        SHOW TABLE STATUS from  库名  where Name='表名';            # 查询表引擎
        CREATE TABLE innodb (id int, title char(20)) ENGINE = INNODB                     # 创建表指定存储引擎的类型(MyISAM或INNODB)
        grant replication slave on *.* to '用户'@'%' identified by '密码';               # 创建主从复制用户
        ALTER TABLE player ADD INDEX weekcredit_faction_index (weekcredit, faction);     # 添加索引
        alter table name add column accountid(列名)  int(11) NOT NULL(字段不为空);       # 插入字段
        update host set monitor_state='Y',hostname='xuesong' where ip='192.168.1.1';     # 更新数据
        
        自增表{
        
            create table oldBoy  (id INTEGER  PRIMARY KEY AUTO_INCREMENT, name CHAR(30) NOT NULL, age integer , sex CHAR(15) );  # 创建自增表
            insert into oldBoy(name,age,sex) values(%s,%s,%s)  # 自增插入数据
            
        }

        登录mysql的命令{

            # 格式： mysql -h 主机地址 -u 用户名 -p 用户密码
            mysql -h110.110.110.110 -P3306 -uroot -p
            mysql -uroot -p -S /data1/mysql5/data/mysql.sock -A  --default-character-set=GBK

        }
        
        shell执行mysql命令{

            mysql -u$username -p$passwd -h$dbhost -P$dbport -A -e "      
            use $dbname;
            delete from data where date=('$date1');
            "    # 执行多条mysql命令
            mysql -uroot -p -S mysql.sock -e "use db;alter table gift add column accountid  int(11) NOT NULL;flush privileges;"    # 不登陆mysql插入字段

        }

        备份数据库{

            mysqldump -h host -u root -p --default-character-set=utf8 dbname >dbname_backup.sql               # 不包括库名，还原需先创建库，在use 
            mysqldump -h host -u root -p --database --default-character-set=utf8 dbname >dbname_backup.sql    # 包括库名，还原不需要创建库
            /bin/mysqlhotcopy -u root -p    # mysqlhotcopy只能备份MyISAM引擎
            mysqldump -u root -p -S mysql.sock --default-character-set=utf8 dbname table1 table2  > /data/db.sql    # 备份表
            mysqldump -uroot -p123  -d database > database.sql    # 备份数据库结构
            
            innobackupex --user=root --password="" --defaults-file=/data/mysql5/data/my_3306.cnf --socket=/data/mysql5/data/mysql.sock --slave-info --stream=tar --tmpdir=/data/dbbackup/temp /data/dbbackup/ 2>/data/dbbackup/dbbackup.log | gzip 1>/data/dbbackup/db50.tar.gz   # xtrabackup备份需单独安装软件 优点: 速度快,压力小,可直接恢复主从复制

        }
         
        还原数据库{

            mysql -h host -u root -p dbname < dbname_backup.sql   
            source 路径.sql   # 登陆mysql后还原sql文件

        }
        
        赋权限{

            # 指定IP: $IP  本机: localhost   所有IP地址: %   # 通常指定多条
            grant all on zabbix.* to user@"$IP";             # 对现有账号赋予权限
            grant select on database.* to user@"%" Identified by "passwd";     # 赋予查询权限(没有用户，直接创建)
            grant all privileges on database.* to user@"$IP" identified by 'passwd';         # 赋予指定IP指定用户所有权限(不允许对当前库给其他用户赋权限)
            grant all privileges on database.* to user@"localhost" identified by 'passwd' with grant option;   # 赋予本机指定用户所有权限(允许对当前库给其他用户赋权限)
            grant select, insert, update, delete on database.* to user@'ip'identified by "passwd";   # 开放管理操作指令
            revoke all on *.* from user@localhost;     # 回收权限

        }

        更改密码{

            update user set password=password('passwd') where user='root'
            mysqladmin -u root password 'xuesong'

        }

        mysql忘记密码后重置{

            cd /data/mysql5
            /data/mysql5/bin/mysqld_safe --user=mysql --skip-grant-tables --skip-networking &
            update user set password=password('123123') where user='root';

        }
        
        mysql主从复制失败恢复{

            slave stop;
            reset slave;
            change master to master_host='10.10.10.110',master_port=3306,master_user='repl',master_password='repl',master_log_file='master-bin.000010',master_log_pos=107,master_connect_retry=60;
            slave start;

        }
        
        检测mysql主从复制延迟{
            
            1、在从库定时执行更新主库中的一个timeout数值
            2、同时取出从库中的timeout值对比判断从库与主库的延迟
        
        }
    }

    mongodb{

        一、启动{
        
            # 不启动认证
            ./mongod --port 27017 --fork --logpath=/opt/mongodb/mongodb.log --logappend --dbpath=/opt/mongodb/data/
            # 启动认证
            ./mongod --port 27017 --fork --logpath=/opt/mongodb/mongodb.log --logappend --dbpath=/opt/mongodb/data/ --auth

            # 配置文件方式启动
            cat /opt/mongodb/mongodb.conf
              port=27017                       # 端口号
              fork=true                        # 以守护进程的方式运行，创建服务器进程
              auth=true                        # 开启用户认证
              logappend=true                   # 日志采用追加方式
              logpath=/opt/mongodb/mongodb.log # 日志输出文件路径
              dbpath=/opt/mongodb/data/        # 数据库路径
              shardsvr=true                    # 设置是否分片
              maxConns=600                     # 数据库的最大连接数
            ./mongod -f /opt/mongodb/mongodb.conf
            
            # 其他参数
            bind_ip         # 绑定IP  使用mongo登录需要指定对应IP
            journal         # 开启日志功能,降低单机故障的恢复时间,取代dur参数
            syncdelay       # 系统同步刷新磁盘的时间,默认60秒
            directoryperdb  # 每个db单独存放目录,建议设置.与mysql独立表空间类似
            repairpath      # 执行repair时的临时目录.如果没开启journal,出现异常重启,必须执行repair操作
            # mongodb没有参数设置内存大小.使用os mmap机制缓存数据文件,在数据量不超过内存的情况下,效率非常高.数据量超过系统可用内存会影响写入性能

        }

        二、关闭{

            # 方法一:登录mongodb
            ./mongo
            use admin
            db.shutdownServer()

            # 方法:kill传递信号  两种皆可
            kill -2 pid
            kill -15 pid

        }

        三、开启认证与用户管理{

            ./mongo                      # 先登录
            use admin                    # 切换到admin库
            db.addUser("root","123456")                     # 创建用户
            db.addUser('zhansan','pass',true)               # 如果用户的readOnly为true那么这个用户只能读取数据，添加一个readOnly用户zhansan
            ./mongo 127.0.0.1:27017/mydb -uroot -p123456    # 再次登录,只能针对用户所在库登录
            #虽然是超级管理员，但是admin不能直接登录其他数据库，否则报错
            #Fri Nov 22 15:03:21.886 Error: 18 { code: 18, ok: 0.0, errmsg: "auth fails" } at src/mongo/shell/db.js:228
            show collections                                # 查看链接状态 再次登录使用如下命令,显示错误未经授权
            db.system.users.find();                         # 查看创建用户信息
            db.system.users.remove({user:"zhansan"})        # 删除用户

            #恢复密码只需要重启mongodb 不加--auth参数

        }

        四、登录{

            192.168.1.5:28017      # http登录后可查看状态
            ./mongo                # 默认登录后打开 test 库
            ./mongo 192.168.1.5:27017/databaseName      # 直接连接某个库 不存在则创建  启动认证需要指定对应库才可登录

        }

        五、查看状态{

            #登录后执行命令查看状态
            db.runCommand({"serverStatus":1})
                globalLock         # 表示全局写入锁占用了服务器多少时间(微秒)
                mem                # 包含服务器内存映射了多少数据,服务器进程的虚拟内存和常驻内存的占用情况(MB)
                indexCounters      # 表示B树在磁盘检索(misses)和内存检索(hits)的次数.如果这两个比值开始上升,就要考虑添加内存了
                backgroudFlushing  # 表示后台做了多少次fsync以及用了多少时间
                opcounters         # 包含每种主要擦撞的次数
                asserts            # 统计了断言的次数

            #状态信息从服务器启动开始计算,如果过大就会复位,发送复位，所有计数都会复位,asserts中的roolovers值增加

            #mongodb自带的命令
            ./mongostat
                insert     #每秒插入量
                query      #每秒查询量
                update     #每秒更新量
                delete     #每秒删除量
                locked     #锁定量
                qr|qw      #客户端查询排队长度(读|写)
                ar|aw      #活跃客户端量(读|写)
                conn       #连接数
                time       #当前时间

        }

        六、常用命令{

            db.listCommands()     # 当前MongoDB支持的所有命令（同样可通过运行命令db.runCommand({"listCommands" : `1})来查询所有命令）

            db.runCommand({"buildInfo" : 1})                # 返回MongoDB服务器的版本号和服务器OS的相关信息。
            db.runCommand({"collStats" : 集合名})           # 返回该集合的统计信息，包括数据大小，已分配存储空间大小，索引的大小等。
            db.runCommand({"distinct" : 集合名, "key" : 键, "query" : 查询文档})     # 返回特定文档所有符合查询文档指定条件的文档的指定键的所有不同的值。
            db.runCommand({"dropDatabase" : 1})             # 清空当前数据库的信息，包括删除所有的集合和索引。
            db.runCommand({"isMaster" : 1})                 # 检查本服务器是主服务器还是从服务器。
            db.runCommand({"ping" : 1})                     # 检查服务器链接是否正常。即便服务器上锁，该命令也会立即返回。
            db.runCommand({"repaireDatabase" : 1})          # 对当前数据库进行修复并压缩，如果数据库特别大，这个命令会非常耗时。
            db.runCommand({"serverStatus" : 1})             # 查看这台服务器的管理统计信息。
            # 某些命令必须在admin数据库下运行，如下两个命令：
            db.runCommand({"renameCollection" : 集合名, "to"：集合名})     # 对集合重命名，注意两个集合名都要是完整的集合命名空间，如foo.bar, 表示数据库foo下的集合bar。
            db.runCommand({"listDatabases" : 1})                           # 列出服务器上所有的数据库

        }

        七、进程控制{

            db.currentOp()                  # 查看活动进程
            db.$cmd.sys.inprog.findOne()    # 查看活动进程 与上面一样
                opid   # 操作进程号
                op     # 操作类型(查询\更新)
                ns     # 命名空间,指操作的是哪个对象
                query  # 如果操作类型是查询,这里将显示具体的查询内容
                lockType  # 锁的类型,指明是读锁还是写锁

            db.killOp(opid值)                         # 结束进程
            db.$cmd.sys.killop.findOne({op:opid值})   # 结束进程

        }

        八、备份还原{

            ./mongoexport -d test -c t1 -o t1.dat                 # 导出JSON格式
                -c         # 指明导出集合
                -d         # 使用库
            ./mongoexport -d test -c t1 -csv -f num -o t1.dat     # 导出csv格式
                -csv       # 指明导出csv格式
                -f         # 指明需要导出那些例

            db.t1.drop()                    # 登录后删除数据
            ./mongoimport -d test -c t1 -file t1.dat                           # mongoimport还原JSON格式
            ./mongoimport -d test -c t1 -type csv --headerline -file t1.dat    # mongoimport还原csv格式数据
                --headerline                # 指明不导入第一行 因为第一行是列名

            ./mongodump -d test -o /bak/mongodump                # mongodump数据备份
            ./mongorestore -d test --drop /bak/mongodump/*       # mongorestore恢复
                --drop      #恢复前先删除
            db.t1.find()    #查看

            # mongodump 虽然能不停机备份,但市区了获取实时数据视图的能力,使用fsync命令能在运行时复制数据目录并且不会损坏数据
            # fsync会强制服务器将所有缓冲区的数据写入磁盘.配合lock还阻止对数据库的进一步写入,知道释放锁为止
            # 备份在从库上备份，不耽误读写还能保证实时快照备份
            db.runCommand({"fsync":1,"lock":1})   # 执行强制更新与写入锁
            db.$cmd.sys.unlock.findOne()          # 解锁
            db.currentOp()                        # 查看解锁是否正常

        }

        九、修复{

            # 当停电或其他故障引起不正常关闭时,会造成部分数据损坏丢失
            ./mongod --repair      # 修复操作:启动时候加上 --repair
            # 修复过程:将所有文档导出,然后马上导入,忽略无效文档.完成后重建索引。时间较长,会丢弃损坏文档
            # 修复数据还能起到压缩数据库的作用
            db.repairDatabase()    # 运行中的mongodb可使用 repairDatabase 修复当前使用的数据库
            {"repairDatabase":1}   # 通过驱动程序

        }

        十、python使用mongodb{

            原文: http://blog.nosqlfan.com/html/2989.html
            
            easy_install pymongo      # 安装(python2.7+)
            import pymongo
            connection=pymongo.Connection('localhost',27017)   # 创建连接
            db = connection.test_database                      # 切换数据库
            collection = db.test_collection                    # 获取collection
            # db和collection都是延时创建的，在添加Document时才真正创建

            文档添加, _id自动创建
                import datetime
                post = {"author": "Mike",
                    "text": "My first blog post!",
                    "tags": ["mongodb", "python", "pymongo"],
                    "date": datetime.datetime.utcnow()}
                posts = db.posts
                posts.insert(post)
                ObjectId('...')

            批量插入
                new_posts = [{"author": "Mike",
      