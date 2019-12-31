# 一条命令开启webserver
## Mac自带server
Mac自带了一个WebServer Apache，可以使用简单的命令来开启和关闭

```

开启 apache: sudo apachectl start
重启 apache: sudo apachectl restart
关闭 apache: sudo apachectl stop
```

开启后打开127.0.0.1，会看到一个默认的“It works”页面。

将需要被访问的文件放到/Library/WebServer/Documents，即可用浏览器访问。

## FIS3
FIS3是一个工具，服务于前端项目。我们今天的重点是 WebServer，而 Fis3 提供了一个默认的 WebServer，非常好用，而且简单。首先需要安装 Fis3。

安装 Fis3 前需要安装 Node，它的出现对前端开发来说是「颠覆性」的，使得 JavaScript 可以用来开发 Sever，而且它的生态十分强大，很多功能一个中间件即可搞定。Node 自身提供了 HTTP 模块，而且开源，这就使得我们后续学习 HTTP 协议提供了很大的参考价值。可以到 Node 官网下载安装 https://nodejs.org/zh-cn/。

Node 使用 npm（node package manager）来管理第三方代码，可以理解为 iOS 中的 pod。安装 Node 后，npm 会自动被安装。安装完 Node 后，在终端输入命令测试是否安装成功：

```
$ node -v            
v12.11.1

$ npm -v             
6.11.3

npm install -g fis3

```

安装完成后，可以使用fis3命令

```
fis3             

 [INFO] Currently running fis3 (/Users/lindubo505/.nvm/versions/node/v12.11.1/lib/node_modules/fis3/)

 Usage: fis3 <command>

 Commands:

   init                           scaffold with specifed template.
   install                        install components
   release [media name]           build and deploy your project
   server <command> [options]     launch a server
   inspect [media name]           inspect the result of fis.match 
```

1. 通用`fis3 server start`开启WebServer
2. 通过`fis3 release`把当前目录文件码部署到WebServer
3. 访问http://127.0.0.1:8080/
4. 通过`fis3 server open`可以打开WebServer所在目录