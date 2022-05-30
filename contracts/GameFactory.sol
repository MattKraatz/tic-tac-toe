// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import 'hardhat/console.sol';

import '@openzeppelin/contracts/access/Ownable.sol';

contract GameFactory is Ownable {
    constructor() {}

    uint256 entryFee = 0.001 ether;

    function updateEntryFee(uint256 _price) external onlyOwner {
        console.log("Changing mint price from '%s' to '%s'", entryFee, _price);
        entryFee = _price;
    }

    enum GameSquare {
        None,
        X,
        Y
    }

    struct Game {
        address playerX;
        address playerO;
        GameSquare[3][3] board;
    }

    mapping(uint256 => Game) public games;
    uint256 public numGames;

    event NewGame(address indexed playerX, uint256 gameId);

    function startGame() public payable {
        require(msg.value == entryFee);
        uint256 gameId = numGames++;
        Game storage g = games[gameId];
        g.playerX = msg.sender;
        emit NewGame(msg.sender, gameId);
    }

    event NewPlayer(address indexed playerO, uint256 gameId);

    function joinGame(uint256 gameId) public payable {
        require(msg.value == entryFee);
        Game storage g = games[gameId];
        require(g.playerO == address(0), 'This game is full');
        g.playerO = msg.sender;
        emit NewPlayer(msg.sender, gameId);
    }

    // function makeMove
    // require: player's turn
    // require: game is not over
    // require: move is available
    // emit NewMove Event
}
