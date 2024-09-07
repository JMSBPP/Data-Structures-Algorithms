// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract solution {
    enum State {
        CLOSED,
        OPEN
    }

    struct Group {
        uint32 size;
        uint32[] members;
        State state;
        uint32 availSlots;
    }

    uint[] groups;

    Group group;

    uint[] groupSizes;

    uint[][] finalGroups;

    modifier receivingMembers(uint32 id) {
        require(groups[id].state == State.OPEN, "NOT RECEIVING MEMBERS");
        _;
    }

    constructor(uint[] memory _groupSizes) {
        groupSizes = _groupSizes;
    }

    function createGroup(uint32 size) public {
        uint32[] memory _members = new uint32[](size);
        group = Group({
            size: size,
            members: _members,
            state: State.OPEN,
            availSlots: size
        });

        groups.push(group);
    }

    function addMember(uint32 member, uint32 id) public receivingMembers(id) {
        groups[id].members.push(member);
        groups[id].availSlots -= 1;
        if (groups[id].availSlots == 0) {
            groups[id].state = State.CLOSED;
        }
    }

    function queryOpenGroups() internal returns (uint[] memory) {
        uint32[] memory openGroups = new uint32[](groups.length);
        for (uint id = 0; id < groups.length; id++) {
            if (groups[id].state == State.OPEN) {
                openGroups.push(id);
            }
            return openGroups;
        }
    }

    function processor(
        uint person,
        uint groupSize
    ) public returns (uint[] memory) {
        uint32[] memory openGroups = new uint32[](groups.length);
        openGroups = queryOpenGroups();
        for (uint id = 0; id < openGroups.length; id++) {
            if (groups[openGroups[id]].size == groupSize) {
                addMember(person, openGroups[id]);
            } else {
                createGroup(groupSize);
                addMember(person, groups[groups.length - 1].members);
            }
        }

        return groups;
    }
}
