// @flow

import React from "react";

import InventoryItem from "./InventoryItem";

import type { InventoryType } from "../types/game";

type Props = {
  inventory: InventoryType,
  gameId: number,
  setGame: Function,
  setMessage: Function
};

class Inventory extends React.Component<Props> {
  render() {
    const { inventory, gameId, setGame, setMessage } = this.props;

    return (
      <div className="root">
        <style jsx>{`
          .root {
            margin-left: 100px;
            display: flex;
            flex-direction: column;
          }
        `}</style>
        {inventory.map(item => (
          <InventoryItem
            key={item.slug}
            item={item}
            gameId={gameId}
            setGame={setGame}
            setMessage={setMessage}
          />
        ))}
      </div>
    );
  }
}

export default Inventory;
