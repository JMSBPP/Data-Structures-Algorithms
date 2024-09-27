// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import {Test, console} from "../lib/forge-std/src/Test.sol";
import "../src/Utils.sol";
import "../src/solution.sol";

contract Tests is Test {
    using stringUtils for string;
    using BytesArrayUtils for bytes1[];
    using stringArrayUtils for string[];
    using queueExt for string[];

    Solution solution;
    function setUp() public {
        solution = new Solution();
    }

    function testTestCase1() external {
        string[] memory stickers = new string[](3);
        stickers[0] = "whit";
        stickers[1] = "example";
        stickers[2] = "science";
        string memory target = "thehat";
        solution.initializeParams(stickers, target);
        solution.processor();
    }

    function testStringToBytes() external returns (string[] memory result) {
        string memory _str = "thehat";
        result = _str.stringToCharArray(false);
    }

    function testUnique() external returns (string[] memory result) {
        string[] memory input = new string[](3);
        input[0] = "white";
        input[1] = "example";
        input[2] = "science";
        result = stringArrayUtils.unique(input);
    }

    function testRemoveDuplicates() external returns (string memory result) {
        string[] memory input = new string[](3);
        input[0] = "white";
        input[1] = "example";
        input[2] = "science";
        string[] memory _result = stringArrayUtils.unique(input);
        result = _result.dequeue();
    }

    function testFormatting() external returns (string[] memory result) {
        string memory word = "white";
        result = word.stringToCharArray(false);
    }

    function testEnqueue() external returns (string[] memory result) {
        string[] memory input = new string[](3);
        input[0] = "white";
        input[1] = "example";
        input[2] = "science";
        result = input.enqueue("hat");
    }
}
