pragma solidity ^0.8.0;



contract StateContract {
    
    uint size;
    uint person;
    uint currentSize;

    bool lastPerson;
    bytes[] groups;
    uint[] lastSize;

    enum state {
        INITIAL,
        PROGRESS,
        DONE
    }

    state _state;

    modifier groupFilled{
        require(currentSize==0, 'NOT FILLED YET'),
        _;
    }

    modifier otherGroup{
        require(size< lastSize[0], 'PERSON DOES NOT FIT IN GROUP'),
        _;
    }

    modifier receivingMembers{
        require(size==lastSize[0], 'NOT VALID STATE')
    }

    modifier starting{
        require(_state == state.INITIAL, "StateContract: Already initialized"),
        _;
    }

    modifier working{
        require(_state == state.PROGRESS, "StateContract: Already initialized"),
        _;
    }

    modifier lastPersonCall{
        require(lastPerson==true, 'NOT LAST PERSON'), 
        _;
    }
    

    function initialize(uint person, uint _size bool _lastPerson) public starting{

        size = _size;
        person = _person;
        lastPerson = _lastPerson;
        lastSize.append(-1);
        currentSize = size;
        state = state.PROGRESS;
    }

    function removeLastSize() internal groupFilled working {
        lastSize.pop();
    }

    function createGroup(uint _size) internal otherGroup working {
        uint[_size] group;
        groups.append(group);
        assert groups[0] == group;
    }

    function updateSize(uint _size) internal otherGroup working{
        lastSize.push(_size);
    }

    function addMember() internal receivingMembers working{
        groups[0].push(person);
        currentSize -=1;
    }

    function sendGroups() external lastPersonCall working{
    //

        _state = state.DONE;
    }



}



    





}