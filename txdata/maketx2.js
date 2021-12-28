const Web3 = require('web3');
// modify port <8545> to your http.port
web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
eth = web3.eth;

const fs = require('fs');
// modify <path> to your input tx json filepath
const path = "./sm_transfer_ft_id1.json";

var accounts = eth.accounts;

fs.readFile(path, function(err, data) {
	if (err) {
		console.log(err);
	} else {
		var txj = data.toString();
		txj = JSON.parse(txj);
		for (var i = 0; i < txj.txs.length; i++) {
			var tx = txj.txs[i];
            if (tx.fid) {
                tx.from = accounts[0];
            }
			tx.gas = 100000
			txhash = eth.sendTransaction(tx);
			console.log(txhash);
		}
	}
});
