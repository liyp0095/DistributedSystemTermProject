pragma solidity ^0.5.0;

contract TestingFunction {
  bool is_Refund = false;//for testing
  int refund = 5000;//for testing

  //for testing
  function getRefund() public view  returns (int ret) {
    return refund;
  }

  function isRefund() public view returns (bool ret){
    return is_Refund;
  }

}
