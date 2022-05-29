// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "hardhat/console.sol";

import "@openzeppelin/contracts/access/Ownable.sol";

contract Game is Ownable {

    constructor() {}

    uint256 entryFee = 0.001 ether;

    function updateEntryFee(uint256 _price) external onlyOwner {
        console.log("Changing mint price from '%s' to '%s'", entryFee, _price);
        entryFee = _price;
    }

    function joinGame(uint256 gameId) public payable {
        require(msg.value == entryFee);
        // require that game is not full
        _joinGame(msg.sender, gameId);
    }

    function _joinGame(address player, uint256 gameId) private {
        // add player to game
    }

    // function makeMove
    // require: player's turn
    // require: game is not over
    // require: move is available
}
