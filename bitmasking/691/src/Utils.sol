// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

library BytesArrayUtils {
    function removeDuplicates(
        bytes1[] memory _bytes
    ) public returns (bytes1[] memory result) {
        //toma un arreglo entero y devuelve un arreglo sin elementos duplicados
        //for each element search it in the array substracting the element taken
        bytes1[] memory _result = new bytes1[](_bytes.length);
        for (uint i = 0; i < _result.length; i++) {
            if (!searchByte(_result, _bytes[i])) {
                _result[i] = _bytes[i];
            }
        }
        result = new bytes1[](_result.length - countDuplicates(_result, 0x00));
        for (uint i = 0; i < result.length; i++) {
            if (_result[i] != 0x00) {
                result[i] = _result[i];
            }
        }
    }
    function countDuplicates(
        bytes1[] memory _bytes,
        bytes1 _value
    ) internal pure returns (uint count) {
        //toma un arreglo entero y devuelve la cantidad de elementos duplicados

        for (uint i = 0; i < _bytes.length; i++) {
            if (_bytes[i] == _value) {
                count++;
            }
        }
    }

    function searchByte(
        bytes1[] memory _bytes,
        bytes1 _value
    ) internal pure returns (bool found) {
        found = false;
        for (uint i = 0; i < _bytes.length; i++) {
            if (_bytes[i] == _value) {
                found = true;
            }
        }
    }
}

library stringUtils {
    using BytesArrayUtils for bytes1[];

    function toBytesArray(
        string memory _str
    ) public returns (bytes1[] memory encodedArray) {
        bytes memory encodedString = abi.encodePacked(_str); //encodes the string
        encodedArray = new bytes1[](encodedString.length); //put each byte in an array

        for (uint i = 0; i < encodedString.length; i++) {
            bytes1 encodedChar = bytes1(encodedString[i]);
            encodedArray[i] = encodedChar;
        }
    }

    function stringToCharArray(
        string memory _str,
        bool _removeDuplicates
    ) public returns (string[] memory result) {
        bytes memory encodedString = abi.encodePacked(_str); //encodes the string
        bytes1[] memory encodedArray = toBytesArray(_str); //put each byte in an array

        for (uint i = 0; i < encodedString.length; i++) {
            bytes1 encodedChar = bytes1(encodedString[i]);
            encodedArray[i] = encodedChar;
        }

        bytes1[] memory encodedResult = _removeDuplicates
            ? encodedArray.removeDuplicates()
            : encodedArray;
        string[] memory preResult = new string[](encodedResult.length);
        for (uint i = 0; i < encodedResult.length; i++) {
            bytes memory s = abi.encodePacked(encodedResult[i]);
            preResult[i] = string(s);
        }
        result = preResult;
    }

    function removeDuplicatesChar(
        string memory _str
    ) public returns (string memory word) {
        string[] memory arrChars = stringToCharArray({
            _str: _str,
            _removeDuplicates: true
        });
        bytes memory wordBytes;
        for (uint i = 0; i < arrChars.length; i++) {
            wordBytes = abi.encodePacked(wordBytes, arrChars[i]);
        }
        word = string(wordBytes);
    }
}

library stringArrayUtils {
    using stringUtils for string;

    function unique(
        string[] memory arrStrings
    ) public returns (string[] memory result) {
        //

        result = new string[](arrStrings.length);
        for (uint i = 0; i < arrStrings.length; i++) {
            result[i] = arrStrings[i].removeDuplicatesChar();
        }
    }

    function toBytes1(
        string[] memory arr
    ) public returns (bytes1[] memory result) {
        for (uint i = 0; i < arr.length; i++) {
            result[i] = bytes1(abi.encodePacked(arr[i]));
        }
    }
}

library queueExt {
    function slice(
        string[] memory _str
    ) public returns (string[] memory currentQueue) {
        currentQueue = new string[](_str.length - 1);
        for (uint i = 0; i < _str.length - 1; i++) {
            currentQueue[i] = _str[i + 1];
        }
    }
    function dequeue(string[] memory str) public returns (string memory word) {
        word = str[0];
        str = slice(str);
    }

    function getFirst(
        string[] memory str
    ) public view returns (string memory first) {
        first = str[0];
    }

    function enqueue(
        string[] memory str,
        string memory word
    ) public returns (string[] memory currentQueue) {
        currentQueue = new string[](str.length + 1);
        for (uint i = 0; i < str.length; i++) {
            currentQueue[i] = str[i];
        }
        currentQueue[str.length] = word;
    }
}
