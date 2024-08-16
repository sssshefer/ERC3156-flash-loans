# ERC3156 Flash Loans

This project showcases the implementation of ERC3156 flash loans using Solidity. Flash loans are a type of loan that must be borrowed and repaid within a single transaction. This allows for risk-free loan borrowing and ensures atomicity of transactions. This project is intended for educational purposes and does not guarantee full security in real blockchain environments. It is recommended to use audited contracts in production for safety and reliability.

## Table of Contents
- [Introduction](#erc3156-flash-loans)
- [Theory Notes](#theory-notes)
  - [Transaction Errors and Reversals](#transaction-errors-and-reversals)
  - [Utility and Profitability of Flash Loans](#utility-and-profitability-of-flash-loans)
- [Features and Functionality](#features-and-functionality)
- [Implementation](#implementation)
  - [Contract Overview](#contract-overview)
  - [Tests](#tests)
- [Running the Project Locally](#running-the-project-locally)

## Theory Notes

### Transaction Errors and Reversals
In blockchain transactions, if an error occurs, all previous actions within the same transaction are rolled back. This ensures that the state of the blockchain remains consistent and no partial transaction is recorded.

### Utility and Profitability of Flash Loans
Flash loans provide the opportunity to borrow large sums of money without collateral for a very short period. This can be profitable when executing arbitrage opportunities, collateral swaps, or refinancing within a single transaction. The brief duration does not diminish profitability as long as the loan is repaid within the same transaction block.

## Features and Functionality
- **Flash Loan Offering**: Enables users to borrow tokens without collateral as long as the loan and fees are returned within the same transaction.
- **Fee Calculation**: The contract calculates a small fee for borrowing the tokens, which is essential for incentivizing liquidity providers.
- **Error Handling**: Robust mechanisms to handle transaction errors and ensure all actions are canceled in case of failure.

## Implementation

### Contract Overview
The contracts implemented in this project include:
- **ERC20FlashMint**: An extension of the ERC20 standard that implements the IERC3156FlashLender interface, allowing the minting and burning of tokens for flash loans.
- **FlashBorrower**: A test contract that interacts with the flash lender to initiate and handle the flash loan process.
- **ShefToken**: A custom ERC20 token that supports flash minting, used to demonstrate the functionality of flash loans.

### Tests
The project includes comprehensive tests to ensure the correct implementation of flash loan mechanics, error handling, and fee calculations. These tests can be found in the `FlashBorrower.test.ts` file.

## Running the Project Locally

To run this project locally, follow these steps:

1. **Clone the Repository**:
    ```bash
    git clone https://github.com/sssshefer/ERC3156-flash-loans.git
    cd ERC3156-flash-loans
    ```

2. **Install Dependencies**:
    ```bash
    npm install
    ```

3. **Compile Contracts**:
    ```bash
    npx hardhat compile
    ```

4. **Run Tests**:
    ```bash
    npx hardhat test
    ```
<a href="https://ru.freepik.com/free-vector/flat-design-nft-concept-illustration_13862491.htm#fromView=search&page=1&position=33&uuid=b0eab404-da8d-46b7-8df6-84d90b7209cd">The pic is from freepik</a>

***Happy hacking***
