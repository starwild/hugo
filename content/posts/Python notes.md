---
title: "Python笔记"
date: 2019-08-03T21:33:00+08:00
draft: false
---
##多线程

CPython的实现中因为GIL的存在，Python的多线程实际上是单线程。multiprocessing包用于多进程处理，但此进程是系统级的进程。
```python
from multiprocessing import Pool
import random,time

def work(i):
    print(i)
    time.sleep((random.random()*0.5))
    print(i[0],i[1])
if __name__ == "__main__":
    print('start')
    data = [('a',2),('b',3),('c',4)]

    # 第一种用法
    p = Pool(2)
    for x in p.imap(work, data):
        pass
    print('done')
    
    # 第二种用法
    p0 = Pool(2)
    p0.map_async(work,data)
    p0.close() # pool无法再放入进程，pool内进程执行完成后销毁
    # p0.terminate() 直接销毁进程池 
    p0.join()

    # 第三种用法
    print('map_async_done')
    p1 = Pool(2)
    p1.apply_async(func=work,args=((1,2),))
    p1.close()
    # p1.terminate()
    p1.join()
    print('done')
```

## jupyter-notobook
展示二进制图片
```python
from IPython.display import Image,display
display(Image(data=))
```