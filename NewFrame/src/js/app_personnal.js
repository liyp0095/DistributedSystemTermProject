App = {
  loading: false,
  contracts: {},

  load: async () => {
    await App.loadWeb3()
    await App.loadContract()
    await App.loadAccount()
    await App.render()
  },

  loadWeb3: async () => {
    if (typeof web3 !== 'undefined') {
      App.web3Provider = web3.currentProvider
      web3 = new Web3(web3.currentProvider)
    } else {
      window.alert("Please connect to Metamask.")
    }
    // Modern dapp browsers...
    if (window.ethereum) {
      window.web3 = new Web3(ethereum)
      try {
        // Request account access if needed
        await ethereum.enable()
        // Acccounts now exposed
        web3.eth.sendTransaction({/* ... */})
      } catch (error) {
        // User denied account access...
      }
    }
    // Legacy dapp browsers...
    else if (window.web3) {
      App.web3Provider = web3.currentProvider
      window.web3 = new Web3(web3.currentProvider)
      // Acccounts always exposed
      web3.eth.sendTransaction({/* ... */})
    }
    // Non-dapp browsers...
    else {
      console.log('Non-Ethereum browser detected. You should consider trying MetaMask!')
    }
  },

  loadAccount: async () => {
    // Set the current blockchain account
    App.account = web3.eth.accounts[0]
  },

  loadContract: async () => {
    const insurance = await $.getJSON('../Insurance.json')
    App.contracts.Insurance = TruffleContract(insurance)
    App.contracts.Insurance.setProvider(App.web3Provider)

    // $.getJSON("Insurance.json", function(insurance) {
    //   App.contracts.Insurance = TruffleContract(insurance);
    //   App.contracts.Insurance.setProvider(App.web3Provider);
    // });
  },

  render: async () => {
    $("#bt2").click(function(){
      window.location.href='newClaim.html';
    });

    App.contracts.Insurance.deployed().then(function(instance){
      $("#bt3").click(function(){
        instance.checkStatus({from:App.account}).then(function(value) {
          window.alert(value);
          // $("#claim_status").append(`<p> ${value} </p>`)
        });
      });
    });
    // App.contracts.Insurance.deployed().then(function(instance){
    //   // window.alert(instance.address);
    //   // $("#address").append(instance.address);
    //   // $("#Register").click(function(){
    //   //   var _username = $("input:text").val();
    //   //   var _password = $("input:password").val();
    //   //   instance.addFarmer(_username, _password);
    //   //   // window.alert("1");
    //   //   // window.alert(instance.money());
    //   //   // window.alert($("input:password").val());
    //   // });
    //   // instance.getFarmer(1).then(function(value) {
    //   //   window.alert(value);
    //   // });
    // });
  },

  test: async () => {
    $("#address").append("test: ... ");
  }
}



$(function() {
  // $(window).load is NOT available in jQuery 3.0
  $(window).on("load", function() {
    App.load();
  });
});
