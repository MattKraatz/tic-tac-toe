import { expect } from 'chai';
import { ethers, waffle } from 'hardhat';
import web3 from 'web3';

import GameArtifact from '../artifacts/contracts/Game.sol/Game.json';
import { Game } from '../typechain-types/contracts/Game';

describe('Game', function () {
  let game: Game;

  beforeEach(async () => {
    const [alice] = await ethers.getSigners();

    game = (await waffle.deployContract(alice, GameArtifact)) as Game;

    // TODO: test initial deployment state
  });

  it('should create a game', async function () {
    const [, bob] = await ethers.getSigners();

    expect(
      await game
        .connect(bob)
        .startGame({ value: web3.utils.toWei('0.001', 'ether') })
    )
      .to.emit(game, 'NewGame')
      .withArgs('from', 'id');
  });
});
