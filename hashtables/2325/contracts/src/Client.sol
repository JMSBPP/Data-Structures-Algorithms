// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;


interface IClient {
    function sendKey(string memory key) external;
}
contract Client {
    event MessageRequest(string keys, string message);

    function sendKey(string memory key, string memory message) public {
        emit MessageRequest(key, message);
    }
}

