# server 的接口是如何实现的
做客户端的同学大多数不知道 server 的接口是如何实现，今天我以 Node 为例来介绍如何实现一个接口。Node 实现接口通常会依赖于 web 框架，主流的有 express 和 koa，我们以 express 为例。

1.先新建一个文件夹，名字为 app

2.在这个目录下创建 app.js 文件；

3.执行npm init 初始化package.json 文件，按照提示一路回车即可；

4.执行 npm install express, 安装 express 框架；

在 app.js 文件中加入下面代码：

```
// 导入 expres 框架
const express = require('express');
// 初始化 express
const app = express();
// get 方法，匹配 path 为 /api/fe/list
app.get('/api/fe/list', function (req, res) {
    console.log('request path:' + req.path);
    var result = {
    code: 200,
    data: {
            name: "前端小课",
            des: "第三阶段内容：网络编程内容 HTTP，TCP，WebServer"
          }
    }
    // 响应以 json 的方式返回给客户端
    res.json(result);
});
// 监听 8888 端口
app.listen(8888);

console.log('app start: http://127.0.0.1:8888');
```

进入 app 目录，执行 node app.js，此时 HTTP 服务就开始了正常工作:

```
$ node app.js
app start: http://127.0.0.1:8888
request path:/api/fe/list
```

此时可用客户端代码或浏览器请求http://127.0.0.1:8888/api/fe/list