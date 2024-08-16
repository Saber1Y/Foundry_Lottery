//SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

/**
 * @title Raffle
 * @dev Implements Chainlink VRFv2.5.
 * @author Saber
 * @notice This contract allows users to participate in Lotteries.
 */
import {VRFConsumerBaseV2Plus} from "@chainlink/contracts/src/v0.8/vrf/dev/VRFConsumerBaseV2Plus.sol";
// import {VRFV2PlusClient} from "@chainlink/contracts@1.2.0/src/v0.8/vrf/dev/libraries/VRFV2PlusClient.sol";

contract Raffle is VRFConsumerBaseV2Plus {
    error Raffle__NotEnoughToEnterRaflle();

    uint256 private immutable i_entranceFee;
    //interval time in seconnds
    uint256 private immutable i_interval;
    uint private s_lastTimeStamp;
    address payable[] private s_players;

    event RaffleEntered(address indexed player);

    constructor(uint256 entranceFee, uint256 interval) {
        i_entranceFee = entranceFee;
        i_interval = interval;
        s_lastTimeStamp = block.timestamp;
    }

    function entryRaffle() external payable {
        if (msg.value < i_entranceFee) {
            revert Raffle__NotEnoughToEnterRaflle();
        }

        s_players.push(payable(msg.sender));

        emit RaffleEntered(msg.sender);
    }

    function pickWinner() external {
        if ((block.timestamp - s_lastTimeStamp) < i_interval) {
            revert();
        }
        //Make Request to Get Chain Link RNG

        requestId = s_vrfCoordinator.requestRandomWords(
            VRFV2PlusClient.RandomWordsRequest({
                keyHash: s_keyHash,
                subId: s_subscriptionId,
                requestConfirmations: requestConfirmations,
                callbackGasLimit: callbackGasLimit,
                numWords: numWords,
                extraArgs: VRFV2PlusClient._argsToBytes(
                    // Set nativePayment to true to pay for VRF requests with Sepolia ETH instead of LINK
                    VRFV2PlusClient.ExtraArgsV1({nativePayment: false})
                )
            })
        );
    }

    function getEntranceFee() external view returns (uint256) {
        return i_entranceFee;
    }
}
