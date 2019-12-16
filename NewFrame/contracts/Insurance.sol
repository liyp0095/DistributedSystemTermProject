pragma solidity >=0.4.21 <0.6.0;

contract Insurance {

  //modifiers will be added to constrain the access.
  uint public money;
  uint claim_counter;
  uint farmer_counter;

///////////////////////////////farmers Implementation///////////////////////////////////////////
  struct Farmer{
      uint farmerId;
      string userName;
      string pwd;
      bool isRegisterd;
  }

  mapping (address => Farmer) farmers;
  event farmerAdded(uint farmerid);

  constructor() public {
    money = 10;
  }

  //when register, add farmer information
  function addFarmer(string memory _userName, string memory _pwd) public{
    address farmer_address = msg.sender;
    farmer_counter = farmer_counter + 1;
      farmers[farmer_address] = Farmer(
          {farmerId: farmer_counter,
           userName: _userName,
           pwd: _pwd,
           isRegisterd : true
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
      emit claimAdded(claim_counter);
  }
    //farmer can check the claim status
  function checkStatus(uint claim_id) public view returns(string memory _isProved){
      if(claims[claim_id].isProved == 1){
          return "You've been Approved!";
      }else if(claims[claim_id].isProved == 2){
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

  function getClaim(uint _claimeId ) public view
  returns (uint _claimId,string memory _crop, string memory _city, uint time, uint size, string memory _description){
      require(agent_address == msg.sender,"You are not authorized");
      return(
          _claimeId,
          claims[_claimeId].crop,
          claims[_claimeId].city,
          claims[_claimeId].time,
          claims[_claimeId].size,
          claims[_claimeId].description
      );
  }

  function agentApprove(uint claim_id, bool _isProved) public{
      if(_isProved){
          claims[claim_id].isProved = 1; //approve
      }else{
          claims[claim_id].isProved = 2; //reject
      }
  }

  //Refund to farmer. Agent call it. Need modifier.Need to be tested.
  function refund(address payable farmer) public payable{
      farmer.transfer(msg.value);
  }

 ///////////////////////////////Weather Implementation////////////////////////////////////////

  address public weather_address= 0x4B0897b0513fdC7C541B6d9D7E929C4e5364D2dB;//set a fixed address for weather input

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
      string city;
      uint time;
      string weather;
  }

  mapping (string => string) weathers;
  event weatherAdded(string _city);
  //for weather data input
  //How to add all figures to blockchain, and search for the weather of a certain place and time.
  function addWeather(string memory _city, uint _time, string memory _weather) public{
      require(weather_address == msg.sender,"You are not authorized");
      weathers[_city] = _weather;
      emit weatherAdded(_city);
  }
}
