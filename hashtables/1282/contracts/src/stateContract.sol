pragma solidity ^0.8.0;

contract StateContract {
    uint size;
    uint person;
    uint currentSize;
    uint groupID;

    bool lastPerson;
    uint[][] groups;
    uint lastSize;

    enum state {
        INITIAL,
        PROGRESS,
        MEMBERPROCESSED,
        DONE
    }

    state _state;

    modifier groupFilled() {
        require(currentSize == 0, "NOT FILLED YET");
        _;
    }

    modifier otherGroup() {
        require(size < lastSize, "PERSON DOES NOT FIT IN GROUP");
        _;
    }

    modifier receivingMembers() {
        require(size == lastSize, "NOT VALID STATE");
        _;
    }

    modifier starting() {
        require(_state == state.INITIAL, "StateContract: Already initialized");
        _;
    }

    modifier working() {
        require(_state == state.PROGRESS, "StateContract: Already initialized");
        _;
    }

    modifier lastPersonCall() {
        require(lastPerson == true, "NOT LAST PERSON");
        _;
    }

    modifier processing() {
        require(_state == state.MEMBERPROCESSED, "NOT VALID STATE");
        _;
    }

    event MemberAdded(uint indexed _person, uint indexed _group);
    event GroupFilled(uint indexed _group);

    function initialize(
        uint _person,
        uint _size,
        bool _lastPerson
    ) public starting {
        size = _size;
        person = _person;
        lastPerson = _lastPerson;
        lastSize = _size + 1;
        currentSize = size;
        groupID = 1;
        _state = state.PROGRESS;
        processor();
    }

    function work(
        uint _person,
        uint _size,
        bool _lastPerson
    ) public processing {
        size = _size;
        person = _person;
        lastPerson = _lastPerson;
        _state = state.PROGRESS;
        processor();
    }

    function removeLastSize() internal groupFilled working {
        lastSize = size + 1;
    }

    function createGroup() internal otherGroup working {
        uint[] memory group;
        groups.push(group);
    }

    function updateSize(uint _size) internal otherGroup working {
        lastSize = _size;
    }

    function addMember() internal receivingMembers working {
        groups[0].push(person);
        currentSize -= 1;
    }

    function processor() private working {
        if (currentSize == 0) {
            removeLastSize();
            emit GroupFilled(groupID);
            groupID += 1;
            groups.pop();
            processor();
        }
        if (size < lastSize && currentSize != 0) {
            updateSize(size);
            currentSize = size;
            createGroup();
            processor();
        }
        if (size == lastSize && currentSize != 0) {
            addMember();
            currentSize -= 1;
            emit MemberAdded(person, groupID);
        }
    }

    function sendGroups() external lastPersonCall working {
        //

        _state = state.DONE;
    }
}
