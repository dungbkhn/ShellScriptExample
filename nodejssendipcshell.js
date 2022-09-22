const cp = require('child_process');
const n = cp.spawn('sh', ['testnodejsipc.sh'], {
    stdio: ['ignore', 'ignore', 'ignore', 'ipc']
});

n.on('message', (data) => {
    console.log('name: ' + data.name);
});


n.send({"message": "hello world"});

