pragma solidity >=0.4.21 <0.6.0;

contract Insurance {

  //modifiers will be added to constrain the access.
  uint public money;
  uint public claim_counter;
  uint public farmer_counter;
  uint public weather_counter;
///////////////////////////////farmers Implementation///////////////////////////////////////////
  struct Farmer{
      uint farmerId;
      string userName;
      string pwd;
      bool isRegisterd;
      uint claim_id; //assure one farmer has only one claim;
  }

  mapping (address => Farmer) farmers;
  event farmerAdded(uint farmerid);

  //when register, add farmer information
  function addFarmer(string memory _userName, string memory _pwd) public{
    address farmer_address = msg.sender;
    farmer_counter = farmer_counter + 1;
      farmers[farmer_address] = Farmer(
          {farmerId: farmer_counter,
           userName: _userName,
           pwd: _pwd,
           isRegisterd : true,
           claim_id : 0 //initialize claim id to 0;
          });
      emit farmerAdded(farmer_counter);
  }

  //for both farmer and agent, they can check the farmers userName
  function getFarmer(address _farmerAddress) public view returns (uint id, string memory _userName){
      return (farmers[_farmerAddress].farmerId,
       farmers[_farmerAddress].userName);
  }

  //check whether is registered by address
  function isAddressRegistered() public view returns (bool registered){
      address farmer_address = msg.sender;
      return farmers[farmer_address].isRegisterd;
  }

  struct Claim{
      uint claimId;
      string crop;
      string city;
      uint time;
      uint size;
      string description;
      uint8 isProved; //0:pending, 1:proved, 2:reject
  }
  mapping (uint => Claim) claims;
  event claimAdded(uint id);

  //farmer claim a new claim
  //Only registered farmer can do it.
  function addClaim(string memory _crop, string memory _city, uint _time, uint _size, string memory _description) public{
      claim_counter = claim_counter + 1;
      require(farmers[msg.sender].isRegisterd,"Please register first");//farmer should be registered
      claims[claim_counter] = Claim(
          {claimId: claim_counter,
          crop: _crop,
          city: _city,
          time: _time,
          size: _size,
          description: _description,
          isProved: 0
          });
      farmers[msg.sender].claim_id = claim_counter; // update claim id to the farmer account.
      emit claimAdded(claim_counter);
  }

  //only for farmers to review
  function viewClaim() public view
  returns (uint _claimId,string memory _crop, string memory _city, uint time, uint size, string memory _description){
      uint id = farmers[msg.sender].claim_id;
      return(
          id,
          claims[id].crop,
          claims[id].city,
          claims[id].time,
          claims[id].size,
          claims[id].description
      );
  }
    //farmer can check the claim status
    //Only one claim for each
  function checkStatus() public view returns(string memory _isProved){
      uint id = farmers[msg.sender].claim_id;
      if(claims[id].isProved == 1){
          return "You've been Approved!";
      }else if(claims[id].isProved == 2){
          return "Sorry, your claim is rejected.";
      }else{
          return "pending";
      }
  }


///////////////////////////////Agent Implementation////////////////////////////////////////
  //agent can approve the claim or not
 //agent can check the client's claim
  /* address public agent_address= 0x14723A09ACff6D2A60DcdF7aA4AFf308FDDC160C;//set a fixed address for agent */
  address public agent_address= 0xc9f11De50aadCA2Cc013663CBD94DB367cE53A49; //set a fixed address for agent

  function isAgent() public view returns(bool _isAgent){
      address senderAddress = msg.sender;
      if(senderAddress == agent_address){
          return true;
      }
      else{
          return false;
      }

  }

  //require agent access
  function getClaim(uint _claimeId ) public view
  returns (uint _claimId,string memory _crop, string memory _city, uint time, uint size, string memory _description){
      require(msg.sender == agent_address,"You are not authorized");
      return(
          _claimeId,
          claims[_claimeId].crop,
          claims[_claimeId].city,
          claims[_claimeId].time,
          claims[_claimeId].size,
          claims[_claimeId].description
      );
  }

  //require agent approve
  function agentApprove(uint claim_id, bool _isProved) public{
      require(agent_address == msg.sender,"You are not authorized");
      if(_isProved){
          claims[claim_id].isProved = 1; //approve
      }else{
          claims[claim_id].isProved = 2; //reject
      }
  }

  //Refund to farmer. Agent call it. Need modifier.Need to be tested.
  function refund(address payable farmer) public payable{
      require(agent_address == msg.sender,"You are not authorized");
      farmer.transfer(msg.value);
  }


  //Agent can check for weather information
  function getWeather(string memory _city, uint _time) public view returns (string memory c, uint t,string memory w){
      return(weathers[_city][_time].city,
      weathers[_city][_time].time,
      weathers[_city][_time].weather);
  }

 ///////////////////////////////Weather Implementation////////////////////////////////////////

  /* address public weather_address= 0x4B0897b0513fdC7C541B6d9D7E929C4e5364D2dB;//set a fixed address for weather input */
  address public weather_address= 0xadBCF40D5F23f15a947C09dBCcA4A4e940Aa0882;//set a fixed address for weather input

  function isWeather() public view returns(bool _weather){
      address senderAddress = msg.sender;
      if(senderAddress == weather_address){
          return true;
      }
      else{
          return false;
      }
  }

  struct Weather{
      uint weatherId;
      string city;
      uint time;
      string weather;
  }

  //mapping (uint => Weather) weathers;
  mapping (string => mapping (uint => Weather)) weathers;

  //for weather data input
  //How to add all figures to blockchain, and search for the weather of a certain place and time.
  function addWeather(string memory _city, uint _time, string memory _weather) public{
      require(weather_address == msg.sender,"You are not authorized");
      weather_counter = weather_counter + 1;
      weathers[_city][_time].weatherId = weather_counter;
      weathers[_city][_time].city = _city;
      weathers[_city][_time].time = _time;
      weathers[_city][_time].weather = _weather;
  }

}
