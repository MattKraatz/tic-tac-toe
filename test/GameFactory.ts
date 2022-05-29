import { expect } from 'chai';
import { ethers, waffle } from 'hardhat';
import web3 from 'web3';

import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import GameFactoryArtifact from '../artifacts/contracts/GameFactory.sol/GameFactory.json';
import { GameFactory } from '../typechain-types';

describe('GameFactory', function () {
  let gameFactory: GameFactory;
  let owner: SignerWithAddress;
  let alice: SignerWithAddress;
  let bob: SignerWithAddress;

  beforeEach(async () => {
    [owner, alice, bob] = await ethers.getSigners();

    gameFactory = (await waffle.deployContract(
      alice,
      GameFactoryArtifact
    )) as GameFactory;

    // test initial deployment state
    expect(await gameFactory.numGames()).to.eq(0);
  });

  it('should allow creating a game', async function () {
    expect(
      await gameFactory
        .connect(bob)
        .startGame({ value: web3.utils.toWei('0.001', 'ether') })
    )
      .to.emit(gameFactory, 'NewGame')
      .withArgs(bob.address, 0);

    expect(await gameFactory.numGames()).to.eq(1);
  });

  it('should allow joining a game', async function () {
    await gameFactory
      .connect(bob)
      .startGame({ value: web3.utils.toWei('0.001', 'ether') });

    expect(
      await gameFactory
        .connect(alice)
        .joinGame(0, { value: web3.utils.toWei('0.001', 'ether') })
    )
      .to.emit(gameFactory, 'NewPlayer')
      .withArgs(alice.address, 0);
  });
});
