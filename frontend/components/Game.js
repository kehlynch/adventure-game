// @flow

import React from "react";
import Router from "next/router";

import Header from "./Header";
import Area from "./Area";
import Inventory from "./Inventory";
import mediaQueries from "../lib/mediaQueries";
import { colours, fonts } from "../lib/theme";

import type { GameType } from "../types/game";

type State = {
  game: GameType,
  message: ?string,
  showInventory: boolean
};

type Props = {
  game: GameType,
  inventory: boolean
};

class Game extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = {
      showInventory: props.inventory,
      game: props.game,
      message: null
    };
  }

  setGame = (game: GameType) => {
    this.setState((state: State) => ({
      ...state,
      game: game
    }));
  };

  setMessage = (message: string) => {
    this.setState((state: State) => ({
      ...state,
      message: message
    }));
  };

  toggleInventory = () => {
    const { showInventory } = this.state;
    const { game } = this.props;

    const href = `/main?game_id=${
      game.id
    }&inventory=${(!showInventory).toString()}`;

    this.setState((state: State) => ({
      ...state,
      showInventory: !showInventory
    }));

    Router.replace(href, href, { shallow: true });
    window.scrollTo(0, 0);
  };

  render() {
    const { showInventory, game, message } = this.state;
    const { id, area, inventory } = game;

    return (
      <div className="root">
        <style jsx>{`
          .root {
          }
          .areaContainer {
          }
          .areaContainer:not(:last-child) {
            padding-bottom: 32px;
            margin-bottom: 32px;
          }
          .inventoryButtonContainer {
            position: absolute;
            right: 10px;
            top: 10px;
          }
          p {
            color: ${colours.graphite1};
            font-family: ${fonts.postGrotesk};
            font-size: 14px;
            margin: 32px 0;
          }
          @media ${mediaQueries.gtSmall} {
          }
        `}</style>
        <div>
          <Header
            game={game}
            toggleInventory={this.toggleInventory}
            showInventory={showInventory}
            message={message}
          />
        </div>
        {showInventory && (
          <div className="inventoryContainer">
            <Inventory
              inventory={inventory}
              gameId={game.id}
              setGame={this.setGame}
              setMessage={this.setMessage}
            />
          </div>
        )}
        {!showInventory && (
          <div className="areaContainer">
            <Area
              area={area}
              gameId={id}
              setGame={this.setGame}
              setMessage={this.setMessage}
            />
          </div>
        )}
      </div>
    );
  }
}

export default Game;
