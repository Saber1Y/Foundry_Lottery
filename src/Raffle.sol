//SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

/**
 * @title Raffle
 * @dev Implements Chainlink VRFv2.5.
 * @author Saber
 * @notice This contract allows users to participate in Lotteries.
 */
contract Raffle {
    error Raffle__NotEnoughToEnterRaflle();

    uint256 private immutable i_entranceFee;
    address payable[] private s_players;

    event RaffleEntered(address indexed player);

    constructor(uint256 entranceFee) {
        i_entranceFee = entranceFee;
    }

    function entryRaffle() public payable {
        if (msg.value < i_entranceFee) {
            revert Raffle__NotEnoughToEnterRaflle();
        }

        s_players.push(payable(msg.sender));

        emit RaffleEntered(msg.sender);
    }

    function pickWinner() public {}

    function getEntranceFee() external view returns (uint256) {
        return i_entranceFee;
    }
}
