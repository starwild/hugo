---
title: "Redis 介绍"
date: 2017-10-17T13:45:00+08:00
draft: false
---
##  Redis应用介绍#
### 引文 ###
#### 简介 ####
Redis诞生于2009年，是一个用ANSI C写成，基于键值对的可持久化开源内存数据库，最新版本为4.0.2。它提供对多种抽象数据结构的支持。授权类型为对商业友好的BSD授权。Redis是“REmote DIctionary Server”中大写字母的缩写。在DB-Engines排行上，经常被评为最受欢迎的键值对数据库。
##### 对编程语言的支持 #####
Redis支持众多编程语言，包括常见的C/C++，C#，GO，Java, JavaScript（Nodejs）, PHP, Python, Ruby等。
##### 数据结构 #####
使Redis变得流行的原因包括它内建多种实用的数据结构。Redis支持对数据的原子操作，对Set类型的集合操作等高级命令。目前Redis可支持的数据结构有string, lists, map, set, sorted set, bitmap, HyperLogLog, geo。
##### 原子性  #####
Redis的单个操作有是原 子性，多个操作支持使用事务来保证数据安全。
##### 持久化 #####
通常Redis将所有数据都放在内存中以加快操作速度。为了保障数据的安全，Redis提供了持久化的方案。用户可以选择使用RDB（Redis database
）快照，每隔一段时间将Redis在内存中的数据完整地写入到磁盘中，或者使用AOF（append-only file）来定时将数据变更日志写入到磁盘中,来增加系统的鲁棒性。
##### 主从（master-slave）复制 #####
主从复制有利于系统读取速度，和数据冗余。Redis的master可以支持任意个slave。slave本身又可以作为其他slave的master。master-slave组成的集群就成了一个树形结构。Redis实现了完整的发布订阅功能。slave订阅一个channel以后，可以收到发送给master的消息，由此更新整个master-slave结构。
##### 性能 #####
因为不必把变更写入磁盘，与需要遵守ACID的传统数据库相比，Redis有更高的效率，很容易支持10万/s以上的读写频率。除了AOF操作会多出一个线程外，通常一个Redis实例只有一个线程用于数据操作。因此，单个Redis不能并行执行任务，比如执行存储过程。
##### 集群 #####
Redis在3.0版本推出了集群功能。Redis集群致力于在不使用代理额异步复制的情况下实现1000个节点以内的高性能线性伸缩。对集群写入时，能尽量保证写入的一致性。当有mater或者slave宕机时，集群能够自我调节，自动平衡分配master和slave。

### 安装 ###

> redis在windows平台还没有官方支持。但是用户可以使用cygwin在windows下面编译使用。

```bash
$ wget http://download.redis.io/releases/redis-4.0.2.tar.gz
$ tar xzf redis-4.0.2.tar.gz
$ cd redis-4.0.2
$ make
# 暂时不安装到系统
$ cd src
$ ./redis-server
# 开启另一个终端
$ cd <刚才的src目录>
$ ./redis-cli
# 现在进入到了Redis的命令行环境，测试一下
127.0.0.1:6379> set hello world
OK
127.0.0.1:6379> get hello
"world"
127.0.0.1:6379> shutdown
not connected> 
```
### 使用 ###

#### 常见使用场景简介 ####
1. 根据二八原则，数据库中的大部分数据都是不经常使用的数据。虽然Redis用于页面缓存效果很好，但是越往前端走，数据的变化几率越大。Redis在DAO层使用的使用则很简单，加速效果也很明显。
2. Redis可以通过Session插件，替代服务器本身实现的Session。使用Redis作为session存储，就没有了分布式环境下的session复制问题。由于Redis在内存中的数据可以持久化，在突然宕机的情况下，应用重新启动能够最大限度地恢复已有会话。
3. 得力于Redis内置的数据结构支持，其他程序可以使用redis的list作为公共的操作队列，每个list可以存放约40亿个数据，可以选择固定list长度来只保留最新的数据。
4. Redis的Set集合可以实现传统数据库不方便实现的集合操作，如多个集合的交集、并集。使用SRANDMEMBER可以随机获取元素，方便实现抽奖功能。
5. Redis的String实现了二进制安全，可以存放任意类型的数据。配合incr、incrby、decr、decrby进行原子性的递增递减操作，可以用于实现计数器。
6. Sorted-Sets提供可以高效操作的有序集合，适合快速统计区间，排行情况。
7. redis3.2版本新增了地理位置支持。包括获取某范围内的地理位置，获取两个地理位置的距离等。非常适合LBS类应用。
8. 使用Redis实现分布式锁。使用Redis存放一个lock值，如果lock存在则存放失败，并给lock设置超时时间以免死锁。

#### Redis高可用方案

##### 主从 Replication

主从分离是简单的异步复制方案。写入由master负责，Slave只负责读取，减少Master的处理负担。需要注意的是，Slave的数据通过异步复制来提高效率。所以Master和Slave的数据有不一致的可能。

```
                    +-----------+
                    | Master    |
                    +----+------+
                         |
       +--------------------------------------+
       |                 |                    |
       |                 |                    |
+------v-----+      +-----------+      +------v-----+
|  Slave     |      | Slave     |      | Slave      |
+------------+      +-----------+      +------------+
```

###### 配置文件

1. 复制Redis目录下的redis.conf到master、slave01、slave02、slave03文件夹。以下配置无特殊说明都在各自的redis.conf中配置。

2. 修改端口号：通过修改redis.conf来修改master的端口号为6900，依次修改slave为6901、6902、6903。

   ```bash
   port 6900
   ```

3. 修改pid：pid文件就是redis的启动锁，所以需要给master和slave单独指定pid文件，这里Master的配置使用端口号来区分redis。Slave的配置相似。

   ```bash
   pidfile /var/run/redis_6900.pid
   ```

4. Slave连接Master，需要在配置中指定ip地址和端口号。如果Master有密码，还要配置masterauth

   ```bash
   slaveof 127.0.0.1 6900
   ```
   ```bash
   # If the master is password protected (using the "requirepass" configuration
   # directive below) it is possible to tell the slave to authenticate before
   # starting the replication synchronization process, otherwise the master will
   # refuse the slave request.
   #
   # masterauth <master-password>
   ```
   读写分离，需要在Master中配置slave-read-only，Redis默认配置为yes
   ```bash
   slave-read-only yes
   ```

5. 启动Master，检查进程和端口占用情况。Master占用了6900并且已经开始服务。

   ```bash
   # 启动Master
   redis-server master00/redis.conf
   # 检查运行情况
   ps -ef | grep redis-server
   > root     31707 31141  0 10:07 pts/0    00:00:00 ./redis-server 127.0.0.1:6900
   # 使用客户端连接Master
   redis-cli -p 6900
   # 使用info检查Master运行情况
   127.0.0.1:6900> info
   # Server
   redis_version:4.0.1
   redis_git_sha1:00000000
   redis_git_dirty:0
   redis_build_id:c6561a899728564f
   redis_mode:standalone
   os:Linux 4.4.0-62-generic x86_64
   arch_bits:64
   multiplexing_api:epoll
   atomicvar_api:atomic-builtin
   gcc_version:5.4.0
   process_id:31707
   run_id:9ad3b08ab0df9a99fc65b92c3d835c6737efa09c
   tcp_port:6900
   uptime_in_seconds:79
   uptime_in_days:0
   hz:10
   lru_clock:15897904
   executable:/www/server/redis/src/./redis-server
   config_file:/www/server/redis/master-slave/master00/redis.conf
   # 启动slave
   redis-server slave01/redis.conf
   899:S 27 Oct 10:29:51.169 * Ready to accept connections
   899:S 27 Oct 10:29:51.169 * Connecting to MASTER 127.0.0.1:6900
   899:S 27 Oct 10:29:51.169 * MASTER <-> SLAVE sync started
   ```

##### 哨兵 Sentinel

哨兵Sentinel，是Redis官方的高可用性解决方案，下面统称哨兵。如同它的名字一样，哨兵实例作为Redis集群的监管人，时刻监视者多个主服务器和从服务器。当主服务器意外宕机或者出现写入不稳定的时候，哨兵就会进行主从切换（failover）挑选一个从服务器作为主服务器来继续维持主从结构。因为哨兵的工作原理，至少需要三个哨兵实例共同协作，因此也需要三个配置文件。下面修改哨兵的配置文件sentinel00.conf

###### 配置

1. 配置哨兵的端口

   ```bash
   port 26901
   ```

2. 配置需要监控的主服务器

   ```bash
   # 最后面的2表示至少需要2个哨兵实例的同意才可以执行failover
   sentinel monitor mymaster 127.0.0.1 6900 2
   ```

3. 启动哨兵

   ```bash
   redis-sentinel sentinel00.conf
   ```

###### 协作

上面的配置中，并没有指定哨兵之间的关系。那么哨兵之间是如何协作的呢？启动哨兵的时候，它会使用Redis的发布和订阅功能，发布自己存在的情况。哨兵之间建立联系后，是用特殊协议gossip来互相传递信息。如果哨兵发现某个master挂了，为了防止因为网络延迟的原因误判，那么它会征求其他哨兵的意见。如果任务此master挂掉的哨兵数量超过上面哨兵配置中设定的值，那么哨兵才会执行主从切换。所以哨兵的数量至少为三个。因为slave只读，如果一个哨兵发现某个slave挂了，不用询问其他哨兵，会之间在可用列表中去除这个slave。

##### 集群 Redis Cluster

Redis的集群实际上是多个实例共同存储数据。有些类似与oracle分区表中的hash分区。由于集群分区存储数据，多个key有可能并不在同一个实例上，涉及到多个key的操作会影响性能，在突然高并发的情况下，有可能导致严重错误。Redis集群存在的意义在于把篮子拆成好几个，当一部分篮子不可用的时候，其它篮子不受影响。集群等待那个坏了的篮子进行主从切换，在短时间的切换后，集群又能恢复正常。数据拆分到了多个篮子，因此整个集群的横向扩展能力增强了。

根据官方的解释，Redis Cluster使用将每个key通过CRC16校验后对16384取模来决定放置在哪个槽。好比把数据分成了16384个区，每个master-slave分配一定数量的区。当master挂了以后，启动主从切换来让这个区域的槽能够继续使用。由于使用了主从复制，所以Redis Cluster也不保证数据的强一致性。极端情况下，当某个master-slave中的master和slave全部挂掉后，对应的槽也会出现不可用。Redis Cluster被设计为去中心化，每个Cluster节点之间没有严格的主从关系。每个Cluster节点都保存了其他节点的连接信息。客户端连接任何一个节点都能获取其他节点的信息。需要注意的是，创建和运行集群时，必须保证有三个及以上的Cluster节点存在，如果运行时节点数量少于节点总数的一半的时候，整个集群便无法提供服务。

60-Redis Cluster集群由于推出的时间不久，客户端并不多。但是在java平台上的Jedis和Redission都提供了对Redis Cluster集群的支持。

###### 创建集群

1. 修改Redis实例配置

   ```bash
   # 开启集群
   cluster-enabled  yes
   # 指定生成的集群配置文件名
   cluster-config-file  nodes_6900.conf
   # 集群连接超时ms
   cluster-node-timeout  10000
   ```

2. 使用官方提供的ruby脚本创建集群

   ```bash
   redis-trib.rb  create  --replicas  1  127.0.0.1:6900 127.0.0.1:6910 127.0.0.1:6920	
   ```
   使用时只需连接其中一个master即连接到整个集群。

#### Redis分布式锁 ####

##### RedLock #####

Redis本身不针对特定平台，所以基于Redis设计的分布式锁理论上可以用于所有实现了Redis客户端编程语言。官方权威的Redis分布式锁算法被称为*RedLock*。

分布式锁首先需要满足锁的安全性，其次必须保证锁的获取效率，并防止死锁。最后在分布式环境下能够保证一定的容灾能力。下面我们假设只有一个永不挂掉的Redis节点，只需要通过`SET lockKey lockValue NX PX 10000`就可以创建一个可靠的锁。NX表示只有lockKey这个key不存在的时候才设置key的值。PX 100000则表示10000毫秒后lockKey过期，保证了超时情况下不会死锁。注意，这里的lockKey必须是一个唯一值。为免与其他锁产生干扰可以使用伪随机数加应用编号的字符串尽来可能地保证这一点。锁使用完毕后，应该用DEL主动删除锁。但如果超时了，锁已经被删除，或者被替换则会出现误删除锁的问题。为了避免这个问题，可以在删除锁前检查锁的value是否与当初设置的一致，只有一致的情况下才可以删除这个锁。

```lua
if redis.call("get",KEYS[1]) == ARGV[1] then return redis.call("del",KEYS[1]) else return 0 end
```

```lua
127.0.0.1:6379> SET lock 111 NX PX 10000
OK
127.0.0.1:6379> EVAL "if redis.call(\"get\",KEYS[1]) == ARGV[1] then return redis.call(\"del\",KEYS[1]) else return 0 end" 1 lock 222
(integer) 0
127.0.0.1:6379> EVAL "if redis.call(\"get\",KEYS[1]) == ARGV[1] then return redis.call(\"del\",KEYS[1]) else return 0 end" 1 lock 111
(integer) 1
```

单机环境下，用Redis实现分布式锁很方便也很好理解。如果是在分布时环境下呢？假设有Master和Slave各一台。

1. 客户端A在Master获取了锁，客户端A开始使用唯一业务资源。
2. Master挂掉，Master到Slave的异步复制未完成。
3. Slave变成Master，客户端B获得与客户端A相同的锁。
4. 客户端A和客户端B共同持有业务资源，锁失效。

Redlock算法为了应对分布式环境下，部分Redis实例失效的问题。要求客户端在释放时间截至前获取超过一半实例的锁。如果超时，或者获取一半以上实例的锁失败，则删除曾经尝试获得的锁。为了减少延时，应该使用socket的非阻塞模式同时向多个实例发起锁请求，而不是一个一个获取。获取锁的过程也应该设置超时，防止某个节点挂掉后长时间阻塞上锁过程。假如客户端获取锁失败，设置一定次数的重试。需要注意的是，如果多个程序间隔相同时间进行重试，容易产生严重的锁获取冲突。如果将重试的间隔时间设为随机，则重视的机会更小。释放锁过程相对与获得锁很直接，直接删除所有节点，包括尝试过但未能获得锁的节点上的锁。上述是一个较为完美的锁使用过程，然而在生产环境，难免会出现服务器非正常关机的情况。虽然Redis可以启用AOF持久化功能，每秒钟都把操作增量写到磁盘，但实际上只是操作系统把数据写到了缓冲。如果把缓冲区数据同步到磁盘的函数fsync每秒钟执行一次，那么还是有机会出现实例重启后丢失锁的可能。我们也可以把fsync设为立即模式，但是这样设置的结果就是降低了实例的生产效率，所以官方的默认设置为`appendfsync everysec`。前面规定Redlock锁都有释放时间，即在TTL（time to live）时间以外，锁会自动失败。通过设定Redis重启之后的服务延迟为锁的最长存活时间来让可能存在的锁因超时而失效，这样的延时重启策略在不依赖Redis的某种持久化特性的情况下保证了分布式锁的安全性。与此同时带来的问题是实例重启后不能立刻投入使用。极端状态下，所有实例一起宕机，重启后会有一段时间的服务真空期。
| 参数                   | 注释                   | 利弊          |
| -------------------- | -------------------- | ----------- |
| appendfsync no       | 让操作系统决定将缓冲真正写入到磁盘的时间 | 数据安全性得不到保障  |
| appendfsync everysec | 每秒钟请求操作系统将缓冲写入一次磁盘   | 数据安全性与效率的平衡 |
| appendfsync always   | 总是请求操作系统将缓冲写入磁盘      | 安全性高，效率差    |

##### Redission上的RedLock #####

使用Redis作为分布式锁的实现的效率较高。在单实例环境下可以非常简单地实现锁。在Java平台上也有较为成熟的分布式锁开源实现`Redission`。Redission本身支持单例模式、主从模式，哨兵模式、集群模式模式的Redis实例。如集群模式：

```java
// 创建Redis客户端
Config config = new Config();
config.useClusterServers()
    .setScanInterval(2000) // cluster state scan interval in milliseconds
    .addNodeAddress("127.0.0.1:6379", "127.0.0.1:6380")
    .addNodeAddress("127.0.0.1:6381");
RedissonClient redisson = Redisson.create(config);
// 获得锁
RLock lock = client.getLock("testLock");
lock.tryLock(5,10, TimeUnit.SECONDS);

// 组合锁
RLock lock1 = client1.getLock("lock1");
RLock lock2 = client2.getLock("lock2");
RLock lock3 = client3.getLock("lock3");
RedissonMultiLock lockMulti = new RedissonMultiLock(lock1, lock2, lock3);

// 正常获取锁
lock.unlock();
// 强制解锁
lock.forceUnlock();
```


```java
// lock.forceUnlock()的具体实现   
@Override
    public RFuture<Boolean> forceUnlockAsync() {
        cancelExpirationRenewal();
        return commandExecutor.evalWriteAsync(getName(), LongCodec.INSTANCE, RedisCommands.EVAL_BOOLEAN,
                // 暴力删除，并通知其他客户端
                "if (redis.call('del', KEYS[1]) == 1) then "
                + "redis.call('publish', KEYS[2], ARGV[1]); "
                + "return 1 "
                + "else "
                + "return 0 "
                + "end",
                Arrays.<Object>asList(getName(), getChannelName()), LockPubSub.unlockMessage);
    }
// lock.unlock()的具体实现
// KEY[1]为锁名称，KEY[2]为关注的队列名称，ARGV[1]为解锁消息，ARGV[2]为超时时间，ARGV[3]为线程
    protected RFuture<Boolean> unlockInnerAsync(long threadId) {
        return commandExecutor.evalWriteAsync(getName(), LongCodec.INSTANCE, RedisCommands.EVAL_BOOLEAN,
                "if (redis.call('exists', KEYS[1]) == 0) then " +
                    "redis.call('publish', KEYS[2], ARGV[1]); " +
                    "return 1; " +
                "end;" + // 检查key是否还存在，如果不存在通知其他客户端
                "if (redis.call('hexists', KEYS[1], ARGV[3]) == 0) then " +
                    "return nil;" +
                "end; " + // 检查锁对应的线程是不是自己
                // 自己不想再占有锁，锁的持有计数减1
                "local counter = redis.call('hincrby', KEYS[1], ARGV[3], -1); " + 
                "if (counter > 0) then " +
                    // 如果自己不是最后一个持有者，让锁在指定时间内过期
                    "redis.call('pexpire', KEYS[1], ARGV[2]); " +
                    "return 0; " +
                "else " +
                    // 自己是最后一个持有者，删除锁，并通知其他客户端
                    "redis.call('del', KEYS[1]); " +
                    "redis.call('publish', KEYS[2], ARGV[1]); " +
                    "return 1; "+
                "end; " +
                "return nil;",
                Arrays.<Object>asList(getName(), getChannelName()), LockPubSub.unlockMessage, internalLockLeaseTime, getLockName(threadId));

    }

```

其实除了实现Redlock，MultiLock，Redission还实现了Java并发包中常见的锁

- 可重入锁（Reentrant Lock）

- 公平锁 （Fair Lock）

- 读写锁（ReadWriteLock）

- 信号量（Semaphore）

- 闭锁（CountDownLatch）

从源代码上可见，Redission对分布式锁的实现较为完善。只是因为使用了lua脚本来操作Redis，所以需要Redis版本在2.6.0以上。

##### Jedis与Redission的比较 #####

Jedis也是Redis在Java平台上一个客户端。Jedis使用穿传统的阻塞IO，依赖commons-pool2，除此之外几乎没有任何依赖。因为线程不安全，需要配合线程池使用。有一套完整的api对应Redis的各种原生功能。Redission基于Netty异步IO和事件编程，依赖较多，如：jackson、netty、projectreactor、javax.cache。Redission除了实现spring和java的缓存规范外，还屏蔽了Redis的底层操作，使用者直接操作分布式对象和集合。根据Redis中国用户组主席张冬洪翻译Nikita Koksharov的[文章](https://dzone.com/articles/redisson-pro-vs-jedis-which-is-faster)，随着处理线程的增加（>8），Redission相较于Jedis，虽然处理速度慢2~3倍，但是吞吐量是Jedis的4倍左右。需要注意的是测试的Redission Pro版本是Redission的收费版本，多了Redis集群部署管理和针对大容量Map和Set的自动分片。由于Jedis出现得较早，目前使用的项目更多。个人认为，Jedis与Redission之间的关系就好比MyBatis与Hibernate。Redission自从2014年以来发展强劲，功能日趋完善。Redission的宗旨是让使用者能够将精力更多地放在处理业务逻辑上。

#### 在Spring中作为分布式Session服务器使用 ####

#####  传统会话####

用户访问web应用程序时，容器会为浏览器分配一个成为会话ID的随机字符串。第一次创建会话时，创建的会话ID将会作为响应的一部分返回到用户浏览器中。接下来从该用户浏览器中发出的请求都将通过某种方式包含该会话ID。当应用程序收到含有会话ID的请求时，它可以通过该ID将现有会话与当前请求关联起来。传输会话ID可以使用cookie技术存放在请求头中，通过设置超时时间来保证会话安全。如果浏览器不支持cookie或者主动关闭了cookie，web服务器也可以使用URL重写在返回给浏览器的html中的每个链接中使用参数分割符`;`加上会话ID作为URL的一部分。甚至是把会话绑定在SSL请求中，不过这样也要求用户使用HTTPS连接服务器。

```
http://www.foo.com/bar;JSESSONID=EWNVFDxewfrWER234B?foo=bar&pick=up
```

在支持Java EE6的容器中，可以配置所需要的模式：

```xml
<session-config>
  <tracking-mode>COOKIE</tracking-mode>
  <tracking-mode>URL</tracking-mode>
  <tracking-mode>SSL</tracking-mode>
</session-config>
```

会话会话以对象的方式存在与内存中。如果web应用部署在多个实例上，因为负载均衡用户两次访问到不同的服务器，服务器无法识别请求的会话ID。解决的办法是使用会话粘滞。通过在前端负载均衡服务器上安装插件，让apache、nginx、IIS等服务器识别会话ID的后缀，会话只会被发给指定的web容器。为了保证集群的可用性，通常还会采用会话复制的方式来避免某台实例宕机带来的用户数据丢失。在tomcat中编辑server.xml使用Cluster标签配置tomcat简单集群后。在应用中的web.xml中加上`<distributable />` 标签即可开启集群间的会话共享。需要注意的是设置session共享后，如果使用session时了放入没有序列化接口的对象，会抛出`IllegalArgurmentException`异常。

session粘滞和session共享通过解决了session在集群环境下使用的问题。但是会话粘滞本身削弱了负载均衡的能力，会话复制在集群数量上升时会带来可观的系统资源开销。

##### Redis实现会话的方案 #####

用Redis实现会话共享有很多优点，比如：读取速度快，集群支持，实时在线用户管理，会话持久化，应用节点增加无感知。用Redis实现会话，主要有两种方式。第一种是在web容器层实现，对web应用无感知，但是依赖于固定容器。第二种是在应用层实现，对web容器无依赖，但是应用层可能有兼容性问题。

[Redis Session Manager for Apache Tomcat](https://github.com/jcoleman/tomcat-redis-session-manager)是Tomcat的一个Session插件，在github有1275个star。我们可以用它实现来实现Redis分布式存储session。下载源码进行编译，将实现包和依赖包commons-pool2-2.3.jar、jedis-2.7.2.jar、tomcat8_redis_session-0.0.1-SNAPSHOT.jar拷贝到tomcat的lib下。在tomcat的context.xml中或者server.xml的context部分配置插件和集群参数。

```xml
<Valve className="com.orangefunction.tomcat.redissessions.RedisSessionHandlerValve" />
<Manager className="com.orangefunction.tomcat.redissessions.RedisSessionManager"
         host="localhost" <!-- optional: defaults to "localhost" -->
         port="6379" <!-- optional: defaults to "6379" -->
         database="0" <!-- optional: defaults to "0" -->
         maxInactiveInterval="60" <!-- optional: defaults to "60" (in seconds) -->
         sessionPersistPolicies="PERSIST_POLICY_1,PERSIST_POLICY_2,.." <!-- optional
 		SAVE_ON_CHANGE:session 的 session.setAttribute() 或者 session.removeAttribute()方法被调用时，ALWAYS_SAVE_AFTER_REQUEST:每次请求结束后。-->
         sentinelMaster="SentinelMasterName" <!-- optional -->
         sentinels="sentinel-host-1:port,sentinel-host-2:port,.." <!-- optional --> />
```

重启tomcat后，会话就被存储在了Redis中。实际使用时，在tomcat8中需要修改部分源代码。

```java
/* 类路径：src/main/java/com/demo/redis_session/RedisSessionManager.java */
private void initializeSerializer() throws ClassNotFoundException, IllegalAccessException, InstantiationException {
...
		
		/*
		if (getContainer() != null) {
			loader = getContainer().getLoader();
		}
		*/
		
		// 修改为支持tomcat8
		Context context = this.getContext();
		if (context != null) {
			loader = context.getLoader();
		}
...
	}
```
Redission同样提供了对[Tomcat会话管理器（Tomcat Session Manager）](https://github.com/redisson/redisson/wiki/14.-%E7%AC%AC%E4%B8%89%E6%96%B9%E6%A1%86%E6%9E%B6%E6%95%B4%E5%90%88#145-tomcat%E4%BC%9A%E8%AF%9D%E7%AE%A1%E7%90%86%E5%99%A8tomcat-session-manager)的支持。添加RedissonSessionManager和相关jar包到Tomcat的lib目录下即可。

如果你已经在使用Spring，可以整合[Spring Session](http://projects.spring.io/spring-session/)。Spring Session支持使用Redis、GemFire、JDBC、MongoDB、Hazelcast来存储session。

- Spring Session自己实现了HttpSession，从Redis客户端中存取session对象。
- Redis客户端支持集群，Spring Session也支持集群。
- 支持在同一个浏览器器里管理多个session。
- 提供RESTful API。
- 使用WebSocket接受消息时可以保持Session存活。

添加依赖

```xml
<dependencies>
        <!-- ... -->

        <dependency><!-- spring需要的组件 -->
                <groupId>org.springframework.session</groupId>
                <artifactId>spring-session-data-redis</artifactId>
                <version>1.3.1.RELEASE</version>
                <type>pom</type>
        </dependency>
        <dependency><!-- 一个Redis客户端 -->
                <groupId>biz.paluch.redis</groupId>
                <artifactId>lettuce</artifactId>
                <version>3.5.0.Final</version>
        </dependency>
        <dependency>
                <groupId>org.springframework</groupId>
                <artifactId>spring-web</artifactId>
                <version>4.3.4.RELEASE</version>
        </dependency>
</dependencies>
```

Spring Session的实现与Spring Security相似，需要在web.xml中添加过滤器：

```xml
	<!--
	- Location of the XML file that defines the root application context
	- Applied by ContextLoaderListener.
	-->
	<!-- tag::context-param[] -->
	<context-param>
		<param-name>contextConfigLocation</param-name>
		<param-value>
			/WEB-INF/spring/*.xml
		</param-value>
	</context-param>
	<!-- end::context-param[] -->

	<!-- tag::springSessionRepositoryFilter[] -->
	<filter>
		<filter-name>springSessionRepositoryFilter</filter-name>
		<filter-class>org.springframework.web.filter.DelegatingFilterProxy</filter-class>
	</filter>
	<filter-mapping>
		<filter-name>springSessionRepositoryFilter</filter-name>
		<url-pattern>/*</url-pattern>
		<dispatcher>REQUEST</dispatcher>
		<dispatcher>ERROR</dispatcher>
	</filter-mapping>
	<!-- end::springSessionRepositoryFilter[] -->

	<!--
	- Loads the root application context of this web app at startup.
	- The application context is then available via
	- WebApplicationContextUtils.getWebApplicationContext(servletContext).
	-->
	<!-- tag::listeners[] -->
	<listener>
		<listener-class>
			org.springframework.web.context.ContextLoaderListener
		</listener-class>
	</listener>
	<!-- end::listeners[] -->
```

web.xml中载入的session.xml如下，装配了与redis交互的客户端：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:context="http://www.springframework.org/schema/context"
	xmlns:p="http://www.springframework.org/schema/p"
	xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd
		http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context.xsd">

	<!-- tag::beans[] -->

	<!--1-->
	<context:annotation-config/>
	<bean class="org.springframework.session.data.redis.config.annotation.web.http.RedisHttpSessionConfiguration"/>

	<!--2-->
  	<bean id="jedisConnectionFactory" class="org.springframework.data.redis.connection.jedis.JedisConnectionFactory" p:host-name="localhost" p:port="6379" />
</beans>
```

上述为简单的单机方案，如果是哨兵集群方案，需要使用`RedisSentinelConfiguration`来配置。

```java
/**
 * jedis
 */
@Bean
public RedisConnectionFactory jedisConnectionFactory() {
  RedisSentinelConfiguration sentinelConfig = new RedisSentinelConfiguration() .master("mymaster")
  .sentinel("127.0.0.1", 26379) .sentinel("127.0.0.1", 26380);
  return new JedisConnectionFactory(sentinelConfig);
}
```

Redission也提供了整合Spring Session的方法。需要先[整合Spring和Redission](https://github.com/redisson/redisson/wiki/14.-%E7%AC%AC%E4%B8%89%E6%96%B9%E6%A1%86%E6%9E%B6%E6%95%B4%E5%90%88#141-spring%E6%A1%86%E6%9E%B6%E6%95%B4%E5%90%88)，再使用`@EnableRedissionHttpSession`声明使用Redission来实现HttpSession。

```java
@EnableRedissonHttpSession 
public class Config {

   @Bean
   public RedissonClient redisson() {
       return Redisson.create();
   }
}
```

然后提供一个启动器`AbstractHttpSessionApplicationInitializer`的扩展

```java
public class Initializer extends AbstractHttpSessionApplicationInitializer { 

     public Initializer() {
             super(Config.class); 
     }
}
```

Spring Session由于重写了HttpSession，可能出现一些不可预料的结果。

1. 不规范请求头可能导致请求输入流丢失。
2. jsp下从session中取出的对象修改完成后必须使用setAttribute方法提醒Spring Session向Redis提交更改。
3. Spring Session会主动开启Redis的键空间事件通知。`redis-cli config set notify-keyspace-events Egx`

如果你不使用spring框架，可以自己编写获取session的工具类，尽管这样对原来的业务代码有侵入性。

#### Redis实现秒杀方案

要点：

- 不使用悲观锁
- 使用原子地进行增减
- 记录成功秒杀的用户信息
- 异步处理订单事务
- 结合流量防火墙限制请求

核心Redis操作指令如下

```Bash
# Server
# 初始化商品的数量
set goods 100

# Client
# 观察goods数量的变化
watch goods
# 开始事务
multi
# 减少商品数量
incrby goods -1
# 执行事务
exec
# 1 事务成功,记录秒杀成功信息
setnx 'seckill:userid' 'userSecKillSucc'
```

1. 服务器初始商品的数量
2. 客户端连接服务器使用watch来检测键的变化
3. 开启事务后减少商品数量
4. 如果goods在事务过程中被改变了，那么事务失败。
5. 如果goods在事务过程中没有被改变，事务成功。
6. 事务成功后记录客户秒杀信息。
7. 秒杀活动结束后，订单系统处理客户秒杀信息，将订单存入数据库。


#### Redis实时去重

统计网站访问量UV、PV时需要除重来获得净访问量。爬虫遍历URL时常常需要对数据进行除重来判断当前数据是否已经处理过，防止重复处理浪费资源。使用数据库的时候，我们可以使用distinct来去重，但是这个操作比较耗费时间，在时效性比较高的在线处理场合，传统数据库又出现了力不从心的情况。这里让redis实现实时去重的核心是Bloom Filter（布隆过滤器）配合Redis的BitMap。

##### 布隆过滤器

布隆过滤器要解决的问题是判断一个元素是否在集合中。

| 优点                 | 缺点       |
| ------------------ | -------- |
| 只存储hash后的比特位，占用空间小 | 存在误判     |
| hash算法效率高          | 只支持查询和插入 |
| 误判率固定为万分之五         |          |
| 只会误判，不会漏判          |          |

> 根据《数学之美》中给出的数据，在使用8个哈希函数的情况下，512MB大小的位数组在误报率万分之五的情况下可以对约两亿的url去重。而若单纯的使用set()去重的话，以一个url64个字节记，两亿url约需要128GB的内存空间。
>

布隆过滤器是一种高效率的标记结构。它使用hash计算将key名称散列到一些bit位上，下次检测key是否存在时只需将key从新散列，并检查散列后对应的bit位。如果每个bit位都是1则key存在，否则判定为不存在。大家都知道hash散列可能出现冲撞的情况，存储hash的空间越大，冲撞的几率越小。在Redis我们可以使用最大为512MB的BitMaps类型来存储Hash后的位状态，可供存储的状态位数量为 2^32个，出现误判的几率可以保持在5%以下。当可以承受一定的误判时，布隆过滤器相对其他数据结构有着非常大的空间优势。如果数据量太大，还可以将key进行hash后再取模分片到不同的key中。

```bash
# 将key中偏移位10的状态位设为1
> setbit key 10 1
(integer) 0
# 再次设置key中偏移位的状态位，设置状态位1，并返回前一个状态。
> setbit key 10 1
(integer) 1
# 获取key偏移位10的状态位为1
> getbit key 10
(integer) 1
# 获取key偏移位11的状态位，因为之前没有设置，所以获得为0
> getbit key 11
(integer) 0
# 在key中放置url经过特定hash函数计算后的整数同样成立，可以判断之前有没有将url存入其中。
```


