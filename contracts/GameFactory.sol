// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "hardhat/console.sol";

import "@openzeppelin/contracts/access/Ownable.sol";

contract GameFactory is Ownable {

    constructor() {
        gameIndex = 0;
    }

    uint256 entryFee = 0.001 ether;

    function updateEntryFee(uint256 _price) external onlyOwner {
        console.log("Changing mint price from '%s' to '%s'", entryFee, _price);
        entryFee = _price;
    }

    enum GameSquare {
        None, X, Y
    }

    struct Game {
        address playerX;
        address playerO;
        GameSquare[3][3] board;
    }

    mapping(uint256 => Game) private games;
    uint256 private gameIndex;

    function startGame(uint256 gameId) public payable {
        require(msg.value == entryFee);
        _startGame(msg.sender, gameId);
        // emit NewGame Event
    }

    function _startGame(address player, uint256 gameId) private {
        // create a new game and add a player
    }

    function joinGame(uint256 gameId) public payable {
        require(msg.value == entryFee);
        // require that game is not full
        _joinGame(msg.sender, gameId);
        // emit NewPlayer Event
    }

    function _joinGame(address player, uint256 gameId) private {
        // add player to game
    }

    // function makeMove
    // require: player's turn
    // require: game is not over
    // require: move is available
    // emit NewMove Event
}
