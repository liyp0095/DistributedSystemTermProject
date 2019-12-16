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
  },

  render: async () => {

    // window.alert("1");
    // window.alert("1");
    // Load account data
    web3.eth.getCoinbase(function(err, account) {
      if (err === null) {
        App.account = account;
        $("#accountAddress").html("Your Account: " + account);
      }
    });

    App.contracts.Insurance.deployed().then(function(instance){
      // instance.addFarmer("123", "fjljg");
      $("#farm").click(function(){
        instance.isAddressRegistered({from: App.acount}).then(function(value) {
          if(value) {
            window.location.href='html/personalPage.html';
          }else {
            window.location.href='html/login.html';
          }
        });
      });

      $("#agent").click(function(){
        instance.isAgent({from: App.acount}).then(function(value) {
          if(value) {
            window.location.href='html/agent.html';
          }else {
            window.alert('Action Denied! \n You are not a Insurance Agent!');
          }
        });
      });

      $("#weather").click(function(){
        instance.isWeather({from: App.acount}).then(function(value) {
          if(value) {
            window.location.href='html/personalPage.html';
          }else {
            window.alert("Action Denied! \n You are not a Weather Agent!")
          }
        });
      });

      // window.alert(instance.address);
      // $("#address").append(instance.address);
      // $("#Register").click(function(){
      //   var _username = $("input:text").val();
      //   var _password = $("input:password").val();
      //   instance.addFarmer(_username, _password);
      //   // window.alert(instance.money());
      //   // window.alert($("input:password").val());
      // });
      // instance.getFarmer(1).then(function(value) {
      //   // window.alert(value);
      // });
    });
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
