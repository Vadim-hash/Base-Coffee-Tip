// SPDX-License-Identifier: MIT
pragma solidity 0.8.37;

interface IBaseCoffee {
    function buyCoffee(string calldata message, string calldata name) external payable;
    function withdrawTips() external;
}
