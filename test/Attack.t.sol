// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import {Test} from "forge-std/Test.sol";
import {Attack} from "../src/Attack.sol";
import {Game} from "../src/Game.sol";

contract AttackTester is Test {
    //declaration of variables holding instances od =contracts
    Game public gameContract;
    Attack public attackContract;

    //bytes32 arrays to save space
    bytes32 usernameBytes = "test";
    bytes32 passwordBytes = "password";

    function setUp() public {
        //deploy the copntract and send 0.001 ether to it
        gameContract = new Game{value: 0.001 ether}();
    }

    function test_attack() public {
        //deploy the Game Contract
        attackContract = new Attack(address(gameContract));

        //attack the game contract
        attackContract.attack();

        //balance of the game contract should be equal 0
        assertEq(gameContract.getBalance(), 0);
    }
}