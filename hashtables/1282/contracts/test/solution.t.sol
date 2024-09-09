// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "../lib/forge-std/src/Test.sol";
import {solution} from "../src/solution.sol";

contract solutionTest is Test {
    solution _solution;

    uint[] test1 = [3, 3, 3, 3, 3, 1, 3];

    function setUp() public {
        _solution = new solution(test1);
    }

    function testAddGroup() external {
        _solution.addGroup(3);
        _solution.addGroup(3);
        _solution.addGroup(1);
    }

    function testExistsGroup() external {
        _solution.addGroup(3);
        _solution.existsGroup(3);
    }

    function tetsGetGroup() external {
        _solution.addGroup(3);
        _solution.getGroup(3);
    }

    function testAddMember() external {
        _solution.addGroup(3);
        _solution.addGroup(3);
        _solution.addMember(3, 3);
        _solution.addMember(3, 2);
        _solution.addMember(3, 1);
        _solution.groups(3, 1);
    }
}
