// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Client} from "../src/Client.sol";
import {Server} from "../src/Server.sol";
import {Script} from "../lib/forge-std/src/Script.sol";

contract DeployClient is Script {
    Client public client;

    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

    function run() external {
        vm.startBroadcast(deployerPrivateKey);

        client = new Client();

        vm.stopBroadcast();
    }
}

contract DeployServer is Script {
    Server public server;
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
    address client = vm.envAddress("ORIGIN_ADDR");

    function run() external {
        vm.startBroadcast(deployerPrivateKey);

        server = new Server(client);

        vm.stopBroadcast();
    }
}

// uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
// uint256 topic0 =
// uint256(
//     keccak256(abi.encodePacked("MessageRequest(string,string)"))
// );
// address service = vm.envAddress("SYSTEM_CONTRACT_ADD");
// address origin = vm.envAddress("ORIGIN_ADDR");
// address destination = vm.envAddress("CALLBACK_ADDR");
