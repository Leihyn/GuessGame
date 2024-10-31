// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

error FailedToSendEther();

contract Game {
    constructor() payable {}

    //random picking of a number between `0 to 2²⁵⁶–1`.
    function pickACard() private view returns (uint256) {
        //`abi.encodePacked` takes two params - `blockhash` & `block.timestamp`
        //returns byte array; passed into keccak256 which returns `bytes32`
        //which is converted into `uint`
        uint256 pickedCard = uint256(
            keccak256(
                abi.encodePacked(blockhash(block.number), block.timestamp))
        );
        return pickedCard;
    }

    //it begins the game by first choosing a random number(pickACard)
    //then verifies if the random number = _guess passed by the player
    //if correct, the player gets 0.001 ether
    function guess(uint256 _guess) public {
        uint256 _pickedCard = pickACard();
        if (_guess == _pickedCard) {
            (bool sent, ) = msg.sender.call{value: 0.001 ether}("");
            if(!sent) {
                revert FailedToSendEther();
            }
        }
    }

    //returns the balance of ether in the contract
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    } 
}