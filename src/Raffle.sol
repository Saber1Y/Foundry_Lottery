//SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

/**
 * @title Raffle
 * @dev Implements Chainlink VRFv2.5.
 * @author Saber
 * @notice This contract allows users to participate in a raffle with a chance to win a prize.
 */
contract Raffle {
    uint256 private immutable i_entranceFee;

    constructor(uint256 entranceFee) {
        i_entranceFee = entranceFee;
    }

    function getEntranceFee() external view returns (uint256) {
        return i_entranceFee;
    }

    function entryRaffle() public payable {}

    function pickWinner() public {}
}
