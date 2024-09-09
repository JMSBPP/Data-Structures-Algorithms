// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "../dependencies/reactive-smart-contract-demos/src/IReactive.sol";
import "../dependencies/reactive-smart-contract-demos/src/AbstractReactive.sol";
import "../dependencies/reactive-smart-contract-demos/src/ISystemContract.sol";
import "../dependencies/reactive-smart-contract-demos/src/AbstractCallback.sol";

interface IClient {
    function sendKey(string memory key) external;
}
contract Client {
    event MessageSent(bytes encodedKey, bytes encodedMessage);

    function sendKey(string memory key, string memory message) public {
        emit MessageSent(abi.encodePacked(key), abi.encodePacked(message));
    }
}

// is AbstractCallback
contract Server {
    IClient public client;
    mapping(string => string) private cipherMap;

    event Response(string message);
    // constructor(
    //     address _callback_sender,
    //     address _client
    // ) payable AbstractCallback(_callback_sender) {
    //     client = IClient(_client);
    // }

    receive() external payable {}
    function strHandler(
        string memory str
    ) internal pure returns (string[] memory) {
        bytes memory b = bytes(str);
        string[] memory res = new string[](b.length);
        for (uint256 i = 0; i < b.length; i++) {
            bytes memory b1 = new bytes(1);
            b1[0] = b[i];
            res[i] = string(b1);
        }

        return res;
    }

    function cipherGen() internal pure returns (string[] memory) {
        return strHandler("abcdefghijklmnopqrstuvwxyz");
    }

    function getKeyMappings(bytes memory encodedKey) internal {
        string memory _key = abi.decode(encodedKey, (string));
        string[] memory key = strHandler(_key);
        string[] memory cipher = cipherGen();

        for (uint256 i = 0; i < key.length; i++) {
            cipherMap[key[i]] = cipher[i];
        }
    }

    function revealMessage(
        bytes memory encodedKeys,
        bytes memory _message_
    ) public {
        string memory message = abi.decode(_message_, (string));
        getKeyMappings(encodedKeys);
        string[] memory _message = strHandler(message);
        bytes memory concatenatedBytes = new bytes(_message.length);
        uint currentIndex = 0;
        // Append each string to the concatenatedBytes array
        for (uint i = 0; i < _message.length; i++) {
            bytes memory strBytes = bytes(cipherMap[_message[i]]);
            for (uint j = 0; j < strBytes.length; j++) {
                concatenatedBytes[currentIndex] = strBytes[j];
                currentIndex++;
            }
        }
        emit Response(string(concatenatedBytes));
    }
}

// contract API is IReactive, AbstractReactive {
//     uint256 private constant SEPOLIA_CHAIN_ID = 11155111;

//     receive() external payable {}
// }
