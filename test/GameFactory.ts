import { expect } from 'chai';
import { ethers, waffle } from 'hardhat';
import web3 from 'web3';

import GameFactoryArtifact from '../artifacts/contracts/GameFactory.sol/GameFactory.json';
import { GameFactory } from '../typechain-types/contracts/GameFactory';

describe('Game', function () {
  let gameFactory: GameFactory;

  beforeEach(async () => {
    const [alice] = await ethers.getSigners();

    gameFactory = (await waffle.deployContract(
      alice,
      GameFactoryArtifact
    )) as GameFactory;

    // TODO: test initial deployment state
  });

  it('should create a game', async function () {
    const [, bob] = await ethers.getSigners();

    expect(
      await gameFactory
        .connect(bob)
        .startGame({ value: web3.utils.toWei('0.001', 'ether') })
    )
      .to.emit(gameFactory, 'NewGame')
      .withArgs('from', 'id');
  });
});
