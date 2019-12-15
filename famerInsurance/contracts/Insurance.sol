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

  //for both farmer and agent, they can check the farmers userName
  function getFarmer(uint _farmerId) public view returns(string memory _userName){
      return farmers[_farmerId].userName;
  }
  //agent can check the client's claim
  function getClaim(uint _claimeId ) public view 
  returns (uint _claimId,string memory _crop, string memory _city, uint time, uint size, string memory _description){
      return(
          _claimeId,
          claims[_claimeId].crop,
          claims[_claimeId].city,
          claims[_claimeId].time,
          claims[_claimeId].size,
          claims[_claimeId].description
      );
  }
  struct Claim{
      uint claimId;//should be claimid
      string crop;
      string city;
      uint time;
      uint size;
      string description;
  }
  mapping (uint => Claim) claims;
  event claimAdded(uint id);
  
  
  //farmer claim a new claim
  function addClaim(string memory _crop, string memory _city, uint _time, uint _size, string memory _description) public{
      claim_counter = claim_counter + 1;
      claims[claim_counter] = Claim(
          {claimId: claim_counter,
          crop: _crop,
          city: _city,
          time: _time,
          size: _size,
          description: _description
          });
      emit claimAdded(claim_counter);
  }

  struct Weather{
      string city;
      uint time;
      string weather;
  }

  mapping (string => string) weathers;
  event weatherAdded(string _city);
  //for weather data input
  function addWeather(string memory _city, uint _time, string memory _weather) public{
      weathers[_city] = _weather;
      emit weatherAdded(_city);
  }


  function agentProve() public returns(bool prove){

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