# Distributed System

This the term project of CS552 operating system, 2019 Fall. The term member includes

- Jingqiao Xu
- Jieyun Hu
- Yuepei Li

## How to run?

### Dependency

```sh
(base) ➜  ~ npm -v
6.13.1

(base) ➜  ~ node -v
v13.3.0

(base) ➜  ~ truffle version
Truffle v5.1.4 (core: 5.1.4)
Solidity v0.5.12 (solc-js)
Node v13.3.0
Web3.js v1.2.1

```

Need [Ganache](https://www.trufflesuite.com/ganache) and [MetaMask](https://metamask.io/).

### How I install

See how I install these at https://github.com/liyp0095/DistributedSystemTermProject/blob/master/docs/install.md

### First time run

```sh
# install nodejs dependency
cd $ProjectFolder
npm install
```

## Demo

### Add address to weateher and agent

We fixed the address for weather and Insurance. So open ganache and get two addresses setting to FarmerInsurance/contracts/Insurance.sol
```
address public weather_address= 0xadBCF40D5F23f15a947C09dBCcA4A4e940Aa0882;//set a fixed address for weather input
address public agent_address= 0xc9f11De50aadCA2Cc013663CBD94DB367cE53A49; //set a fixed address for agent
```
