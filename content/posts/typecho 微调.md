---
title: "typecho 微调"
date: 2017-10-17T16:30:00+08:00
draft: false
---
### 主题与插件 ###
主题：Moricolor
插件：
1. Access	获取访客信息
1. Adminer	Adminer for Typecho Blog Platform
1. AjaxComments	Ajax 内置嵌套评论
1. AppStore	Typecho 应用商店
1. APlayer for Typecho | Meting	APlayer for Typecho
1. TpCache	Typecho缓存插件

### typecho本身 ###
typecho编辑器的工具栏在浏览器窗口过窄时，比如用手机打开，就会出现按钮“丢失”。工具栏的`id`和`class`都为`wmd-button-row`，问题出在css文件'admin/css/style.css'中高度的设置为26px，改成`auto`就可以了。
```css
.wmd-button-row{list-style:none;margin:0;padding:0;height:26px;line-height:1;}
```
原来的CSS样式
![改造过后的typecho编辑工具栏.PNG][1]

  [1]: https://zhangxinde.com/usr/uploads/2017/10/1551369649.png
修改过后的工具栏在手机上也可以使用了。