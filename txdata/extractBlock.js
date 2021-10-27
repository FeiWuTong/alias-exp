// =========================
// 		require
// =========================
var Web3 = require('web3');
var fs = require('fs');

// =========================
// 		Init
// =========================
var web3 = new Web3();
// modify port <8545> to your http.port
web3.setProvider(new Web3.providers.HttpProvider("http://localhost:8545"));
var eth = web3.eth;

// =========================
// 		Main
// =========================
var block;
var blocksize;
var txs;
var logStream;
// block interval for statistics, [startB, endB]
var startB = 50;
var endB = 1050;


console.info("INFO ["+(new Date()).toLocaleString()+"]");

// output filepath <./blockStatis> can be modified
logStream = fs.createWriteStream('./blockStatis', {flags:'a'});
for (var i = startB; i <= endB; i++) {
    try {
        block = eth.getBlock(i);
        txs = block.transactions.length;
        blocksize = block.size;
        logStream.write(blocksize + " " + txs + '\n');
    }
    catch (e) {
        i--;
    }
}
logStream.end();

console.info("INFO ["+(new Date()).toLocaleString()+"]");
