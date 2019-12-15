pragma solidity ^0.5.0;
contract Insurance {

  uint money;
  uint claim_counter;
  uint farmer_counter;

  struct Farmer{
      uint farmerId;
      string userName;
      string pwd;
  }

  mapping (uint => Farmer) farmers;
  event farmerAdded(uint farmerid);

  //when register, add farmer information
  function addFarmer(string memory _userName, string memory _pwd) public{
    farmer_counter = farmer_counter + 1;
      farmers[farmer_counter] = Farmer(
          {farmerId: farmer_counter,
           userName: _userName,
           pwd: _pwd
          });
      emit farmerAdded(farmer_counter);
  }

  struct Claim{
      uint farmId;//should be claimid
      string city;
      uint time;
      string description;
      bool isRefundable;
      bool isProved;
  }
  mapping (uint => Claim) claims;
  event claimAdded(uint id);

  function addClaim(string memory _city, uint _time, string memory _description) public{
      claim_counter = claim_counter + 1;
      claims[claim_counter] = Claim(
          {farmId: claim_counter,
          city: _city,
          time: _time,
          description: _description,
          isRefundable: false,
          isProved : false
          });
      emit claimAdded(claim_counter);
  }

  struct Weather{
      string city;
      uint time;
      uint level;
  }

  mapping (string => uint) weathers;
  event weatherAdded(string _city);
  function addWeather(string memory _city, uint _time, uint _level) public{
      weathers[_city] = _level;
      emit weatherAdded(_city);
  }

  function isRefundable() public returns(bool isRefund){
      //todo
      return true;
  }

  function refund() public view returns(uint _refund){
      //todo
      return 100;


  }


}