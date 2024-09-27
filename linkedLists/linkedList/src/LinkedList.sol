// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

library NodeMethods {
    struct Node {
        bytes8 prev;
        bytes16 data;
        bytes8 next;
    }

    function setNext(Node storage node, bytes8 nextNodeId) public {
        node.next = nextNodeId;
    }
}
abstract contract ALinkedList {
    struct Node {
        bytes8 prev;
        bytes16 data;
        bytes8 next;
    }
}
contract LinkedList is ALinkedList {
    using NodeMethods for Node;

    Node head;
    mapping(bytes8 => Node) public nodes;

    function getHead() public view returns (Node memory) {
        return head;
    }
}
