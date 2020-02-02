// 传输控制协议（TCP，Transmission Control Protocol）是一种面向连接的、可靠的、基于字节流的传输层通信协议
// 通过 Node 提供的 net 模块创建 TCP 连接，HTTP 模块其实底层使用的是 net 模块，说明 HTTP 协议是基于 TCP 协议。

let net = require('net');
// 创建 TCP 服务
let server = new net.Server();
// 端口号
const port = 8888;

let Log = function(msg) {
    console.log(msg);
};
// 消息
let serverMsgs = [
    '💁♂️客服小燕：你可以先学 HTML 与 CSS。',
    '💁♂️客服小燕：可以关注素燕这个公众号，我就是和作者学习的，内容非常不错。',
    '💁♂️客服小燕：不客气，请问还有其它事情吗？',
    '💁♂️客服小燕：那我结束本服务了，有什么问题随时咨询我。',
];
// 顺序发送消息给客户端
let sendMsg = function(socket) {    
    if (sendIndex < serverMsgs.length) {
        Log(serverMsgs[sendIndex]);
        socket.write(serverMsgs[sendIndex]);
        sendIndex += 1;
    }
    Log(sendIndex);
    if (sendIndex >= serverMsgs.length) {
        Log('客服小燕：结束了本次服务！');
        sendIndex = 0;
    }
    // 4006186999
};

let sendIndex = 0;

// 监听 connection 事件
server.on("connection", function (socket) {
    // 当收到客户断消息会响应这个事件
    socket.on('data', function(data) {
        // data 是二进制数据
        Log(data.toString());
        setTimeout(() => {
            sendMsg(socket);
        }, 800);
    });
    // 获取连接的客户端数
    server.getConnections(function(err,count){
        Log("The client count: " + count);
    });
});

// 监听某个端口
server.listen(port, function() {
    let address = server.address();
    Log("Server run on: http://127.0.0.1:" + address.port);
});