const rokuDeploy = require('roku-deploy');
const TelnetAdapter = require('roku-debug').TelnetAdapter;
require("dotenv").config();

let deployed = false;

function connect(ip) {
    const telnetSession = new TelnetAdapter(ip);
    function handleOutput(responseText) {
        console.log(responseText);
        if (match = /\[beacon.report\] \|AppExitComplete/i.exec(responseText.trim())) {
            if (deployed) {
                telnetSession.destroy();
            }
        }
    }
    telnetSession.on('console-output', handleOutput);
    telnetSession.connect();
}

function deploy(ip, password) {
    console.log(`Deploying to Roku with IP ${ip}.`)
    rokuDeploy.deploy({
        host: ip,
        password: password,
        rootDir: 'build'
    }).then(function () {
        deployed = true;
        console.log("Deployed to Roku.")
    }, function (error) {
        console.error(error);
    });
}

const ip = process.env.ROKU_IP;
const password = process.env.ROKU_PASSWORD;

if (ip == null) {
    console.log('ROKU_IP environment variable not set');
} else if (password == null) {
    console.log('ROKU_PASSWORD environment variable not set');
} else {
    connect(ip);
    deploy(ip, password);
}
