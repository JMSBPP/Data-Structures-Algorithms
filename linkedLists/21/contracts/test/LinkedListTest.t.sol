// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Registry, linkedList} from "../src/linkedList.sol";

contract LinkedListTest is Test {
    linkedList l;
    Registry registry;

    address public FAKE_NODE = makeAddr("FAKE_NODE");

    function setUp() public {
        registry = new Registry();

        l = new linkedList(address(registry));
    }

    function testSetNode() external {
        registry.setNode(FAKE_NODE);
    }

    function testPop() external {
        registry.setNode(FAKE_NODE);
        l.pop();
    }
}
