// @flow

import React from "react";

import Button from "./Button";

import type { GameType } from "../types/game";

type Props = {
  game: GameType,
  message: ?string,
  toggleInventory: Function,
  showInventory: boolean
};

class Header extends React.Component<Props> {
  render() {
    const { game, message, toggleInventory, showInventory } = this.props;
    const { inventory } = game;

    return (
      <div>
        <style jsx>{`
          .root {
            display: flex;
            align-items: flex-end;
            justify-content: space-between;
          }
          .message {
            font-size: 24px;
            font-weight: 700;
          }
          .inventoryButtonContainer {
            z-index: 100;
          }
        `}</style>
        <div className="root">
          <div className="message">{message}</div>
          {(!!inventory.length || showInventory) && (
            <div className="inventoryButtonContainer">
              <Button
                text={showInventory ? "Back to Adventure" : "Inventory"}
                onClick={toggleInventory}
                type="inventory"
              />
            </div>
          )}
        </div>
      </div>
    );
  }
}

export default Header;
