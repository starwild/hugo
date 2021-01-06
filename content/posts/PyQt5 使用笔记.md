---
title: "PyQt5 使用笔记"
date: 2019-08-18T01:43:21+08:00
draft: false
---
文件对话
```python

        directory1 = QFileDialog.getExistingDirectory(self,
                                    "选取文件夹",
                                    "C:/")                                 #起始路径
 
        fileName1, filetype = QFileDialog.getOpenFileName(self,
                                    "选取文件",
                                    "C:/",
                                    "All Files (*);;Text Files (*.txt)")   #设置文件扩展名过滤,注意用双分号间隔
        files, ok1 = QFileDialog.getOpenFileNames(self,
                                    "多文件选择",
                                    "C:/",
                                    "All Files (*);;Text Files (*.txt)")
        fileName2, ok2 = QFileDialog.getSaveFileName(self,
                                    "文件保存",
                                    "C:/",
                                    "All Files (*);;Text Files (*.txt)")
```