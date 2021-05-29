const HttpServer = require('./httpServer');
const Blockchain = require('./blockchain');
const Operator = require('./operator');
const Miner = require('./miner');
const Node = require('./node');

module.exports = function naivecoin(host, port, peers, logLevel, name) {
    host = process.env.HOST || host || 'localhost';
    port = process.env.PORT || process.env.HTTP_PORT || port || 3001;
    peers = (process.env.PEERS ? process.env.PEERS.split(',') : peers || []);
    peers = peers.map((peer) => { return { url: peer }; });
    logLevel = (process.env.LOG_LEVEL ? process.env.LOG_LEVEL : logLevel || 6);    
    name = process.env.NAME || name || '1';

    require('./util/consoleWrapper.js')(name, logLevel);

    console.info(`Starting node ${name}`);

    let blockchain = new Blockchain(name);
    let operator = new Operator(name, blockchain);
    let miner = new Miner(blockchain, logLevel);
    let node = new Node(host, port, peers, blockchain);
    let httpServer = new HttpServer(node, blockchain, operator, miner);

    httpServer.listen(host, port);
};

// node bin/naivecoin.js -p 3000 --name manan
// npm start -- for node 1 at port 3001
// node bin/naivecoin.js -p 3002 --name ali
// node bin/naivecoin.js -p 3003 --name hardik

//  --peers http://localhost:3001