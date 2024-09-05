pragma solidity ^0.8.0;

contract solution {
    //1 Recibe un arreglo de enteros
    uint private length;
    uint[] private res;
    uint[] private _nums;

    constructor(uint[] memory nums) {
        _nums = nums;
        length = nums.length;
        uint totalZeros = 0;
        while (totalZeros < length) {
            (uint number, uint index) = getFirstElement(_nums);
            delete _nums[index];
            totalZeros++;
            _nums.push(number);
            uint counter = greaterThan(number, _nums);
            res.push(counter);
        }
    }

    function getFirstElement(
        uint[] memory nums
    ) internal pure returns (uint, uint) {
        uint index = 0;
        while (nums[index] == 0) {
            index++;
        }
        return (nums[index], index);
    }

    function greaterThan(
        uint number,
        uint[] memory nums
    ) internal pure returns (uint) {
        uint counter = 0;
        for (uint i = 0; i < nums.length; i++) {
            if (number > nums[i] && nums[i] != 0) {
                counter++;
            }
        }

        return counter;
    }

    function getRes() public view returns (uint[] memory) {
        return res;
    }
}
