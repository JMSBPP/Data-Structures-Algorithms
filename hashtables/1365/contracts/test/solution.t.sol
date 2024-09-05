pragma solidity ^0.8.0;

import {Test} from "../lib/forge-std/src/Test.sol";
import {solution} from "../src/solution.sol";

contract solutionTest is Test {
    solution _solution;

    uint[] test1 = [8, 1, 2, 2, 3];
    uint[] test2 = [6, 5, 4, 8];
    uint[] test3 = [7, 7, 7, 7];

    function testSolution1() external {
        _solution = new solution(test1);
        _solution.getRes();
    }
    function testSolution2() external {
        _solution = new solution(test2);
        _solution.getRes();
    }
    function testSolution3() external {
        _solution = new solution(test3);
        _solution.getRes();
    }
}
