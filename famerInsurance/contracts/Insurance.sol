pragma solidity ^0.5.0;

contract Insurance {
  bool is_Refund = false;
  int refund = 5000;

  function getRefund() public view  returns (int ret) {
    return refund;
  }

  function isRefund() public view returns (bool ret){
    return is_Refund;
  }

}
