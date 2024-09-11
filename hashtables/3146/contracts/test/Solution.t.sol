// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "../lib/forge-std/src/Test.sol";
import {Solution} from "../src/solution.sol";

contract solutionTest is Test {
    Solution solution;
    function setUp() external {
        solution = new Solution();
    }

    function teststringToArray(string memory str) public {
        string[] memory arr = solution.stringToArray(str);
    }

    function testfindIndex() external {
        string[] memory testStr = solution.stringToArray("abc");
        solution.findIndex(testStr, "b");
    }

    function testSolution1() external {
        string memory test11 = "abc";
        string memory test12 = "bac";
        string memory test21 = "abcde";
        string memory test22 = "edbac";
        solution.processor(test11, test12);
        solution.getRes();
        solution.processor(test21, test22);
        solution.getRes();
    }

    //s = "abcde", t = "edbac"
}
