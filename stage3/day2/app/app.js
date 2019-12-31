// 导入express
const express = require("express");

// 初始化express
const app = express();

const api = '/api/fe/list'

// get方法，匹配path为/api/fe/list
app.get(api, function (req, res) {
    console.log('request path:' + req.path);
    var result = {
        code: 200,
        msg: "success",
        data: {
            "name": "app",
            "desc": "stage3 day2"
        }
    }

    // 返回响应json
    res.json(result);
});

// 监听8888端口
app.listen(8888);

// 在浏览器访问http://127.0.0.1:8888/api/fe/list
console.log('app start: http://127.0.0.1:8888'+api);