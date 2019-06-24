// @flow

import React from "react";
import Router from "next/router";

import Button from "./Button";

import { createGame } from "../lib/game";

import type { GameType } from "../types/game";

type Props = {
  games: Array<GameType>,
  userId: number
};

class GameList extends React.Component<Props> {
  gotoGame(gameId: number): Function {
    return () => {
      const newUrl = {
        pathname: "/main",
        query: {
          game_id: gameId
        }
      };

      Router.replace(newUrl);
      window.scrollTo(0, 0);
    };
  }

  createGame = async () => {
    const { userId } = this.props;
    const game = await createGame(null, userId);
    this.gotoGame(game.id)();
  };

  render() {
    const { games } = this.props;

    return (
      <div>
        <style jsx>{`
          .gameButtonContainer {
            margin-bottom: 20px;
            display: flex;
            align-items: flex-start;
          }
        `}</style>
        {games.map(game => (
          <div key={game.id} className="gameButtonContainer">
            <div className="gameButtom">
              <Button
                text={`🧙‍♀️${game.name}`}
                onClick={this.gotoGame(game.id)}
                type="new"
              />
            </div>
          </div>
        ))}
        <div className="gameButtonContainer">
          <div className="gameButtom">
            <Button text="🧙‍♀️ New Game" onClick={this.createGame} type="new" />
          </div>
        </div>
      </div>
    );
  }
}

export default GameList;
