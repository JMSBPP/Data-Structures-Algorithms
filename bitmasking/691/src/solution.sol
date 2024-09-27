// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "./Utils.sol";

contract Solution {
    using stringUtils for string;
    using stringArrayUtils for string[];
    using queueExt for string[];
    using BytesArrayUtils for bytes1[];

    uint8 output;
    string[] stickers;
    string[] target;
    string currentSicker;

    function getOutput() public view returns (uint8) {
        return output;
    }

    function initializeParams(
        string[] memory _stickers,
        string memory _target
    ) public {
        stickers = _stickers.unique();
        target = _target.stringToCharArray(false);
    }

    function processor() public {
        uint8 counter = 0;
        uint8 maxRecursion = 0;
        while (counter < target.length && maxRecursion < stickers.length) {
            bool done = false;
            currentSicker = stickers.dequeue();
            string[] memory currentStickerArr = currentSicker.stringToCharArray(
                true
            );
            string memory currentWord;
            if (done) {
                currentWord = target.dequeue();
                counter++;
            }
            if (search(currentWord, currentStickerArr)) {
                output += 1;
                done = true;
            } else {
                stickers.enqueue(currentSicker);
                maxRecursion++;
                processor();
            }
        }
    }

    function search(
        string memory char,
        string[] memory arr
    ) public returns (bool found) {
        found = false;
        bytes1[] memory encodedArray = arr.toBytes1();
        bytes1 encodedChar = bytes1(abi.encodePacked(char));

        for (uint i = 0; i < encodedArray.length; i++) {
            if (encodedArray[i] == encodedChar) {
                found = true;
            }
        }
    }
}
