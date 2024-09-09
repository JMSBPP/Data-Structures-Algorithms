// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract solution {
    uint[] public groupSizes;

    struct Group {
        uint availSlots;
        uint[] members;
    }

    mapping(uint size => Group[] group) public groups;

    event groupCompleted(uint size, uint[] group);
    constructor(uint[] memory _groupSizes) {
        groupSizes = _groupSizes;
    }

    function addGroup(uint size) public returns (Group[] memory) {
        uint[] memory _group = new uint[](size);
        Group memory group = Group({availSlots: size, members: _group});
        groups[size].push(group);
        return groups[size];
    }

    function existsGroup(uint size) public view returns (bool) {
        if (groups[size].length == 0) {
            return false;
        }
        return true;
    }

    function getGroup(uint size) public view returns (uint[] memory) {
        return groups[size][0].members;
    }

    // function addMember(uint groupSize, uint member) public {
    //     try _addMember(groupSize, member) returns (bool res) {
    //         return res;
    //     } catch {
    //         emit groupCompleted(groupSize, groups[groupSize][0].members);
    //     }
    // }
    function addMember(uint groupSize, uint member) public returns (bool) {
        int index = int(groups[groupSize][0].availSlots - 1);
        bool res;
        if (int(groups[groupSize][0].availSlots) >= 0) {
            groups[groupSize][0].members[uint(index)] = member;
            groups[groupSize][0].availSlots -= 1;
            res = true;
        }

        if (int(groups[groupSize][0].availSlots) < 0) {
            emit groupCompleted(groupSize, groups[groupSize][0].members);
            res = false;
        }

        return res;
    }
}
