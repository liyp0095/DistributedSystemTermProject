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
    App.contracts.Insurance.deployed().then(function(instance){
      // $("#address").append(instance.address);
      var _claim_id = 0;
      // instance.addClaim("jlfe", "232", 17393, 233, "iueu");
      $("#1111").click(function(){
        _claim_id = $("#searchClaimID").val();
        // window.alert(_claim_id);
        instance.getClaim(_claim_id, {from:App.account}).then(function(value) {
            // window.alert(value);
          $("#claimResult").append(`<p> ClaimID: \t ${value[0]} </p>`)
          $("#claimResult").append(`<p> CropType: \t ${value[1]} </p>`)
          $("#claimResult").append(`<p> City: \t ${value[2]} </p>`)
          $("#claimResult").append(`<p> Time: \t ${new Date(value[3]*1000)} </p>`)
          $("#claimResult").append(`<p> Acres: \t ${value[4]} </p>`)
          $("#claimResult").append(`<p> Desp: \t ${value[5]} </p>`)
        });
      });

      $("#2222").click(function(){
        var _city = $("#searchWeatherCity").val();
        var _time = new Date($("#searchWeatherTime").val()).getTime()/1000;

        // window.alert(_claim_id);
        instance.getWeather(_city, _time).then(function(value) {
            // window.alert(value);
          $("#weatherResult").append(`<p> City: \t ${value[0]} </p>`)
          $("#weatherResult").append(`<p> Date: \t ${new Date(value[1]*1000)} </p>`)
          $("#weatherResult").append(`<p> Weather: \t ${value[2]} </p>`)
          // $("#claimResult").append(`<p> Time: \t ${new Date(value[3]*1000)} </p>`)
          // $("#claimResult").append(`<p> Acres: \t ${value[4]} </p>`)
          // $("#claimResult").append(`<p> Desp: \t ${value[5]} </p>`)
        });
      });

      $("#approve").click(function(){
        instance.agentApprove(_claim_id, true, {from: App.account});
      });

      $("#reject").click(function(){
        instance.agentApprove(_claim_id, false, {from: App.account});
      })
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
