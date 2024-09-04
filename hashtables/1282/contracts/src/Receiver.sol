pragma solidity ^0.8.0;

import {StateContract} from "./stateContract.sol";

abstract contract Receiver {
    StateContract program;

    constructor(uint[] memory groupSize) {
        program = new StateContract();
        for (uint i = 0; i < groupSize.length; i++) {
            if (i == 0) {
                program.initialize(i, groupSize[i], false);
            }
            if (i > 0 && i < groupSize.length) {
                program.work(i, groupSize[i], false);
            }
            if (i == groupSize.length) {
                program.work(i, groupSize[i], true);
            }
        }
    }
    //     function receiveGroupSize() public;

    //     function receiveGroups() public;
    // }
}
