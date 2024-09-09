// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "../lib/forge-std/src/Test.sol";
import {Server, Client} from "../src/solution.sol";
import "../lib/forge-std/src/console.sol";
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

    function testTrimstrHandler() external {
        server.TrimstrHandler("tta");
    }

    // function testGetKeyMappings() external {
    //     string memory keys = "the quick brown fox jumps over the lazy dog";
    //     server.getKeyMappings(keys);
    //     server.getKeyMapping("t");
    //     server.getKeyMapping("h");
    //     server.getKeyMapping("e");
    //     server.getKeyMapping(" ");
    //     server.getKeyMapping("q");
    //     server.getKeyMapping("u");
    //     server.getKeyMapping("i");
    //     server.getKeyMapping("c");
    //     server.getKeyMapping("k");
    //     server.getKeyMapping(" ");
    //     server.getKeyMapping("b");
    //     server.getKeyMapping("r");
    // }

    // function testServerMessage() external {
    //     string memory message = "vkbs bs t suepuv";
    //     string memory keys = "the quick brown fox jumps over the lazy dog";
    //     server.revealMessage(keys, message);
    // }
}
