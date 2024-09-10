// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UniqueStrings {
    // Storage mapping to keep track of seen strings
    mapping(bytes32 => bool) private seenMap;

    // Function to remove duplicates from an array of strings
    function removeDuplicates(
        string[] memory inputArray
    ) internal returns (string[] memory) {
        // Reset the storage mapping
        for (uint256 i = 0; i < inputArray.length; i++) {
            bytes32 hash = keccak256(abi.encodePacked(inputArray[i]));
            seenMap[hash] = false;
        }

        uint256 uniqueCount = 0;

        for (uint256 i = 0; i < inputArray.length; i++) {
            bytes32 hash = keccak256(abi.encodePacked(inputArray[i]));
            if (!seenMap[hash]) {
                seenMap[hash] = true;
                uniqueCount++;
            }
        }

        // Create the array to hold unique strings
        string[] memory uniqueArray = new string[](uniqueCount);
        uint256 index = 0;

        // Second pass to populate the unique array
        for (uint256 i = 0; i < inputArray.length; i++) {
            bytes32 hash = keccak256(abi.encodePacked(inputArray[i]));
            if (seenMap[hash]) {
                uniqueArray[index] = inputArray[i];
                seenMap[hash] = false; // Prevent duplicate entries in the unique array
                index++;
            }
        }

        return uniqueArray;
    }
}
