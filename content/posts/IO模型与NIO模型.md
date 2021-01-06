---
title: "IO模型与NIO模型"
date: 2017-10-16T22:12:00+08:00
draft: false
---
#### IO与NIO读取数据 ####
```

    +--------+                                    +--------+     +------+
    | Thread +------------------------------------> stream +-----> OS   |
    +--------+                                    +--------+     +------+
    
                                    +--------+   +---------+
                                +-- > buffer +---> channel +--+
                                |   +--------+   +---------+  |
                                |                             |
    +--------+    +----------+  |   +--------+   +---------+  |  +------+
    | Thread +----> selector +----- > buffer +---> channel +-----> OS   |
    +--------+    +----------+  |   +--------+   +---------+  |  +------+
                                |                             |
                                |   +--------+   +---------+  |
                                +-- > buffer +---> channel +--+
                                    +--------+   +---------+

```
#### NIO读取含中文文本文件的例子 ####
```java
import java.io.IOException;
import java.io.RandomAccessFile;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;

public class NIOTest {
    public static void main(String[] args) throws IOException {
        byte[] b1 = new byte[1];
        int bn  = 0;
        RandomAccessFile aFile = new RandomAccessFile("D:/niotest.txt", "rw");
        FileChannel inChannel = aFile.getChannel();
        ByteBuffer buffer = ByteBuffer.allocate(2);
        int bytesRead = inChannel.read(buffer);
        while (bytesRead != -1){
            buffer.flip();//翻过来，不让操作系统继续向缓冲区写入数据。
            while(buffer.hasRemaining()){
                b1 = ensureCapacity(b1, bn);
                b1[bn++] = buffer.get();//按字节获取。如果按字获取，则必须保证每次读到的字节数为两个。
            }
            buffer.clear();//清理缓存区的数据，让操作系统可以继续向缓冲区写数据。
            bytesRead = inChannel.read(buffer);
        }
        aFile.close();
        String content = new String(b1,"UTF-8");
        System.out.println(content.toString());
    }

    private static byte[] ensureCapacity(byte[] b1, int bn) {
        if(bn == b1.length){
            byte[] b2 = new byte[b1.length*2];
            System.arraycopy(b1,0,b2,0,b1.length);
            b1 = b2;
        }
        return b1;
    }
}
```
