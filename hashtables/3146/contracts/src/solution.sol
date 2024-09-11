// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Solution {
    int res;

    constructor() {}

    function abs(int a) public pure returns (int) {
        return a < 0 ? -a : a;
    }
    function processor(string memory str1, string memory str2) public {
        res = 0;
        string[] memory arr1 = stringToArray(str1);
        string[] memory arr2 = stringToArray(str2);

        int length = arr1.length > arr2.length
            ? int(arr2.length)
            : int(arr1.length);
        int index;
        for (int i = 0; i < length; i++) {
            index = int(arr1.length) == length
                ? findIndex(arr2, arr1[uint(i)])
                : findIndex(arr1, arr2[uint(i)]);
            res += abs(index - i);
        }
    }

    function getRes() public view returns (int) {
        return res;
    }

    function stringToArray(
        string memory str
    ) public pure returns (string[] memory) {
        bytes memory b = bytes(str);
        string[] memory arr = new string[](b.length);

        for (uint i = 0; i < b.length; i++) {
            bytes memory byteHelper = new bytes(1);
            byteHelper[0] = b[i];
            arr[i] = string(byteHelper);
        }

        return arr;
    }

    function findIndex(
        string[] memory arr,
        string memory value
    ) public pure returns (int) {
        bytes memory valueBytes = bytes(value);

        // Iterate over the array
        for (uint i = 0; i < arr.length; i++) {
            // Convert the array element to bytes
            bytes memory arrElementBytes = bytes(arr[i]);

            // Compare the lengths first
            if (arrElementBytes.length != valueBytes.length) {
                continue;
            }

            // Compare byte by byte
            bool isEqual = true;
            for (uint j = 0; j < valueBytes.length; j++) {
                if (arrElementBytes[j] != valueBytes[j]) {
                    isEqual = false;
                    break;
                }
            }

            // If strings match, return the index
            if (isEqual) {
                return int(i);
            }
        }

        // Return -1 if the value is not found
        return -1;
    }
}
