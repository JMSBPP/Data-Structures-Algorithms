// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "../dependencies/reactive-smart-contract-demos/src/IReactive.sol";
import "../dependencies/reactive-smart-contract-demos/src/AbstractReactive.sol";
import "../dependencies/reactive-smart-contract-demos/src/ISystemContract.sol";

contract API is IReactive, AbstractReactive {
    event Event(
        uint256 indexed chain_id,
        address indexed _contract,
        uint256 indexed topic_0,
        uint256 topic_1,
        uint256 topic_2,
        uint256 topic_3,
        bytes data,
        uint256 counter
    );

    uint256 private constant SEPOLIA_CHAIN_ID = 11155111;
    uint64 private constant GAS_LIMIT = 1000000;
    address private _callback;
    uint256 public counter;
    constructor(
        address _service,
        address _contract,
        uint256 topic_0,
        address callback
    ) {
        service = ISystemContract(payable(_service));
        bytes memory payload = abi.encodeWithSignature(
            "subscribe(uint256,address,uint256,uint256,uint256,uint256)",
            SEPOLIA_CHAIN_ID,
            _contract,
            topic_0,
            REACTIVE_IGNORE,
            REACTIVE_IGNORE,
            REACTIVE_IGNORE
        );
        (bool subscription_result, ) = address(service).call(payload);
        vm = !subscription_result;
        _callback = callback;
    }

    receive() external payable {}

    function react(
        uint256 chain_id,
        address _contract,
        uint256 topic_0,
        uint256 topic_1,
        uint256 topic_2,
        uint256 topic_3,
        bytes calldata data,
        uint256 /* block_number */,
        uint256 /* op_code */
    ) external vmOnly {
        emit Event(
            chain_id,
            _contract,
            topic_0,
            topic_1,
            topic_2,
            topic_3,
            data,
            ++counter
        );
        if (topic_3 >= 0.1 ether) {
            bytes memory payload = abi.encodeWithSignature(
                "revealMessage(address,string,string)",
                address(0),
                "",
                ""
            );
            emit Callback(chain_id, _callback, GAS_LIMIT, payload);
        }
    }
}
