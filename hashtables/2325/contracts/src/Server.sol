// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "../dependencies/reactive-smart-contract-demos/src/IReactive.sol";
import "../dependencies/reactive-smart-contract-demos/src/AbstractReactive.sol";
import "../dependencies/reactive-smart-contract-demos/src/ISystemContract.sol";
import "../dependencies/reactive-smart-contract-demos/src/AbstractCallback.sol";
import {IClient} from "./Client.sol";
import {UniqueStrings} from "./UniqueStrings.sol";
// is AbstractCallback

contract Server is UniqueStrings, AbstractCallback {
    IClient public client;

    mapping(string => string) public cipherMap;

    event Response(string decryptedMessage);
    constructor(
        address _callback_sender,
        address _client
    ) payable AbstractCallback(_callback_sender) {
        client = IClient(_client);
    }

    receive() external payable {}

    function TrimstrHandler(
        string memory str,
        bool withSpace,
        bool _removeDuplicates
    ) public returns (string[] memory) {
        bytes memory b = bytes(str);
        uint256 length = b.length;

        // Count how many characters will be in the result
        uint256 count = 0;
        for (uint256 i = 0; i < length; i++) {
            if (!withSpace) {
                if (b[i] == 0x20) {
                    continue;
                }
            }
            count++;
        }

        // Allocate the result array
        string[] memory res = new string[](count);
        uint256 resIndex = 0;

        for (uint256 i = 0; i < length; i++) {
            if (!withSpace && b[i] == 0x20) {
                continue;
            }

            bytes memory b1 = new bytes(1);
            b1[0] = b[i];
            res[resIndex] = string(b1);
            resIndex++;
        }

        if (_removeDuplicates) {
            res = removeDuplicates(res);
        }

        return res;
    }

    function cipherGen() internal returns (string[] memory) {
        return TrimstrHandler("abcdefghijklmnopqrstuvwxyz", false, true);
    }

    function getKeyMappings(string memory _key) public {
        string[] memory key = TrimstrHandler(_key, false, true);
        string[] memory cipher = cipherGen();
        uint size = key.length >= cipher.length ? cipher.length : key.length;
        cipherMap[" "] = " ";
        for (uint256 i = 0; i < size; i++) {
            cipherMap[key[i]] = cipher[i];
        }
    }

    function getKeyMapping(
        string memory key
    ) public view returns (string memory) {
        return cipherMap[key];
    }

    function revealMessage(string memory keys, string memory _message) public {
        string[] memory message = TrimstrHandler(_message, true, false);
        getKeyMappings(keys);
        bytes memory concatenatedBytes = new bytes(message.length);
        uint currentIndex = 0;

        for (uint i = 0; i < message.length; i++) {
            bytes memory strBytes = bytes(cipherMap[message[i]]);
            for (uint j = 0; j < strBytes.length; j++) {
                concatenatedBytes[currentIndex] = strBytes[j];
                currentIndex++;
            }
        }
        emit Response(string(concatenatedBytes));
    }
}
