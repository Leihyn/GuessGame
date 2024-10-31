// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "forge-std/Script.sol";
import "../src/Game.sol";
import "../src/Attack.sol";

contract DeployGameAttack is Script {
    Game public game;
    Attack public attack;

    function run() external {
        vm.startBroadcast();

        // Deploy the Game contract with initial funds
        game = new Game{value: 0.01 ether}();
        console.log("Game contract deployed at:", address(game));

        // Deploy the Attack contract with the address of the Game contract
        attack = new Attack(address(game));
        console.log("Attack contract deployed at:", address(attack));

        vm.stopBroadcast();
    }
}
