// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "../lib/forge-std/src/Test.sol";
import {solution} from "../src/solution.sol";

contract TestSolution is Test {
    function testSolution1() external {
        solution _solution = new solution("aA", "aAAbbbb");
        _solution.occurrences();
    }

    function testSolution2() external {
        solution _solution = new solution("z", "ZZ");
        _solution.occurrences();
    }
}
