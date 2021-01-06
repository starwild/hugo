---
title: "Python 2 实例手册"
date: 2018-03-16T15:33:36+08:00
draft: false
---

# Python实例手册

## 说明

	手册制作: 雪松 littlepy reboot
	更新日期: 2014-10-29
	欢迎系统运维加入Q群: 198173206  # 加群请回答问题
	欢迎运维开发加入Q群: 365534424  # 不定期技术分享

	请使用"notepad++"打开此文档,"alt+0"将函数折叠后方便查阅
	请勿删除信息，转载请说明出处，抵制不道德行为。
	错误在所难免，还望指正！

	# python实例手册下载地址:
	http://hi.baidu.com/quanzhou722/item/cf4471f8e23d3149932af2a7
	
	# shell实例手册最新下载地址:
	http://hi.baidu.com/quanzhou722/item/f4a4f3c9eb37f02d46d5c0d9

	# LazyManage运维批量管理软件下载[shell]:
	http://hi.baidu.com/quanzhou722/item/4ccf7e88a877eaccef083d1a
	
	# LazyManage运维批量管理软件下载[python]:
	http://hi.baidu.com/quanzhou722/item/4213db3626a949fe96f88d3c

## 1 基础

### 查看帮助
		import os
		for i in dir(os):
			print i         # 模块的方法
		help(os.path)       # 方法的帮助

### 调试
		python -m trace -t aaaaaa.py
	
### pip模块安装
		
		yum install python-pip            # centos安装pip
		sudo apt-get install python-pip   # ubuntu安装pip
		pip官方安装脚本
			wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py
			python get-pip.py
		加载环境变量
			vim /etc/profile
			export PATH=/usr/local/python27/bin:$PATH
			. /etc/profile

		pip install Package             # 安装包 pip install requests
		pip show --files Package        # 查看安装包时安装了哪些文件
		pip show --files Package        # 查看哪些包有更新
		pip install --upgrade Package   # 更新一个软件包
		pip uninstall Package           # 卸载软件包

### 变量

		r=r'\n'          # 输出时原型打印
		u=u'中文'        # 定义为unicode编码
		global x         # 全局变量
		a = 0 or 2 or 1  # 布尔运算赋值,a值为True既不处理后面,a值为2.  None、字符串''、空元组()、空列表[],空字典{}、0、空字符串都是false
		name = raw_input("input:").strip()        # 输入字符串变量
		num = int(raw_input("input:").strip())    # 输入字符串str转为int型
		locals()                                  # 所有局部变量组成的字典
		locals().values()                         # 所有局部变量值的列表
		os.popen("date -d @{0} +'%Y-%m-%d %H:%M:%S'".format(12)).read()    # 特殊情况引用变量 {0} 代表第一个参数

### 打印

		# 字符串 %s  整数 %d  浮点 %f  原样打印 %r
		print '字符串: %s 整数: %d 浮点: %f 原样打印: %r' % ('aa',2,1.0,'r')
		print 'abc',      # 有逗号,代表不换行打印,在次打印会接着本行打印

### 列表

		# 列表元素的个数最多 536870912
		shoplist = ['apple', 'mango', 'carrot', 'banana']
		shoplist[2] = 'aa'
		del shoplist[0]
		shoplist.insert('4','www')
		shoplist.append('aaa')
		shoplist[::-1]    # 倒着打印 对字符翻转串有效
		shoplist[2::3]    # 从第二个开始每隔三个打印
		shoplist[:-1]     # 排除最后一个
		'\t'.join(li)     # 将列表转换成字符串
		sys.path[1:1]=[5] # 在位置1前面插入列表中一个值
		list(set(['qwe', 'as', '123', '123']))   # 将列表通过集合去重复
		eval("['1','a']")                        # 将字符串当表达式求值,得到列表

### 元组

		# 不可变
		zoo = ('wolf', 'elephant', 'penguin')

### 字典

		ab = {       'Swaroop'   : 'swaroopch@byteofpython.info',
					 'Larry'     : 'larry@wall.org',
			 }
		ab['c'] = 80      # 添加字典元素
		del ab['Larry']   # 删除字典元素
		ab.keys()         # 查看所有键值
		ab.values()       # 打印所有值
		ab.has_key('a')   # 查看键值是否存在
		ab.items()        # 返回整个字典列表
		
		复制字典
			a = {1: {1: 2, 3: 4}}
			b = a             
			b[1][1] = 8888                # a和b都为 {1: {1: 8888, 3: 4}}
			import copy
			c = copy.deepcopy(a)          # 再次赋值 b[1][1] = 9999 拷贝字典为新的字典,互不干扰
			
			a[2] = copy.deepcopy(a[1])    # 复制出第二个key，互不影响  {1: {1: 2, 3: 4},2: {1: 2, 3: 4}}

### 流程结构

		if判断

			# 布尔值操作符 and or not 实现多重判断
			if a == b:
				print '=='
			elif a < b:
				print b
			else:
				print a
			fi

		while循环

			while True:
				if a == b:
					print "=="
					break
				print "!="
			else:
				print 'over'
			
			count=0
			while(count<9):
				print count
				count += 1

		for循环

			sorted()           # 返回一个序列(列表)
			zip()              # 返回一个序列(列表)
			enumerate()        # 返回循环列表序列 for i,v in enumerate(['a','b']):
			reversed()         # 反序迭代器对象
			dict.iterkeys()    # 通过键迭代
			dict.itervalues()  # 通过值迭代
			dict.iteritems()   # 通过键-值对迭代
			randline()         # 文件迭代
			iter(obj)          # 得到obj迭代器 检查obj是不是一个序列
			iter(a,b)          # 重复调用a,直到迭代器的下一个值等于b
			for i in range(1, 5):
				print i
			else:
				print 'over'

			list = ['a','b','c','b']
			for i in range(len(list)):
				print list[i]
			for x, Lee in enumerate(list):
				print "%d %s Lee" % (x+1,Lee)
			
			# enumerate 使用函数得到索引值和对应值
			for i, v in enumerate(['tic', 'tac', 'toe']):
				print(i, v)

		流程结构简写

			[ i * 2 for i in [8,-2,5]]
			[16,-4,10]
			[ i for i in range(8) if i %2 == 0 ]
			[0,2,4,6]

### tab补全

		# vim /usr/lib/python2.7/dist-packages/tab.py
		# python startup file
		import sys
		import readline
		import rlcompleter
		import atexit
		import os
		# tab completion
		readline.parse_and_bind('tab: complete')
		# history file
		histfile = os.path.join(os.environ['HOME'], '.pythonhistory')

### 函数

		def printMax(a, b = 1):
			if a > b:
				print a
				return a
			else:
				print b
				return b
		x = 5
		y = 7
		printMax(x, y)

		def update(*args,**kwargs):
			p=''
			for i,t in kwargs.items():
					p = p+ '%s=%s,' %(i,str(t))
			sql = "update  'user' set (%s) where (%s)" %(args[0],p)
			print sql

		update('aaa',uu='uu',id=3)

### 模块

		# Filename: mymodule.py
		def sayhi():
			print 'mymodule'
		version = '0.1'
		
		# 使用模块中方法
		import mymodule
		from mymodule import sayhi, version
		mymodule.sayhi()   # 使用模块中函数方法

### 类对象的方法

		class Person:
			# 实例化初始化的方法
			def __init__(self, name ,age):
				self.name = name
				self.age = age
				print self.name
			# 有self此函数为方法
			def sayHi(self):
				print 'Hello, my name is', self.name
			# 对象消逝的时候被调用
			def __del__(self):
				print 'over'
		# 实例化对象
		p = Person('Swaroop')
		# 使用对象方法
		p.sayHi()
		# 继承
		class Teacher(Person):
			def __init__(self, name, age, salary):
				Person.__init__(self, name, age)
				self.salary = salary
				print '(Initialized Teacher: %s)' % self.name
			def tell(self):
				Person.tell(self)
				print 'Salary: "%d"' % self.salary
		t = Teacher('Mrs. Shrividya', 40, 30000)

### 执行模块类中的所有方法

		# moniItems.py
		import sys, time
		import inspect

		class mon:
			def __init__(self, n):
				self.name = n
				self.data = dict()
			def run(self):
				print 'hello', self.name
				return self.runAllGet()
			def getDisk(self):
				return 222
			def getCpu(self):
				return 111
			def runAllGet(self):
				for fun in inspect.getmembers(self, predicate=inspect.ismethod):
					print fun[0], fun[1]
					if fun[0][:3] == 'get':
						self.data[fun[0][3:]] = fun[1]()
				print self.data
				return self.data
		
		# 模块导入使用
		from moniItems import mon
		m = mon()
		m.runAllGet()

### 文件处理

		# 模式: 读'r'  写[清空整个文件]'w' 追加[文件需要存在]'a' 读写'r+' 二进制文件'b'  'rb','wb','rb+'

		写文件
			i={'ddd':'ccc'}
			f = file('poem.txt', 'a') 
			f.write("string")
			f.write(str(i))
			f.flush()
			f.close()

		读文件
			f = file('/etc/passwd','r')
			c = f.read().strip()        # 读取为一个大字符串，并去掉最后一个换行符
			for i in c.spilt('\n'):     # 用换行符切割字符串得到列表循环每行
				print i
			f.close()

		读文件1
			f = file('/etc/passwd','r')
			while True:
				line = f.readline()    # 返回一行
				if len(line) == 0:
					break
				x = line.split(":")                  # 冒号分割定义序列
				#x = [ x for x in line.split(":") ]  # 冒号分割定义序列
				#x = [ x.split("/") for x in line.split(":") ]  # 先冒号分割,在/分割 打印x[6][1]
				print x[6],"\n",
			f.close() 
		
		读文件2
			f = file('/etc/passwd')
			c = f.readlines()       # 读入所有文件内容,可反复读取,大文件时占用内存较大
			for line in c:
				print line.rstrip(),
			f.close()

		读文件3
			for i in open('b.txt'):   # 直接读取也可迭代,并有利于大文件读取,但不可反复读取
				print i,
		
		追加日志
			log = open('/home/peterli/xuesong','a')
			print >> log,'faaa'
			log.close()
		
		with读文件
			with open('a.txt') as f:
				for i in f:
					print i
				print f.read()        # 打印所有内容为字符串
				print f.readlines()   # 打印所有内容按行分割的列表
		
		csv读配置文件  
			192.168.1.5,web # 配置文件按逗号分割
			list = csv.reader(file('a.txt'))
			for line in list:
				print line              #  ['192.168.1.5', 'web']

### 内建函数

		dir(sys)            # 显示对象的属性
		help(sys)           # 交互式帮助
		int(obj)            # 转型为整形
		str(obj)            # 转为字符串
		len(obj)            # 返回对象或序列长度
		open(file,mode)     # 打开文件 #mode (r 读,w 写, a追加)
		range(0,3)          # 返回一个整形列表
		raw_input("str:")   # 等待用户输入
		type(obj)           # 返回对象类型
		abs(-22)            # 绝对值
		random              # 随机数
		choice()            # 随机返回给定序列的一个元素
		divmod(x,y)         # 函数完成除法运算，返回商和余数。
		round(x[,n])        # 函数返回浮点数x的四舍五入值，如给出n值，则代表舍入到小数点后的位数
		strip()             # 是去掉字符串两端多于空格,该句是去除序列中的所有字串两端多余的空格
		del                 # 删除列表里面的数据
		cmp(x,y)            # 比较两个对象    #根据比较结果返回一个整数，如果x<y，则返回-1；如果x>y，则返回1,如果x==y则返回0
		max()               # 字符串中最大的字符
		min()               # 字符串中最小的字符
		sorted()            # 对序列排序
		reversed()          # 对序列倒序
		enumerate()         # 返回索引位置和对应的值
		sum()               # 总和
		list()              # 变成列表可用于迭代
		eval('3+4')         # 将字符串当表达式求值 得到7
		exec 'a=100'        # 将字符串按python语句执行
		exec(a+'=new')      # 将变量a的值作为新的变量
		tuple()             # 变成元组可用于迭代   #一旦初始化便不能更改的数据结构,速度比list快
		zip(s,t)            # 返回一个合并后的列表  s = ['11','22']  t = ['aa','bb']  [('11', 'aa'), ('22', 'bb')]
		isinstance(object,int)    # 测试对象类型 int 
		xrange([lower,]stop[,step])            # 函数与range()类似，但xrnage()并不创建列表，而是返回一个xrange对象

### 字符串相关模块

		string         # 字符串操作相关函数和工具
		re             # 正则表达式
		struct         # 字符串和二进制之间的转换
		c/StringIO     # 字符串缓冲对象,操作方法类似于file对象
		base64         # Base16\32\64数据编解码
		codecs         # 解码器注册和基类
		crypt          # 进行单方面加密
		difflib        # 找出序列间的不同
		hashlib        # 多种不同安全哈希算法和信息摘要算法的API
		hma            # HMAC信息鉴权算法的python实现
		md5            # RSA的MD5信息摘要鉴权
		rotor          # 提供多平台的加解密服务
		sha            # NIAT的安全哈希算法SHA
		stringprep     # 提供用于IP协议的Unicode字符串
		textwrap       # 文本包装和填充
		unicodedate    # unicode数据库

### 列表类型内建函数

		list.append(obj)                 # 向列表中添加一个对象obj
		list.count(obj)                  # 返回一个对象obj在列表中出现的次数
		list.extend(seq)                 # 把序列seq的内容添加到列表中
		list.index(obj,i=0,j=len(list))  # 返回list[k] == obj 的k值,并且k的范围在i<=k<j;否则异常
		list.insert(index.obj)           # 在索引量为index的位置插入对象obj
		list.pop(index=-1)               # 删除并返回指定位置的对象,默认是最后一个对象
		list.remove(obj)                 # 从列表中删除对象obj
		list.reverse()                   # 原地翻转列表
		list.sort(func=None,key=None,reverse=False)  # 以指定的方式排序列表中成员,如果func和key参数指定,则按照指定的方式比较各个元素,如果reverse标志被置为True,则列表以反序排列

### 序列类型操作符

		seq[ind]              # 获取下标为ind的元素
		seq[ind1:ind2]        # 获得下标从ind1到ind2的元素集合
		seq * expr            # 序列重复expr次
		seq1 + seq2           # 连接seq1和seq2
		obj in seq            # 判断obj元素是否包含在seq中
		obj not in seq        # 判断obj元素是否不包含在seq中

### 字符串类型内建方法

		string.expandtabs(tabsize=8)                  # tab符号转为空格 #默认8个空格
		string.endswith(obj,beg=0,end=len(staring))   # 检测字符串是否已obj结束,如果是返回True #如果beg或end指定检测范围是否已obj结束
		string.count(str,beg=0,end=len(string))       # 检测str在string里出现次数  f.count('\n',0,len(f)) 判断文件行数
		string.find(str,beg=0,end=len(string))        # 检测str是否包含在string中
		string.index(str,beg=0,end=len(string))       # 检测str不在string中,会报异常
		string.isalnum()                              # 如果string至少有一个字符并且所有字符都是字母或数字则返回True
		string.isalpha()                              # 如果string至少有一个字符并且所有字符都是字母则返回True
		string.isnumeric()                            # 如果string只包含数字字符,则返回True
		string.isspace()                              # 如果string包含空格则返回True
		string.isupper()                              # 字符串都是大写返回True
		string.islower()                              # 字符串都是小写返回True
		string.lower()                                # 转换字符串中所有大写为小写
		string.upper()                                # 转换字符串中所有小写为大写
		string.lstrip()                               # 去掉string左边的空格
		string.rstrip()                               # 去掉string字符末尾的空格
		string.replace(str1,str2,num=string.count(str1))  # 把string中的str1替换成str2,如果num指定,则替换不超过num次
		string.startswith(obj,beg=0,end=len(string))  # 检测字符串是否以obj开头
		string.zfill(width)                           # 返回字符长度为width的字符,原字符串右对齐,前面填充0
		string.isdigit()                              # 只包含数字返回True
		string.split("分隔符")                        # 把string切片成一个列表
		":".join(string.split())                      # 以:作为分隔符,将所有元素合并为一个新的字符串

### 序列类型相关的模块

		array         # 一种受限制的可变序列类型,元素必须相同类型
		copy          # 提供浅拷贝和深拷贝的能力
		operator      # 包含函数调用形式的序列操作符 operator.concat(m,n)
		re            # perl风格的正则表达式查找
		StringIO      # 把长字符串作为文件来操作 如: read() \ seek()
		cStringIO     # 把长字符串作为文件来操,作速度更快,但不能被继承
		textwrap      # 用作包装/填充文本的函数,也有一个类
		types         # 包含python支持的所有类型
		collections   # 高性能容器数据类型

### 字典内建方法

		dict.clear()                            # 删除字典中所有元素
		dict copy()                             # 返回字典(浅复制)的一个副本
		dict.fromkeys(seq,val=None)             # 创建并返回一个新字典,以seq中的元素做该字典的键,val做该字典中所有键对的初始值
		dict.get(key,default=None)              # 对字典dict中的键key,返回它对应的值value,如果字典中不存在此键,则返回default值
		dict.has_key(key)                       # 如果键在字典中存在,则返回True 用in和not in代替
		dicr.items()                            # 返回一个包含字典中键、值对元组的列表
		dict.keys()                             # 返回一个包含字典中键的列表
		dict.iter()                             # 方法iteritems()、iterkeys()、itervalues()与它们对应的非迭代方法一样,不同的是它们返回一个迭代子,而不是一个列表
		dict.pop(key[,default])                 # 和方法get()相似.如果字典中key键存在,删除并返回dict[key]
		dict.setdefault(key,default=None)       # 和set()相似,但如果字典中不存在key键,由dict[key]=default为它赋值
		dict.update(dict2)                      # 将字典dict2的键值对添加到字典dict
		dict.values()                           # 返回一个包含字典中所有值得列表

		dict([container])     # 创建字典的工厂函数。提供容器类(container),就用其中的条目填充字典
		len(mapping)          # 返回映射的长度(键-值对的个数)
		hash(obj)             # 返回obj哈希值,判断某个对象是否可做一个字典的键值		
		
### 集合方法

		s.update(t)                         # 用t中的元素修改s,s现在包含s或t的成员   s |= t
		s.intersection_update(t)            # s中的成员是共用属于s和t的元素          s &= t
		s.difference_update(t)              # s中的成员是属于s但不包含在t中的元素    s -= t
		s.symmetric_difference_update(t)    # s中的成员更新为那些包含在s或t中,但不是s和t共有的元素  s ^= t
		s.add(obj)                          # 在集合s中添加对象obj
		s.remove(obj)                       # 从集合s中删除对象obj;如果obj不是集合s中的元素(obj not in s),将引发KeyError错误
		s.discard(obj)                      # 如果obj是集合s中的元素,从集合s中删除对象obj
		s.pop()                             # 删除集合s中的任意一个对象,并返回它
		s.clear()                           # 删除集合s中的所有元素
		s.issubset(t)                       # 如果s是t的子集,则返回True   s <= t
		s.issuperset(t)                     # 如果t是s的超集,则返回True   s >= t
		s.union(t)                          # 合并操作;返回一个新集合,该集合是s和t的并集   s | t
		s.intersection(t)                   # 交集操作;返回一个新集合,该集合是s和t的交集   s & t
		s.difference(t)                     # 返回一个新集合,改集合是s的成员,但不是t的成员  s - t
		s.symmetric_difference(t)           # 返回一个新集合,该集合是s或t的成员,但不是s和t共有的成员   s ^ t
		s.copy()                            # 返回一个新集合,它是集合s的浅复制
		obj in s                            # 成员测试;obj是s中的元素 返回True
		obj not in s                        # 非成员测试:obj不是s中元素 返回True
		s == t                              # 等价测试 是否具有相同元素
		s != t                              # 不等价测试 
		s < t                               # 子集测试;s!=t且s中所有元素都是t的成员
		s > t                               # 超集测试;s!=t且t中所有元素都是s的成员

### 序列化

		#!/usr/bin/python
		import cPickle
		obj = {'1':['4124','1241','124'],'2':['12412','142','1241']}

		pkl_file = open('account.pkl','wb')
		cPickle.down(obj,pkl_file)
		pkl_file.close()

		pkl_file = open('account.pkl','rb')
		account_list = cPickle.load(pkl_file)
		pkl_file.close()

### 文件对象方法
		
		file.close()                     # 关闭文件
		file.fileno()                    # 返回文件的描述符
		file.flush()                     # 刷新文件的内部缓冲区
		file.isatty()                    # 判断file是否是一个类tty设备
		file.next()                      # 返回文件的下一行,或在没有其他行时引发StopIteration异常
		file.read(size=-1)               # 从文件读取size个字节,当未给定size或给定负值的时候,读取剩余的所有字节,然后作为字符串返回
		file.readline(size=-1)           # 从文件中读取并返回一行(包括行结束符),或返回最大size个字符
		file.readlines(sizhint=0)        # 读取文件的所有行作为一个列表返回
		file.xreadlines()                # 用于迭代,可替换readlines()的一个更高效的方法
		file.seek(off, whence=0)         # 在文件中移动文件指针,从whence(0代表文件起始,1代表当前位置,2代表文件末尾)偏移off字节
		file.tell()                      # 返回当前在文件中的位置
		file.truncate(size=file.tell())  # 截取文件到最大size字节,默认为当前文件位置
		file.write(str)                  # 向文件写入字符串
		file.writelines(seq)             # 向文件写入字符串序列seq;seq应该是一个返回字符串的可迭代对象

### 文件对象的属性
		
		file.closed          # 表示文件已被关闭,否则为False
		file.encoding        # 文件所使用的编码  当unicode字符串被写入数据时,它将自动使用file.encoding转换为字节字符串;若file.encoding为None时使用系统默认编码
		file.mode            # Access文件打开时使用的访问模式
		file.name            # 文件名
		file.newlines        # 未读取到行分隔符时为None,只有一种行分隔符时为一个字符串,当文件有多种类型的行结束符时,则为一个包含所有当前所遇到的行结束符的列表
		file.softspace       # 为0表示在输出一数据后,要加上一个空格符,1表示不加

### 异常处理
	
		# try 中使用 sys.exit(2) 会被捕获,无法退出脚本,可使用 os._exit(2) 退出脚本
		
		class ShortInputException(Exception):  # 继承Exception异常的类,定义自己的异常
			def __init__(self, length, atleast):
				Exception.__init__(self)
				self.length = length
				self.atleast = atleast
		try:
			s = raw_input('Enter something --> ')
			if len(s) < 3:
				raise ShortInputException(len(s), 3)    # 触发异常
		except EOFError:
			print '\nWhy did you do an EOF on me?'
		except ShortInputException, x:      # 捕捉指定错误信息
			print 'ShortInputException:  %d | %d' % (x.length, x.atleast)
		except Exception as err:            # 捕捉所有其它错误信息内容
			print str(err)
		#except urllib2.HTTPError as err:   # 捕捉外部导入模块的错误
		#except:                            # 捕捉所有其它错误 不会看到错误内容
		#		print 'except'
		finally:                            # 无论什么情况都会执行 关闭文件或断开连接等
			   print 'finally' 
		else:                               # 无任何异常 无法和finally同用
			print 'No exception was raised.' 

		不可捕获的异常

			NameError:              # 尝试访问一个未申明的变量
			ZeroDivisionError:      # 除数为零
			SyntaxErrot:            # 解释器语法错误
			IndexError:             # 请求的索引元素超出序列范围
			KeyError:               # 请求一个不存在的字典关键字
			IOError:                # 输入/输出错误
			AttributeError:         # 尝试访问未知的对象属性
			ImportError             # 没有模块
			IndentationError        # 语法缩进错误
			KeyboardInterrupt       # ctrl+C
			SyntaxError             # 代码语法错误
			ValueError              # 值错误
			TypeError               # 传入对象类型与要求不符合

		内建异常
			
			BaseException                # 所有异常的基类
			SystemExit                   # python解释器请求退出
			KeyboardInterrupt            # 用户中断执行
			Exception                    # 常规错误的基类
			StopIteration                # 迭代器没有更多的值
			GeneratorExit                # 生成器发生异常来通知退出
			StandardError                # 所有的内建标准异常的基类
			ArithmeticError              # 所有数值计算错误的基类
			FloatingPointError           # 浮点计算错误
			OverflowError                # 数值运算超出最大限制
			AssertionError               # 断言语句失败
			AttributeError               # 对象没有这个属性
			EOFError                     # 没有内建输入,到达EOF标记
			EnvironmentError             # 操作系统错误的基类
			IOError                      # 输入/输出操作失败
			OSError                      # 操作系统错误
			WindowsError                 # windows系统调用失败
			ImportError                  # 导入模块/对象失败
			KeyboardInterrupt            # 用户中断执行(通常是ctrl+c)
			LookupError                  # 无效数据查询的基类
			IndexError                   # 序列中没有此索引(index)
			KeyError                     # 映射中没有这个键
			MemoryError                  # 内存溢出错误(对于python解释器不是致命的)
			NameError                    # 未声明/初始化对象(没有属性)
			UnboundLocalError            # 访问未初始化的本地变量
			ReferenceError               # 若引用试图访问已经垃圾回收了的对象
			RuntimeError                 # 一般的运行时错误
			NotImplementedError          # 尚未实现的方法
			SyntaxError                  # python语法错误
			IndentationError             # 缩进错误
			TabError                     # tab和空格混用
			SystemError                  # 一般的解释器系统错误
			TypeError                    # 对类型无效的操作
			ValueError                   # 传入无效的参数
			UnicodeError                 # Unicode相关的错误
			UnicodeDecodeError           # Unicode解码时的错误
			UnicodeEncodeError           # Unicode编码时的错误
			UnicodeTranslateError        # Unicode转换时错误
			Warning                      # 警告的基类
			DeprecationWarning           # 关于被弃用的特征的警告
			FutureWarning                # 关于构造将来语义会有改变的警告
			OverflowWarning              # 旧的关于自动提升为长整形的警告
			PendingDeprecationWarning    # 关于特性将会被废弃的警告
			RuntimeWarning               # 可疑的运行时行为的警告
			SyntaxWarning                # 可疑的语法的警告
			UserWarning                  # 用户代码生成的警告

		触发异常

			raise exclass            # 触发异常,从exclass生成一个实例(不含任何异常参数)
			raise exclass()          # 触发异常,但现在不是类;通过函数调用操作符(function calloperator:"()")作用于类名生成一个新的exclass实例,同样也没有异常参数
			raise exclass, args      # 触发异常,但同时提供的异常参数args,可以是一个参数也可以是元组
			raise exclass(args)      # 触发异常,同上
			raise exclass, args, tb  # 触发异常,但提供一个跟踪记录(traceback)对象tb供使用
			raise exclass,instance   # 通过实例触发异常(通常是exclass的实例)
			raise instance           # 通过实例触发异常;异常类型是实例的类型:等价于raise instance.__class__, instance
			raise string             # 触发字符串异常
			raise string, srgs       # 触发字符串异常,但触发伴随着args
			raise string,args,tb     # 触发字符串异常,但提供一个跟踪记录(traceback)对象tb供使用
			raise                    # 重新触发前一个异常,如果之前没有异常,触发TypeError

		跟踪异常栈

			# traceback 获取异常相关数据都是通过sys.exc_info()函数得到的
			import traceback
			import sys
			try:
				s = raw_input()
				print int(s)
			except ValueError:
				# sys.exc_info() 返回值是元组，第一个exc_type是异常的对象类型，exc_value是异常的值，exc_tb是一个traceback对象，对象中包含出错的行数、位置等数据
				exc_type, exc_value, exc_tb = sys.exc_info()
				print "\n%s \n %s \n %s\n" %(exc_type, exc_value, exc_tb )
				traceback.print_exc()        # 打印栈跟踪信息
				
		抓取全部错误信息存如字典

			import sys, traceback

			try:
				s = raw_input()
				int(s)
			except:
				exc_type, exc_value, exc_traceback = sys.exc_info() 
				traceback_details = {
									 'filename': exc_traceback.tb_frame.f_code.co_filename,
									 'lineno'  : exc_traceback.tb_lineno,
									 'name'    : exc_traceback.tb_frame.f_code.co_name,
									 'type'    : exc_type.__name__,
									 'message' : exc_value.message, 
									}
			 
				del(exc_type, exc_value, exc_traceback) 
				print traceback_details
				f = file('test1.txt', 'a')
				f.write("%s %s %s %s %s\n" %(traceback_details['filename'],traceback_details['lineno'],traceback_details['name'],traceback_details['type'],traceback_details['message'], ))
				f.flush()
				f.close()

### 调试log

		# cgitb覆盖了默认sys.excepthook全局异常拦截器
		def func(a, b):
			return a / b
		if __name__ == '__main__':
			import cgitb
			cgitb.enable(format='text')
			func(1, 0)

### 函数式编程的内建函数

		apply(func[,nkw][,kw])          # 用可选的参数来调用func,nkw为非关键字参数,kw为关键字参数;返回值是函数调用的返回值
		filter(func,seq)                # 调用一个布尔函数func来迭代遍历每个seq中的元素;返回一个使func返回值为true的元素的序列
		map(func,seq1[,seq2])           # 将函数func作用于给定序列(s)的每个元素,并用一个列表来提供返回值;如果func为None,func表现为一个身份函数,返回一个含有每个序列中元素集合的n个元组的列表
		reduce(func,seq[,init])         # 将二元函数作用于seq序列的元素,每次携带一堆(先前的结果以及下一个序列元素),连续地将现有的结果和下一个值作用在获得的随后的结果上,最后减少我们的序列为一个单一的返回值;如果初始值init给定,第一个比较会是init和第一个序列元素而不是序列的头两个元素
		
		# filter 即通过函数方法只保留结果为真的值组成列表
		def f(x): return x % 2 != 0 and x % 3 != 0
		f(3)     # 函数结果是False  3被filter抛弃
		f(5)     # 函数结果是True   5被加入filter最后的列表结果
		filter(f, range(2, 25))
		[5, 7, 11, 13, 17, 19, 23]
		
		# map 通过函数对列表进行处理得到新的列表
		def cube(x): return x*x*x
		map(cube, range(1, 11))
		[1, 8, 27, 64, 125, 216, 343, 512, 729, 1000]
		
		# reduce 通过函数会先接收初始值和序列的第一个元素，然后是返回值和下一个元素，依此类推
		def add(x,y): return x+y
		reduce(add, range(1, 11))      # 结果55  是1到10的和  x的值是上一次函数返回的结果，y是列表中循环的值

### re正则

		compile(pattern,flags=0)          # 对正则表达式模式pattern进行编译,flags是可选标识符,并返回一个regex对象
		match(pattern,string,flags=0)     # 尝试用正则表达式模式pattern匹配字符串string,flags是可选标识符,如果匹配成功,则返回一个匹配对象;否则返回None
		search(pattern,string,flags=0)    # 在字符串string中搜索正则表达式模式pattern的第一次出现,flags是可选标识符,如果匹配成功,则返回一个匹配对象;否则返回None
		findall(pattern,string[,flags])   # 在字符串string中搜索正则表达式模式pattern的所有(非重复)出现:返回一个匹配对象的列表  # pattern=u'\u4e2d\u6587' 代表UNICODE
		finditer(pattern,string[,flags])  # 和findall()相同,但返回的不是列表而是迭代器;对于每个匹配,该迭代器返回一个匹配对象
		split(pattern,string,max=0)       # 根据正则表达式pattern中的分隔符把字符string分割为一个列表,返回成功匹配的列表,最多分割max次(默认所有)
		sub(pattern,repl,string,max=0)    # 把字符串string中所有匹配正则表达式pattern的地方替换成字符串repl,如果max的值没有给出,则对所有匹配的地方进行替换(subn()会返回一个表示替换次数的数值)
		group(num=0)                      # 返回全部匹配对象(或指定编号是num的子组)
		groups()                          # 返回一个包含全部匹配的子组的元组(如果没匹配成功,返回一个空元组)
		
		例子
			re.findall(r'a[be]c','123abc456eaec789')         # 返回匹配对象列表 ['abc', 'aec']
			re.findall("(.)12[34](..)",a)                    # 取出匹配括号中内容   a='qedqwe123dsf'
			re.search("(.)123",a ).group(1)                  # 搜索匹配的取第1个标签
			re.match("^(1|2) *(.*) *abc$", str).group(2)     # 取第二个标签
			re.match("^(1|2) *(.*) *abc$", str).groups()     # 取所有标签
			re.sub('[abc]','A','alex')                       # 替换
			for i in re.finditer(r'\d+',s):                  # 迭代
				print i.group(),i.span()                     #
		
		搜索网页中UNICODE格式的中文
			QueryAdd='http://www.anti-spam.org.cn/Rbl/Query/Result'
			Ip='222.129.184.52'
			s = requests.post(url=QueryAdd, data={'IP':Ip})
			re.findall(u'\u4e2d\u56fd', s.text, re.S)

### 编码转换

		a='中文'                    # 编码未定义按输入终端utf8或gbk
		u=u'中文'                   # 定义为unicode编码  u值为 u'\u4e2d\u6587'
		u.encode('utf8')            # 转为utf8格式 u值为 '\xe4\xb8\xad\xe6\x96\x87'
		print u                     # 结果显示 中文
		print u.encode('utf8')      # 转为utf8格式,当显示终端编码为utf8  结果显示 中文  编码不一致则乱码
		print u.encode('gbk')       # 当前终端为utf8 故乱码
		ord('4')                    # 字符转ASCII码
		chr(52)                     # ASCII码转字符

### 遍历递归

		[os.path.join(x[0],y) for x in os.walk('/root/python/5') for y in x[2]]

		for i in os.walk('/root/python/5/work/server'):
			print i

## 2 常用模块

### sys

		sys.argv              # 取参数列表
		sys.exit(2)           # 退出脚本返回状态 会被try截取
		sys.exc_info()        # 获取当前正在处理的异常类
		sys.version           # 获取Python解释程序的版本信息
		sys.maxint            # 最大的Int值  9223372036854775807
		sys.maxunicode        # 最大的Unicode值
		sys.modules           # 返回系统导入的模块字段，key是模块名，value是模块
		sys.path              # 返回模块的搜索路径，初始化时使用PYTHONPATH环境变量的值
		sys.platform          # 返回操作系统平台名称
		sys.stdout            # 标准输出
		sys.stdin             # 标准输入
		sys.stderr            # 错误输出
		sys.exec_prefix       # 返回平台独立的python文件安装的位置
		sys.stdin.readline()  # 从标准输入读一行
		sys.stdout.write("a") # 屏幕输出a 

### os

		# 相对sys模块 os模块更为底层 os._exit() try无法抓取
		os.popen('id').read()      # 执行系统命令得到返回结果
		os.system()                # 得到返回状态 返回无法截取
		os.name                    # 返回系统平台 Linux/Unix用户是'posix'
		os.getenv()                # 读取环境变量
		os.putenv()                # 设置环境变量
		os.getcwd()                # 当前工作路径
		os.chdir()                 # 改变当前工作目录
		os.walk('/root/')          # 递归路径
		
		文件处理
			mkfifo()/mknod()       # 创建命名管道/创建文件系统节点
			remove()/unlink()      # 删除文件
			rename()/renames()     # 重命名文件
			*stat()                # 返回文件信息
			symlink()              # 创建符号链接
			utime()                # 更新时间戳
			tmpfile()              # 创建并打开('w+b')一个新的临时文件
			walk()                 # 遍历目录树下的所有文件名
		
		目录/文件夹
			chdir()/fchdir()       # 改变当前工作目录/通过一个文件描述符改变当前工作目录
			chroot()               # 改变当前进程的根目录
			listdir()              # 列出指定目录的文件
			getcwd()/getcwdu()     # 返回当前工作目录/功能相同,但返回一个unicode对象
			mkdir()/makedirs()     # 创建目录/创建多层目录
			rmdir()/removedirs()   # 删除目录/删除多层目录
		
		访问/权限
			saccess()              # 检验权限模式
			chmod()                # 改变权限模式
			chown()/lchown()       # 改变owner和groupID功能相同,但不会跟踪链接
			umask()                # 设置默认权限模式
			
		文件描述符操作
			open()                 # 底层的操作系统open(对于稳健,使用标准的内建open()函数)
			read()/write()         # 根据文件描述符读取/写入数据 按大小读取文件部分内容
			dup()/dup2()           # 复制文件描述符号/功能相同,但是复制到另一个文件描述符
		
		设备号
			makedev()              # 从major和minor设备号创建一个原始设备号
			major()/minor()        # 从原始设备号获得major/minor设备号
		
		os.path模块

			os.path.expanduser('~/.ssh/key')   # 家目录下文件的全路径

			分隔
				os.path.basename()         # 去掉目录路径,返回文件名
				os.path.dirname()          # 去掉文件名,返回目录路径
				os.path.join()             # 将分离的各部分组合成一个路径名
				os.path.spllt()            # 返回(dirname(),basename())元组
				os.path.splitdrive()       # 返回(drivename,pathname)元组
				os.path.splitext()         # 返回(filename,extension)元组
			
			信息
				os.path.getatime()         # 返回最近访问时间
				os.path.getctime()         # 返回文件创建时间
				os.path.getmtime()         # 返回最近文件修改时间
				os.path.getsize()          # 返回文件大小(字节)
			
			查询
				os.path.exists()          # 指定路径(文件或目录)是否存在
				os.path.isabs()           # 指定路径是否为绝对路径
				os.path.isdir()           # 指定路径是否存在且为一个目录
				os.path.isfile()          # 指定路径是否存在且为一个文件
				os.path.islink()          # 指定路径是否存在且为一个符号链接
				os.path.ismount()         # 指定路径是否存在且为一个挂载点
				os.path.samefile()        # 两个路径名是否指向同一个文件
		
		相关模块
			base64              # 提供二进制字符串和文本字符串间的编码/解码操作
			binascii            # 提供二进制和ASCII编码的二进制字符串间的编码/解码操作
			bz2                 # 访问BZ2格式的压缩文件
			csv                 # 访问csv文件(逗号分隔文件)
			csv.reader(open(file))
			filecmp             # 用于比较目录和文件
			fileinput           # 提供多个文本文件的行迭代器
			getopt/optparse     # 提供了命令行参数的解析/处理
			glob/fnmatch        # 提供unix样式的通配符匹配的功能
			gzip/zlib           # 读写GNU zip(gzip)文件(压缩需要zlib模块)
			shutil              # 提供高级文件访问功能
			c/StringIO          # 对字符串对象提供类文件接口
			tarfile             # 读写TAR归档文件,支持压缩文件
			tempfile            # 创建一个临时文件
			uu                  # uu格式的编码和解码
			zipfile             # 用于读取zip归档文件的工具
			environ['HOME']     # 查看系统环境变量
		
		子进程
			os.fork()    # 创建子进程,并复制父进程所有操作  通过判断pid = os.fork() 的pid值,分别执行父进程与子进程操作，0为子进程
			os.wait()    # 等待子进程结束

		跨平台os模块属性

			linesep         # 用于在文件中分隔行的字符串
			sep             # 用来分隔文件路径名字的字符串
			pathsep         # 用于分割文件路径的字符串
			curdir          # 当前工作目录的字符串名称
			pardir          # 父目录字符串名称

### commands
	
		commands.getstatusoutput('id')       # 返回元组(状态,标准输出)
		commands.getoutput('id')             # 只返回执行的结果, 忽略返回值
		commands.getstatus('file')           # 返回ls -ld file执行的结果
			
### 文件和目录管理
	
		import shutil
		shutil.copyfile('data.db', 'archive.db')             # 拷贝文件
		shutil.move('/build/executables', 'installdir')      # 移动文件或目录

### 文件通配符

		import glob
		glob.glob('*.py')    # 查找当前目录下py结尾的文件

### 随机模块
	
		import random
		random.choice(['apple', 'pear', 'banana'])   # 随机取列表一个参数
		random.sample(xrange(100), 10)  # 不重复抽取10个
		random.random()                 # 随机浮点数
		random.randrange(6)             # 随机整数范围
	
### 发送邮件

		发送邮件内容

			#!/usr/bin/python
			#encoding:utf8
			# 导入 smtplib 和 MIMEText 
			import smtplib
			from email.mime.text import MIMEText

			# 定义发送列表 
			mailto_list=["272121935@qq.com","272121935@163.com"]

			# 设置服务器名称、用户名、密码以及邮件后缀 
			mail_host = "smtp.163.com"
			mail_user = "mailuser"
			mail_pass = "password"
			mail_postfix="163.com"

			# 发送邮件函数
			def send_mail(to_list, sub):
				me = mail_user + "<"+mail_user+"@"+mail_postfix+">"
				fp = open('context.txt')
				msg = MIMEText(fp.read(),_charset="utf-8")
				fp.close()
				msg['Subject'] = sub
				msg['From'] = me
				msg['To'] = ";".join(to_list)
				try:
					send_smtp = smtplib.SMTP()
					send_smtp.connect(mail_host)
					send_smtp.login(mail_user, mail_pass)
					send_smtp.sendmail(me, to_list, msg.as_string())
					send_smtp.close()
					return True
				except Exception, e:
					print str(e)
					return False

			if send_mail(mailto_list,"标题"):
				print "测试成功"
			else:
				print "测试失败"

		发送附件

			#!/usr/bin/python
			#encoding:utf8
			import smtplib
			from email.mime.multipart import MIMEMultipart
			from email.mime.base import MIMEBase
			from email import encoders

			def send_mail(to_list, sub, filename):
				me = mail_user + "<"+mail_user+"@"+mail_postfix+">"
				msg = MIMEMultipart()
				msg['Subject'] = sub
				msg['From'] = me
				msg['To'] = ";".join(to_list)
				submsg = MIMEBase('application', 'x-xz')
				submsg.set_payload(open(filename,'rb').read())
				encoders.encode_base64(submsg)
				submsg.add_header('Content-Disposition', 'attachment', filename=filename)
				msg.attach(submsg)
				try:
					send_smtp = smtplib.SMTP()
					send_smtp.connect(mail_host)
					send_smtp.login(mail_user, mail_pass)
					send_smtp.sendmail(me, to_list, msg.as_string())
					send_smtp.close()
					return True
				except Exception, e:
					print str(e)[1]
					return False

			# 设置服务器名称、用户名、密码以及邮件后缀 
			mail_host = "smtp.163.com"
			mail_user = "xuesong"
			mail_pass = "mailpasswd"
			mail_postfix = "163.com"
			mailto_list = ["272121935@qq.com","quanzhou722@163.com"]
			title = 'check'
			filename = 'file_check.html'
			if send_mail(mailto_list,title,filename):
				print "发送成功"
			else:
				print "发送失败"

### 解压缩

		gzip压缩

			import gzip
			f_in = open('file.log', 'rb')
			f_out = gzip.open('file.log.gz', 'wb')
			f_out.writelines(f_in)
			f_out.close()
			f_in.close()

		gzip压缩1

			File = 'xuesong_18.log'
			g = gzip.GzipFile(filename="", mode='wb', compresslevel=9, fileobj=open((r'%s.gz' %File),'wb'))
			g.write(open(r'%s' %File).read())
			g.close()

		gzip解压

			g = gzip.GzipFile(mode='rb', fileobj=open((r'xuesong_18.log.gz'),'rb'))
			open((r'xuesong_18.log'),'wb').write(g.read())

		压缩tar.gz

			import os
			import tarfile
			tar = tarfile.open("/tmp/tartest.tar.gz","w:gz")   # 创建压缩包名
			for path,dir,files in os.walk("/tmp/tartest"):     # 递归文件目录
				for file in files:
					fullpath = os.path.join(path,file)
					tar.add(fullpath)                          # 创建压缩包
			tar.close()

		解压tar.gz
			
			import tarfile
			tar = tarfile.open("/tmp/tartest.tar.gz")
			#tar.extract("/tmp")                           # 全部解压到指定路径
			names = tar.getnames()                         # 包内文件名
			for name in names:
				tar.extract(name,path="./")                # 解压指定文件
			tar.close()

		zip压缩
			import zipfile,os
			f = zipfile.ZipFile('filename.zip', 'w' ,zipfile.ZIP_DEFLATED)    # ZIP_STORE 为默认表不压缩. ZIP_DEFLATED 表压缩
			#f.write('file1.txt')                              # 将文件写入压缩包
			for path,dir,files in os.walk("tartest"):          # 递归压缩目录
				for file in files:
					f.write(os.path.join(path,file))           # 将文件逐个写入压缩包         
			f.close()

		zip解压
			if zipfile.is_zipfile('filename.zip'):        # 判断一个文件是不是zip文件
				f = zipfile.ZipFile('filename.zip')
				for file in f.namelist():                 # 返回文件列表
					f.extract(file, r'/tmp/')             # 解压指定文件
				#f.extractall()                           # 解压全部
				f.close()

### 时间

		import time
		time.time()                          # 时间戳[浮点]
		time.localtime()[1] - 1              # 上个月
		int(time.time())                     # 时间戳[整s]
		tomorrow.strftime('%Y%m%d_%H%M')     # 格式化时间
		time.strftime('%Y-%m-%d_%X',time.localtime( time.time() ) )              # 时间戳转日期
		time.mktime(time.strptime('2012-03-28 06:53:40', '%Y-%m-%d %H:%M:%S'))   # 日期转时间戳

		判断输入时间格式是否正确
		
			#encoding:utf8
			import time
			while 1:
				atime=raw_input('输入格式如[14.05.13 13:00]:')
				try:
					btime=time.mktime(time.strptime('%s:00' %atime, '%y.%m.%d %H:%M:%S'))
					break
				except:
					print '时间输入错误,请重新输入，格式如[14.05.13 13:00]'

		上一个月最后一天
			import datetime
			lastMonth=datetime.date(datetime.date.today().year,datetime.date.today().month,1)-datetime.timedelta(1)
			lastMonth.strftime("%Y/%m")

		前一天
			(datetime.datetime.now() + datetime.timedelta(days=-1) ).strftime('%Y%m%d')

		两日期相差天数

			import datetime
			d1 = datetime.datetime(2005, 2, 16)
			d2 = datetime.datetime(2004, 12, 31)
			(d1 - d2).days

		向后加10个小时

			import datetime
			d1 = datetime.datetime.now()
			d3 = d1 + datetime.timedelta(hours=10)
			d3.ctime()

### 参数[optparse]
		import os, sys
		import time
		import optparse
		# python aaa.py -t file -p /etc/opt -o aaaaa

		def do_fiotest( type, path, output,):
			print type, path, output,

		def main():
			parser = optparse.OptionParser()
			parser.add_option('-t', '--type', dest = 'type', default = None, help = 'test type[file, device]')
			parser.add_option('-p', '--path', dest = 'path', default = None, help = 'test file path or device path')
			parser.add_option('-o', '--output', dest = 'output', default = None, help = 'result dir path')

			(o, a) = parser.parse_args()

			if None == o.type or None == o.path or None == o.output:
				print "No device or file or output dir"
				return -1

			if 'file' != o.type and 'device' != o.type:
				print "You need specify test type ['file' or 'device']"
				return -1

			do_fiotest(o.type, o.path, o.output)
			print "Test done!"
			

		if __name__ == '__main__':
			main()

### hash

		import md5
		m = md5.new('123456').hexdigest()
		
		import hashlib
		m = hashlib.md5()
		m.update("Nobody inspects")    # 使用update方法对字符串md5加密
		m.digest()                     # 加密后二进制结果
		m.hexdigest()                  # 加密后十进制结果
		hashlib.new("md5", "string").hexdigest()               # 对字符串加密
		hashlib.new("md5", open("file").read()).hexdigest()    # 查看文件MD5值

### 隐藏输入密码

		import getpass
		passwd=getpass.getpass()

### string打印a-z
		import string
		string.lowercase       # a-z小写
		string.uppercase       # A-Z大小

### paramiko [ssh客户端]

		安装
			sudo apt-get install python-setuptools 
			easy_install
			sudo apt-get install python-all-dev
			sudo apt-get install build-essential

		paramiko实例(账号密码登录执行命令)
```python
			#!/usr/bin/python
			#ssh
			import paramiko
			import sys,os

			host = '10.152.15.200'
			user = 'peterli'
			password = '123456'

			s = paramiko.SSHClient()                                 # 绑定实例
			s.load_system_host_keys()                                # 加载本地HOST主机文件
			s.set_missing_host_key_policy(paramiko.AutoAddPolicy())  # 允许连接不在know_hosts文件中的主机
			s.connect(host,22,user,password,timeout=5)               # 连接远程主机
			while True:
					cmd=raw_input('cmd:')
					stdin,stdout,stderr = s.exec_command(cmd)        # 执行命令
					cmd_result = stdout.read(),stderr.read()         # 读取命令结果
					for line in cmd_result:
							print line,
			s.close()
```
		paramiko实例(传送文件)
```python
			#!/usr/bin/evn python
			import os
			import paramiko
			host='127.0.0.1'
			port=22
			username = 'peterli'
			password = '123456'
			ssh=paramiko.Transport((host,port))
			privatekeyfile = os.path.expanduser('~/.ssh/id_rsa') 
			mykey = paramiko.RSAKey.from_private_key_file( os.path.expanduser('~/.ssh/id_rsa'))   # 加载key 不使用key可不加
			ssh.connect(username=username,password=password)           # 连接远程主机
			# 使用key把 password=password 换成 pkey=mykey
			sftp=paramiko.SFTPClient.from_transport(ssh)               # SFTP使用Transport通道
			sftp.get('/etc/passwd','pwd1')                             # 下载 两端都要指定文件名
			sftp.put('pwd','/tmp/pwd')                                 # 上传
			sftp.close()
			ssh.close()
```
		paramiko实例(密钥执行命令)
```python
			#!/usr/bin/python
			#ssh
			import paramiko
			import sys,os
			host = '10.152.15.123'
			user = 'peterli'
			s = paramiko.SSHClient()
			s.load_system_host_keys()
			s.set_missing_host_key_policy(paramiko.AutoAddPolicy())
			privatekeyfile = os.path.expanduser('~/.ssh/id_rsa')             # 定义key路径
			mykey = paramiko.RSAKey.from_private_key_file(privatekeyfile)
			# mykey=paramiko.DSSKey.from_private_key_file(privatekeyfile,password='061128')   # DSSKey方式 password是key的密码
			s.connect(host,22,user,pkey=mykey,timeout=5)
			cmd=raw_input('cmd:')
			stdin,stdout,stderr = s.exec_command(cmd)
			cmd_result = stdout.read(),stderr.read()
			for line in cmd_result:
					print line,
			s.close()
```
		ssh并发(Pool控制最大并发)
```python
			#!/usr/bin/env python
			#encoding:utf8
			#ssh_concurrent.py

			import multiprocessing
			import sys,os,time
			import paramiko

			def ssh_cmd(host,port,user,passwd,cmd):
				msg = "-----------Result:%s----------" % host

				s = paramiko.SSHClient()
				s.load_system_host_keys()
				s.set_missing_host_key_policy(paramiko.AutoAddPolicy())
				try:
					s.connect(host,22,user,passwd,timeout=5) 
					stdin,stdout,stderr = s.exec_command(cmd)

					cmd_result = stdout.read(),stderr.read()
					print msg
					for line in cmd_result:
							print line,

					s.close()
				except paramiko.AuthenticationException:
					print msg
					print 'AuthenticationException Failed'
				except paramiko.BadHostKeyException:
					print msg
					print "Bad host key"	

			result = []
			p = multiprocessing.Pool(processes=20)
			cmd=raw_input('CMD:')
			f=open('serverlist.conf')
			list = f.readlines()
			f.close()
			for IP in list:
				print IP
				host=IP.split()[0]
				port=int(IP.split()[1])
				user=IP.split()[2]
				passwd=IP.split()[3]
				result.append(p.apply_async(ssh_cmd,(host,port,user,passwd,cmd)))

			p.close()

			for res in result:
				res.get(timeout=35)
```
		ssh并发(取文件状态并发送邮件)
```python
			#!/usr/bin/python
			#encoding:utf8
			#config file: ip.list

			import paramiko
			import multiprocessing
			import smtplib
			import sys,os,time,datetime,socket,re
			from email.mime.text import MIMEText

			# 配置文件(IP列表)
			Conf = 'ip.list'
			user_name = 'peterli'
			user_pwd = 'passwd'
			port = 22
			PATH = '/home/peterli/'

			# 设置服务器名称、用户名、密码以及邮件后缀 
			mail_host = "smtp.163.com"
			mail_user = "xuesong"
			mail_pass = "mailpasswd"
			mail_postfix = "163.com"
			mailto_list = ["272121935@qq.com","quanzhou722@163.com"]
			title = 'file check'

			DATE1=(datetime.datetime.now() + datetime.timedelta(days=-1) ).strftime('%Y%m%d')
			file_path = '%s%s' %(PATH,DATE1)

			def Ssh_Cmd(file_path,host_ip,user_name,user_pwd,port=22):

				s = paramiko.SSHClient()
				s.load_system_host_keys()
				s.set_missing_host_key_policy(paramiko.AutoAddPolicy())
				
				try:
					s.connect(hostname=host_ip,port=port,username=user_name,password=user_pwd)
					stdin,stdout,stderr = s.exec_command('stat %s' %file_path)
					stat_result = '%s%s' %(stdout.read(),stderr.read())
					if stat_result.find('No such file or directory') == -1:
						file_status = 'OK\t'
						stdin,stdout,stderr = s.exec_command('du -sh %s' %file_path)
						cmd1_result = '%s_%s' %(stat_result.split()[32],stat_result.split()[33].split('.')[0])
						cmd2_result = ('%s%s' %(stdout.read(),stderr.read())).split()[0] 
					else:
						file_status = '未生成\t'
						cmd1_result = 'null'
						cmd2_result = 'null'
					q.put(['Login successful'])
					s.close()
				except socket.error:
					file_status = '主机或端口错误'
					cmd1_result = '-'
					cmd2_result = '-'
				except paramiko.AuthenticationException:
					file_status = '用户或密码错误'
					cmd1_result = '-'
					cmd2_result = '-'
				except paramiko.BadHostKeyException:
					file_status = 'Bad host key'
					cmd1_result = '-'
					cmd2_result = '-'
				except:
					file_status = 'ssh异常'
					cmd1_result = '-'
					cmd2_result = '-'
				r.put('%s\t-\t%s\t%s\t%s\t%s\n' %(time.strftime('%Y-%m-%d_%H:%M'),host_ip,file_status,cmd2_result,cmd1_result))

			def Concurrent(Conf,file_path,user_name,user_pwd,port):
				# 执行总计
				total = 0
				# 读取配置文件
				f=open(Conf)
				list = f.readlines()
				f.close()
				# 并发执行
				process_list = []
				log_file = file('file_check.log', 'w')
				log_file.write('检查时间\t\t业务\tIP\t\t文件状态\t大小\t生成时间\n') 
				for host_info in list:
					# 判断配置文件中注释行跳过
					if host_info.startswith('#'):
						continue
					# 取变量,其中任意变量未取到就跳过执行
					try:
						host_ip=host_info.split()[0].strip()
						#user_name=host_info.split()[1]
						#user_pwd=host_info.split()[2]
					except:
						log_file.write('Profile error: %s\n' %(host_info))
						continue
					#try:
					#	port=int(host_info.split()[3])
					#except:
					#	port=22
					total +=1
					p = multiprocessing.Process(target=Ssh_Cmd,args=(file_path,host_ip,user_name,user_pwd,port))
					p.start()
					process_list.append(p)
				for j in process_list:
					j.join()
				for j in process_list:
					log_file.write(r.get())

				successful = q.qsize()
				log_file.write('执行完毕。 总执行:%s 登录成功:%s 登录失败:%s\n' %(total,successful,total - successful))
				log_file.flush()
				log_file.close()

			def send_mail(to_list, sub):
				me = mail_user + "<"+mail_user+"@"+mail_postfix+">"
				fp = open('file_check.log')
				msg = MIMEText(fp.read(),_charset="utf-8")
				fp.close()
				msg['Subject'] = sub
				msg['From'] = me
				msg['To'] = ";".join(to_list)
				try:
					send_smtp = smtplib.SMTP()
					send_smtp.connect(mail_host)
					send_smtp.login(mail_user, mail_pass)
					send_smtp.sendmail(me, to_list, msg.as_string())
					send_smtp.close()
					return True
				except Exception, e:
					print str(e)[1]
					return False

			if __name__ == '__main__':
				q = multiprocessing.Queue()
				r = multiprocessing.Queue()
				Concurrent(Conf,file_path,user_name,user_pwd,port)
				if send_mail(mailto_list,title):
					print "发送成功"
				else:
					print "发送失败"
```
		LazyManage并发批量操作(判断非root交互到root操作)
```python
			#!/usr/bin/python
			#encoding:utf8
			# LzayManage.py
			# config file: serverlist.conf

			import paramiko
			import multiprocessing
			import sys,os,time,socket,re

			def Ssh_Cmd(host_ip,Cmd,user_name,user_pwd,port=22):
				s = paramiko.SSHClient()
				s.load_system_host_keys()
				s.set_missing_host_key_policy(paramiko.AutoAddPolicy())
				s.connect(hostname=host_ip,port=port,username=user_name,password=user_pwd)
				stdin,stdout,stderr = s.exec_command(Cmd)
				Result = '%s%s' %(stdout.read(),stderr.read())
				q.put('successful')
				s.close()
				return Result.strip()

			def Ssh_Su_Cmd(host_ip,Cmd,user_name,user_pwd,root_name,root_pwd,port=22):
				s = paramiko.SSHClient()
				s.load_system_host_keys()
				s.set_missing_host_key_policy(paramiko.AutoAddPolicy())
				s.connect(hostname=host_ip,port=port,username=user_name,password=user_pwd)
				ssh = s.invoke_shell()
				time.sleep(0.1)
				ssh.send('su - %s\n' %(root_name))
				buff = ''
				while not buff.endswith('Password: '):
					resp = ssh.recv(9999)
					buff +=resp
				ssh.send('%s\n' %(root_pwd))
				buff = ''
				while True:
					resp = ssh.recv(9999)
					buff +=resp
					if ': incorrect password' in buff:
						su_correct='passwd_error'
						break
					elif buff.endswith('# '):
						su_correct='passwd_correct'
						break
				if su_correct == 'passwd_correct':
					ssh.send('%s\n' %(Cmd))
					buff = ''
					while True:
						resp = ssh.recv(9999)
						if resp.endswith('# '):
							buff +=re.sub('\[.*@.*\]# $','',resp)
							break
						buff +=resp
					Result = buff.lstrip('%s' %(Cmd))
					q.put('successful')
				elif su_correct == 'passwd_error':
					Result = "\033[31mroot密码错误\033[m"
				s.close()
				return Result.strip()

			def Send_File(host_ip,PathList,user_name,user_pwd,Remote='/tmp',port=22):
				s=paramiko.Transport((host_ip,port))
				s.connect(username=user_name,password=user_pwd)
				sftp=paramiko.SFTPClient.from_transport(s) 
				for InputPath in PathList:
					LocalPath = re.sub('^\./','',InputPath.rstrip('/'))
					RemotePath = '%s/%s' %( Remote , os.path.basename( LocalPath ))
					try:
						sftp.rmdir(RemotePath)
					except:
						pass
					try:
						sftp.remove(RemotePath)
					except:
						pass
					if os.path.isdir(LocalPath):
						sftp.mkdir(RemotePath)
						for path,dirs,files in os.walk(LocalPath):
							for dir in dirs:
								dir_path = os.path.join(path,dir)
								sftp.mkdir('%s/%s' %(RemotePath,re.sub('^%s/' %LocalPath,'',dir_path)))
							for file in files:
								file_path = os.path.join(path,file)
								sftp.put( file_path,'%s/%s' %(RemotePath,re.sub('^%s/' %LocalPath,'',file_path)))
					else:
						sftp.put(LocalPath,RemotePath)
				q.put('successful')
				sftp.close()
				s.close()
				Result = '%s  \033[32m传送完成\033[m' % PathList
				return Result

			def Ssh(host_ip,Operation,user_name,user_pwd,root_name,root_pwd,Cmd=None,PathList=None,port=22):
				msg = "\033[32m-----------Result:%s----------\033[m" % host_ip
				try:
					if Operation == 'Ssh_Cmd':
						Result = Ssh_Cmd(host_ip=host_ip,Cmd=Cmd,user_name=user_name,user_pwd=user_pwd,port=port)
					elif Operation == 'Ssh_Su_Cmd':
						Result = Ssh_Su_Cmd(host_ip=host_ip,Cmd=Cmd,user_name=user_name,user_pwd=user_pwd,root_name=root_name,root_pwd=root_pwd,port=port)
					elif Operation == 'Ssh_Script':
						Send_File(host_ip=host_ip,PathList=PathList,user_name=user_name,user_pwd=user_pwd,port=port)
						Script_Head = open(PathList[0]).readline().strip()
						LocalPath = re.sub('^\./','',PathList[0].rstrip('/'))
						Cmd = '%s /tmp/%s' %( re.sub('^#!','',Script_Head), os.path.basename( LocalPath ))
						Result = Ssh_Cmd(host_ip=host_ip,Cmd=Cmd,user_name=user_name,user_pwd=user_pwd,port=port)
					elif Operation == 'Ssh_Su_Script':
						Send_File(host_ip=host_ip,PathList=PathList,user_name=user_name,user_pwd=user_pwd,port=port)
						Script_Head = open(PathList[0]).readline().strip()
						LocalPath = re.sub('^\./','',PathList[0].rstrip('/'))
						Cmd = '%s /tmp/%s' %( re.sub('^#!','',Script_Head), os.path.basename( LocalPath ))
						Result = Ssh_Su_Cmd(host_ip=host_ip,Cmd=Cmd,user_name=user_name,user_pwd=user_pwd,root_name=root_name,root_pwd=root_pwd,port=port)
					elif Operation == 'Send_File':
						Result = Send_File(host_ip=host_ip,PathList=PathList,user_name=user_name,user_pwd=user_pwd,port=port)
					else:
						Result = '操作不存在'
					
				except socket.error:
					Result = '\033[31m主机或端口错误\033[m'
				except paramiko.AuthenticationException:
					Result = '\033[31m用户名或密码错误\033[m'
				except paramiko.BadHostKeyException:
					Result = '\033[31mBad host key\033[m['
				except IOError:
					Result = '\033[31m远程主机已存在非空目录或没有写权限\033[m'
				except:
					Result = '\033[31m未知错误\033[m'
				r.put('%s\n%s\n' %(msg,Result))

			def Concurrent(Conf,Operation,user_name,user_pwd,root_name,root_pwd,Cmd=None,PathList=None,port=22):
				# 读取配置文件
				f=open(Conf)
				list = f.readlines()
				f.close()
				# 执行总计
				total = 0
				# 并发执行
				for host_info in list:
					# 判断配置文件中注释行跳过
					if host_info.startswith('#'):
						continue
					# 取变量,其中任意变量未取到就跳过执行
					try:
						host_ip=host_info.split()[0]
						#user_name=host_info.split()[1]
						#user_pwd=host_info.split()[2]
					except:
						print('Profile error: %s' %(host_info) )
						continue
					try:
						port=int(host_info.split()[3])
					except:
						port=22
					total +=1
					p = multiprocessing.Process(target=Ssh,args=(host_ip,Operation,user_name,user_pwd,root_name,root_pwd,Cmd,PathList,port))
					p.start()
				# 打印执行结果
				for j in range(total):
					print(r.get() )
				if Operation == 'Ssh_Script' or Operation == 'Ssh_Su_Script':
					successful = q.qsize() / 2
				else:
					successful = q.qsize()
				print('\033[32m执行完毕[总执行:%s 成功:%s 失败:%s]\033[m' %(total,successful,total - successful) )
				q.close()
				r.close()

			def Help():
				print('''	1.执行命令
				2.执行脚本      \033[32m[位置1脚本(必须带脚本头),后可带执行脚本所需要的包\文件\文件夹路径,空格分隔]\033[m
				3.发送文件      \033[32m[传送的包\文件\文件夹路径,空格分隔]\033[m
				退出: 0\exit\quit
				帮助: help\h\?
				注意: 发送文件默认为/tmp下,如已存在同名文件会被强制覆盖,非空目录则中断操作.执行脚本先将本地脚本及包发送远程主机上,发送规则同发送文件
				''')

			if __name__=='__main__':
				# 定义root账号信息
				root_name = 'root'
				root_pwd = 'peterli'
				user_name='peterli'
				user_pwd='<++(3Ie'
				# 配置文件
				Conf='serverlist.conf'
				if not os.path.isfile(Conf):
					print('\033[33m配置文件 %s 不存在\033[m' %(Conf) )
					sys.exit()
				Help()
				while True:
					i = raw_i
```