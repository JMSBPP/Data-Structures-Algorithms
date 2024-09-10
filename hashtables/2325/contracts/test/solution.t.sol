// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "../lib/forge-std/src/Test.sol";
import {Server} from "../src/Server.sol";
import {Client} from "../src/Client.sol";
import "../lib/forge-std/src/console.sol";
contract SolutionUnitTest is Test {
    Server server;
    Client client;

    address fakeClientAddress = makeAddr("fakeClient");
    function setUp() public {
        server = new Server(fakeClientAddress);
        client = new Client();
    }

    function testClientMessage() external {
        client.sendKey(
            "the quick brown fox jumps over the lazy dog",
            "vkbs bs t suepuv"
        );

        client.sendKey(
            "eljuxhpwnyrdgtqkviszcfmabo",
            "zwx hnfx lqantp mnoeius ycgk vcnjrdb"
        );
    }

    function testTrimstrHandler() external {
        server.TrimstrHandler("tta tta tta", false, true);
        server.TrimstrHandler("tta tta tta", true, true);
        server.TrimstrHandler("tta tta tta", false, false);
        server.TrimstrHandler("tta tta tta", true, false);
    }

    function testGetKeyMappings() external {
        string memory keys = "the quick brown fox jumps over the lazy dog";
        server.getKeyMappings(keys);
        server.getKeyMapping("t");
        server.getKeyMapping("h");
        server.getKeyMapping("e");
        server.getKeyMapping(" ");
        server.getKeyMapping("q");
        server.getKeyMapping("u");
        server.getKeyMapping("i");
        server.getKeyMapping("c");
        server.getKeyMapping("k");
        server.getKeyMapping(" ");
        server.getKeyMapping("b");
        server.getKeyMapping("r");
    }

    function testServerMessage1() external {
        string memory message = "vkbs bs t suepuv";
        string memory keys = "the quick brown fox jumps over the lazy dog";
        server.revealMessage(fakeClientAddress, keys, message);
    }

    function testServerMessge2() external {
        string memory message = "zwx hnfx lqantp mnoeius ycgk vcnjrdb";
        string memory keys = "eljuxhpwnyrdgtqkviszcfmabo";
        server.revealMessage(fakeClientAddress, keys, message);
    }
}
