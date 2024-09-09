// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "../lib/forge-std/src/Test.sol";
import {Server, Client} from "../src/solution.sol";

contract SolutionTest is Test {
    Server server;
    Client client;

    function setUp() public {
        server = new Server();
        client = new Client();
    }

    function testClientMessage() external {
        client.sendKey(
            "the quick brown fox jumps over the lazy dog",
            "vkbs bs t suepuv"
        );
    }

    function testServerMessage() external {
        bytes memory encodedMessage = abi.encodePacked("vkbs bs t suepuv");
        bytes memory encodedKey = abi.encodePacked(
            "the quick brown fox jumps over the lazy dog"
        );
        server.revealMessage(encodedKey, encodedMessage);
    }
}
