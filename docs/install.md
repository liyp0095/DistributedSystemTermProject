
## How to run dapp

### Install dependency

- nodejs: https://nodejs.org/en/
  - install node manager nvm https://github.com/nvm-sh/nvm, or may meet permission issue when ```npm install -g```
  - ```nvm ls```
  - You do **not** need to remove your current version of npm or Node.js before installing a node version manager.


- truffle: (framework) https://www.trufflesuite.com/truffle
  - ```npm install truffle -g```
- Ganache: (local blockchain) https://www.trufflesuite.com/ganache
  - just download and run ...
- MetaMask (extension made chrome connect to blockchain) https://metamask.io/

**apm issue with not find npm**
```sh
$ cd /Applications/Atom.app/Contents/Resources/app/node_modules/atom-package-manager/
$ npm install npm@latest
```

## begin to code

### first test

- version 0.50 has a big difference from before. So determine a version before.
- truffle console

```sh
Election.deployed().then(function(i) { app=i; })

truffle(development)> candidate["id"]
BN { negative: 0, words: [ 1, <1 empty item> ], length: 1, red: null }
truffle(development)>
undefined
truffle(development)>
undefined
truffle(development)> candidate[0]
BN { negative: 0, words: [ 1, <1 empty item> ], length: 1, red: null }
truffle(development)>
undefined
truffle(development)> candidate[1]
'Candidate 1'
truffle(development)> candidate[2]
BN { negative: 0, words: [ 0, <1 empty item> ], length: 1, red: null }
truffle(development)> candidate[2].toNumber()
0
```

## code

https://github.com/dappuniversity/election
