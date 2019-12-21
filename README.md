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

### Run blockchain and mainpage

1. Open Ganache
2. Add account to metamask

![metamask](/pictures/metamask.png)

3. Deploy smart contracts

```sh
truffle migrate
```

4. Open main page

```sh
npm run dev
```

### A test demo

#### Farmer

1. switch account to farmer
2. click actions in Insurance and Weather will get ```action denied```.
3. click actions in Farmer will go to register page (since farmer is new).
4. Then the page will jump to farmer's homepage.
5. click new claim and set a new claim and send. New claim will add to blockchain.

![new claim]()

#### Insurance

1. switch account to Insurance
2. click actions in Insurance in mainpage
3. Search claim with ```claim id = 1```. We will get the claim the farmer added just now.  

![search claim]()

#### others

We also have functions like:
1. add weather info to block
2. search weather
3. approval or reject claim
4. check status of a claim

## Future work

### functions left

- [ ] refund
- [ ] bugs
