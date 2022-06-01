const HDWalletProvider = require('truffle-hdwallet-provider');
// organizer='screen,canvas,chat,door,mutual,someone,weasel,banana,hair,radio,october,piece';
privatekey = ''// 비밀이지롱:

module.exports = {
  networks: {
    ropsten: {
provider: () => new HDWalletProvider(privatekey, 'https://ropsten.infura.io/v3/...'),
      network_id: 3,       
      gas: 1000000,       
      skipDryRun: true
    },
    development: {
      host: "localhost",
      port: 7545,
      network_id: "*" // Match any network id
    }
  },

  compilers: {
    solc: {
       version: "0.5.8"
    }
  }
};
