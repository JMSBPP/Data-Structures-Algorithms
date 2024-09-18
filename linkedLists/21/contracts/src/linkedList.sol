// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Registry {
    address[] nodes;

    function getNode() external view returns (address) {
        return nodes[0];
    }

    function setNode(address nodeAddress) external {
        if (nodes.length == 0) {
            nodes.push(nodeAddress);
        } else {
            for (uint8 i = uint8(nodes.length - 1); i > 0; i--) {
                nodes[i] = nodes[i - 1];
            }

            nodes[0] = nodeAddress;
        }
    }
}

contract linkedList {
    address public head;
    address currentRegistry;
    constructor(address registry) {
        currentRegistry = registry;
    }

    function pop() public returns (address) {
        (bool success, bytes memory data) = currentRegistry.call(
            abi.encodeWithSelector(bytes4(keccak256("getNode()")))
        );
        require(success, "failed to get node");
        address node = abi.decode(data, (address));
        head = node;
        return node;
    }

    function search(bytes memory data) public returns (bool) {
        address node = head;
    }
}
