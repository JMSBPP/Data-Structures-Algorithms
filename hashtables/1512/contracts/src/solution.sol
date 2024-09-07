//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

contract solution {
    struct iterationData {
        uint[] originalArr;
        uint[] searchableArr;
        uint index;
        uint number;
    }

    uint[][] res;

    iterationData _iterationData;

    constructor(uint[] memory _arr) {
        _iterationData.originalArr = _arr;
    }

    function getRes() public returns (uint[][] memory) {
        uint[] memory _goodNumberIndexes = new uint[](
            _iterationData.originalArr.length
        );
        for (uint i = 0; i < _iterationData.originalArr.length - 1; i++) {
            _iterationData.searchableArr = getSearchableArray(
                i,
                _iterationData.originalArr
            );
            _iterationData.index = i;
            _iterationData.number = _iterationData.originalArr[i];
            _goodNumberIndexes = goodNumberIndex(
                _iterationData.number,
                _iterationData.index,
                _iterationData.originalArr
            );
            for (uint j = 0; j < _goodNumberIndexes.length; j++) {
                if (_goodNumberIndexes[j] != 0) {
                    res.push([i, _goodNumberIndexes[j]]);
                }
            }
        }

        return res;
    }

    function getSearchableArray(
        uint index,
        uint[] memory _nums
    ) public pure returns (uint[] memory) {
        uint[] memory newArr = new uint[](_nums.length - index - 1);
        uint newIndex = index + 1;
        for (uint i = newIndex; i < _nums.length; i++) {
            newArr[i - newIndex] = _nums[i];
        }
        return newArr;
    }

    function goodNumberIndex(
        uint numb,
        uint index,
        uint[] memory arr
    ) public pure returns (uint[] memory) {
        uint[] memory _res = new uint[](arr.length);
        for (uint i = index + 1; i < arr.length; i++) {
            if (arr[i] == numb) {
                _res[i] = i;
            }
        }
        return _res;
    }
}
