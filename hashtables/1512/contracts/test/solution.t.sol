pragma solidity ^0.8.0;

import {Test} from "../lib/forge-std/src/Test.sol";
import {solution} from "../src/solution.sol";

contract testSolution is Test {
    solution _solution;
    uint[] test1 = [1, 2, 3, 1, 1, 3];
    uint[] test2 = [1, 1, 1, 1];
    uint[] test3 = [1, 2, 3];
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
