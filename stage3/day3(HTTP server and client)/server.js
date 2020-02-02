const http = require('http');

// 创建HTTP server
const server = new http.Server();

/**
 * request 事件，当客户端发起请求后会响应这个事件
 * req 请求对象
 * res 响应对象
 */

 server.on('request', function(req, res) {
     let path = req.url;
     console.log("path: " + path);
     if (path.indexOf('/api/fe/list') == 0) {
         // 处理path为/api/fe/list的请求
         res.writeHead(200, {
            "Content-type" : "application/json"
         });

         let data = {
             code : "0",
             msg : "success",
             data : {
                 title : "前端小课",
                 des : "stage3 day3 HTTP Server and Client"
             }
         }

         res.write(JSON.stringify(data));
     }
     else {
         res.writeHead(404, {
             "Content-type" : "application/json"
         });

         let data = {
             code : "404",
             msg : "not found"
         };
         res.write(JSON.stringify(data));
     }

     res.end();
 });

 server.listen(8888, function () {
    console.log('Server run in: http://127.0.0.1:8888');
 });