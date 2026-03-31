const { exec } = require('child_process');
const path = require('path');
const fs = require('fs');
const http = require('http');
const os = require('os');

const scriptDir = __dirname;
const htmlPath = path.join(scriptDir, 'index.html');
const port = 8765;

function getLocalIP() {
    const interfaces = os.networkInterfaces();
    for (const name of Object.keys(interfaces)) {
        for (const iface of interfaces[name]) {
            if (iface.family === 'IPv4' && !iface.internal) {
                return iface.address;
            }
        }
    }
    return 'localhost';
}

const server = http.createServer((req, res) => {
    const html = fs.readFileSync(htmlPath, 'utf-8');
    res.writeHead(200, { 'Content-Type': 'text/html; charset=utf-8' });
    res.end(html);
});

// Listen on all interfaces so phone can access
server.listen(port, '0.0.0.0', () => {
    const localIP = getLocalIP();
    const url = `http://localhost:${port}`;
    const networkUrl = `http://${localIP}:${port}`;
    
    console.log(`工作日志系统已启动！`);
    console.log(`本机访问: ${url}`);
    console.log(`手机访问: ${networkUrl}`);
    
    // Try Chrome first
    const chromePath = 'C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe';
    
    exec(`"${chromePath}" --app=${url} --window-size=1200,800 --disable-infobars`, (error) => {
        if (error) {
            // Try Edge
            const edgePath = 'C:\\Program Files (x86)\\Microsoft\\Edge\\Application\\msedge.exe';
            exec(`"${edgePath}" --app=${url} --window-size=1200,800 --disable-infobars`);
        }
    });
});

process.on('SIGINT', () => {
    server.close();
    process.exit();
});
