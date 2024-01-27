# Voting System Smart Contract

This repository contains a Solidity smart contract for a blockchain-based voting system. The contract allows for the nomination of candidates, voting by eligible voters, and the calculation of the winning candidate based on vote count. It is designed for deployment on the Ethereum blockchain.

## Features

- Nomination of candidates by the chairperson within a specified timeframe.
- Voting mechanism for eligible voters.
- Calculation of the winning candidate based on vote count.
- Time-limited actions for nomination and voting.

## Requirements

To deploy and interact with this smart contract, you will need:

- An Ethereum wallet with ETH for contract deployment (e.g., MetaMask).
- A Solidity compiler (e.g., Remix IDE, Truffle, or Hardhat) for compiling and deploying the contract.
- Ethereum testnet or mainnet for deploying the contract.

## Installation

1. Clone this repository or download the contract file (`Voting_System.sol`).
2. Open the file using a Solidity development environment (like Remix IDE).
3. Compile the contract using the Solidity compiler.
4. Deploy the contract to an Ethereum testnet or mainnet using your Ethereum wallet.

## Usage

### Deployment

The constructor requires an array of addresses representing eligible voters.

Example of eligible voters array:
```javascript
["0x5B38Da6a701c568545dCfcB03FcB875f56beddC4", ...]
```

### Functions

- `nomination_file(bytes32 proposalNames)`: Allows the chairperson to file a nomination. This function can only be called by the chairperson and within the nomination period.
- `time_left()`: Returns the remaining time in seconds for nominations.
- `Voting_Time_left()`: Returns the remaining time in seconds for voting.
- `vote(uint256 proposal)`: Enables an eligible voter to vote for a nominee. Voting is only allowed after the nomination period and within the voting period.
- `winningProposal()`: Returns the index of the winning proposal. Can be called after the voting period ends.
- `winnerName()`: Returns the name of the winning nominee in string format.

### Access Control

- The contract distinguishes between the chairperson and regular voters.
- Only the chairperson can file nominations and access the winning proposal information.

## Contributing

Contributions to this project are welcome. Please ensure that your code adheres to the project's coding standards and include tests for new features or bug fixes.

## License

This project is licensed under the GPL-3.0 license - see the [LICENSE](LICENSE) file for details.

## Disclaimer

This project is for educational purposes only. Please ensure thorough testing and auditing before using this contract in a production environment.
