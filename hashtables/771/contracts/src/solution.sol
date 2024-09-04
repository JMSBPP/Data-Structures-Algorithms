// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract solution {
    uint public occurrences;
    bytes[] private jewels;
    bytes[] private stones;

    constructor(string memory _jewels, string memory _stones) {
        jewels = iterateString(_jewels);
        stones = iterateString(_stones);
        countOccurrences();
    }

    function iterateString(
        string memory str
    ) internal pure returns (bytes[] memory) {
        bytes memory strBytes = bytes(str);
        bytes[] memory result = new bytes[](strBytes.length);

        for (uint i = 0; i < strBytes.length; i++) {
            bytes memory charBytes = new bytes(1);
            charBytes[0] = strBytes[i];
            result[i] = charBytes;
        }

        return result;
    }

    function countOccurrences() internal {
        for (uint i = 0; i < jewels.length; i++) {
            findJewel(jewels[i]);
        }
    }

    function findJewel(bytes memory jewel) internal {
        bytes32 hashJewel = keccak256(jewel);
        for (uint i = 0; i < stones.length; i++) {
            if (keccak256(stones[i]) == hashJewel) {
                occurrences += 1;
            }
        }
    }
}
