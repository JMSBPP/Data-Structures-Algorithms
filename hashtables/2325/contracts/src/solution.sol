// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;
import "../dependencies/reactive-smart-contract-demos/src/IReactive.sol";
import "../dependencies/reactive-smart-contract-demos/src/AbstractReactive.sol";
import "../dependencies/reactive-smart-contract-demos/src/ISystemContract.sol";
import "../dependencies/reactive-smart-contract-demos/src/AbstractCallback.sol";

interface IClient {
    function sendKey(string memory key) external;
}
contract Client {
    event MessageRequest(string keys, string message);

    function sendKey(string memory key, string memory message) public {
        emit MessageRequest(key, message);
    }
}

// is AbstractCallback
contract Server {
    IClient public client;
    mapping(string => string) public cipherMap;

    event Response(string message);
    // constructor(
    //     address _callback_sender,
    //     address _client
    // ) payable AbstractCallback(_callback_sender) {
    //     client = IClient(_client);
    // }

    receive() external payable {}
    function alreadyAdded(
        bytes1 _byte,
        bytes memory byteArray
    ) internal pure returns (bool) {
        for (uint256 i = 0; i < byteArray.length; i++) {
            if (byteArray[i] == _byte) {
                return true;
            }
        }
        return false;
    }
    function TrimstrHandler(
        string memory str
    ) public pure returns (string[] memory) {
        bytes memory b = bytes(str);
        string[] memory res = new string[](b.length);
        for (uint256 i = 0; i < b.length; i++) {
            bytes memory b1 = new bytes(1);
            b1[0] = b[i];
            if (b1[0] != 0x20 && !alreadyAdded(b1[0], b)) {
                res[i] = string(b1);
            }
        }

        return res;
    }

    //     function cipherGen() internal pure returns (string[] memory) {
    //         return TrimstrHandler("abcdefghijklmnopqrstuvwxyz");
    //     }

    //     function getKeyMappings(string memory _key) public {
    //         string[] memory key = TrimstrHandler(_key);
    //         string[] memory cipher = cipherGen();
    //         uint size = key.length >= cipher.length ? cipher.length : key.length;
    //         cipherMap[" "] = " ";
    //         for (uint256 i = 0; i < size; i++) {
    //             cipherMap[key[i]] = cipher[i];
    //         }
    //     }

    //     function getKeyMapping(
    //         string memory key
    //     ) public view returns (string memory) {
    //         return cipherMap[key];
    //     }

    //     function revealMessage(string memory keys, string memory _message) public {
    //         string[] memory message = TrimstrHandler(_message);
    //         getKeyMappings(keys);
    //         bytes memory concatenatedBytes = new bytes(message.length);
    //         uint currentIndex = 0;

    //         // Append each string to the concatenatedBytes array
    //         for (uint i = 0; i < message.length; i++) {
    //             bytes memory strBytes = bytes(cipherMap[message[i]]);
    //             for (uint j = 0; j < strBytes.length; j++) {
    //                 concatenatedBytes[currentIndex] = strBytes[j];
    //                 currentIndex++;
    //             }
    //         }
    //         emit Response(string(concatenatedBytes));
    //     }
    // }

    // contract API is IReactive, AbstractReactive {
    //     uint256 private constant SEPOLIA_CHAIN_ID = 11155111;

    //     receive() external payable {}
    // }
}
