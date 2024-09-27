// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import "../src/LinkedList.sol";

contract LinkedListTest is Test, ALinkedList {
    using NodeMethods for Node;
    LinkedList linkedList;
    Node node =
        Node({
            prev: bytes8(abi.encode(1)),
            data: bytes16(abi.encode(16)),
            next: bytes8(abi.encode(2))
        });
    function setUp() public {
        linkedList = new LinkedList();
    }

    function testNextNode() external {
        node.setNext(bytes8(abi.encode(5)));
    }
    function testGetHead() external {
        linkedList.getHead();
    }
}
