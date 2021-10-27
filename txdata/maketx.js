const Web3 = require('web3');
// modify port <8545> to your http.port
web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
eth = web3.eth;

const fs = require('fs');
// modify <path> to your input tx json filepath
const path = "./txs_id.json";

var accounts = eth.accounts;

// unlock all accounts, can be ignored when only one account are used to make transactions
/*
for (var i = 0; i < accounts.length; i++) {
	web3.personal.unlockAccount(accounts[i], '123');
}
*/

fs.readFile(path, function(err, data) {
	if (err) {
		console.log(err);
	} else {
		var txj = data.toString();
		txj = JSON.parse(txj);
		for (var i = 0; i < txj.txs.length; i++) {
			/* ignored when tx maker is unlocked by booting parameter --unlock
			if (i % 500 == 0) {
				web3.personal.unlockAccount(accounts[0], '123');
			}
			*/
			var tx = txj.txs[i];
			tx.from = accounts[tx.from];
			tx.gas = 110000
			txhash = eth.sendTransaction(tx);
			console.log(txhash);
		}
	}
});

/* other test
tx = {
	from: accounts[0],
	id: "0x1111",
	value: 0,
}
txhash = eth.sendTransaction(tx);
console.log(txhash);
txhash = eth.sendTransaction(tx);
console.log(txhash);
txhash = eth.sendTransaction(tx);
console.log(txhash);
*/
