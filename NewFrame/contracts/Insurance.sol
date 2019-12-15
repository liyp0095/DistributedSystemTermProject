pragma solidity >=0.4.21 <0.6.0;

contract Insurance {
  /* struct Farmer {
    uint farmerId;
    string userName;
    string pwd;
  } */

  string public candidate;

  constructor() public {
    candidate = "test1";
  }
}
