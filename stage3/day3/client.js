const http = require('http');

const option = {
    host: '127.0.0.1',
    port: 8888,
    path: '/api/fe/list',
    method: 'GET',
    protocol: 'http:',
    timeout: 1000
};

const req = http.request(option, function (res) {
    console.log(`STATUS: ${res.statusCode}`);
    console.log(`HEADERS: ${JSON.stringify(res.headers)}`);
    res.setEncoding('utf8');
    // 响应数据
    res.on('data', (chunk) => {
        console.log(`BODY: ${chunk}`);
    });
    // 响应结束
    res.on('end', () =>  {
        console.log('No more data in response.');
    });
});

req.on('error', function(err) {
    console.error(`problem with request: ${err.message}`);
});

req.end();