// @flow

import React from "react";

import { colours, fonts } from "../lib/theme";
import { postResponse, emptyResponse } from "../lib/response";
import { getSelectedOptions } from "../lib/area";
import type { InventoryItemType } from "../types/game";
import type { ResponseType } from "../types/response";
import type { OptionType } from "../types/option";
import Option from "./Option";

type Props = {
  item: InventoryItemType,
  gameId: number,
  setGame: Function,
  setMessage: Function
};

type State = {
  showDescription: boolean,
  response: ResponseType
};

class InventoryItem extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = {
      showDescription: false,
      response: emptyResponse()
    };
  }

  getIcon() {
    const { item } = this.props;
    const path = `/static/img/${item.slug}.png`;
    return path;
  }

  descriptionOn = () => {
    this.setDescription(true);
  };

  descriptionOff = () => {
    this.setDescription(false);
  };

  setDescription = (value: boolean) => {
    this.setState((state: State) => ({
      ...state,
      showDescription: value
    }));
  };

  submitResponse = async (option: OptionType) => {
    const { item, gameId, setGame, setMessage } = this.props;
    const response: ResponseType = {
      slug: item.slug,
      response_type: "item",
      options: [option],
      text: ""
    };

    this.setState((state: State) => ({
      ...state,
      response: response
    }));

    try {
      const { game, message } = await postResponse(null, response, gameId);

      this.setState((state: State) => ({
        ...state,
        response: emptyResponse()
      }));

      setGame(game);
      setMessage(message);
    } catch (error) {}
  };

  render() {
    const { item } = this.props;
    const { options } = item;
    const { showDescription, response } = this.state;

    const selectedOptions = getSelectedOptions(options, response);

    const iconStyle = {
      backgroundImage: "url(" + this.getIcon() + ")"
    };

    return (
      <div className="root">
        <style jsx>{`
          .root {
            display: flex;
            flex-direction: row;
            margin-top: 10px;
            align-items: center;
          }
          .item {
            display: flex;
            flex-direction: row;
            align-items: center;
          }
          .name {
            font-family: ${fonts.postGrotesk};
            font-size: 16px;
            font-weight: 700;
            color: ${colours.graphite1};
            text-align: left;
            line-height: 1.2;
            margin-right: 10px;
          }
          .descriptionIcon {
            padding: 10px
            margin-right: 20px;
            content: "";
            background-size: cover;
          }
          .description {
            position: absolute;
            padding: 5px 10px 5px 10px;
            // border: 2px solid ${colours.graphite1};
            border-radius: 5px;
            background-color: ${colours.green};
            font-family: ${fonts.postGrotesk};
            font-size: 14px;
            color: ${colours.white};
            text-align: left;
            line-height: 1.2;
            z-index: 2;
          }
          .options {
            display: flex;
          }
          .option {
            margin-right: 10px;
          }
        `}</style>
        <div
          className="descriptionIcon"
          style={iconStyle}
          onMouseOver={this.descriptionOn}
          onMouseLeave={this.descriptionOff}
        />
        <div className="item">
          <div className="name">{item.name}</div>
          {showDescription && (
            <div className="description">{item.description}</div>
          )}
          <div className="options">
            {options.map(option => (
              <div key={`${item.slug}-${option.slug}`} className="option">
                <Option
                  id={`${item.slug}-${option.slug}`}
                  option={option}
                  onToggle={option => this.submitResponse(option)}
                  selected={selectedOptions.indexOf(option) > -1}
                  index={options.indexOf(option)}
                  small
                />
              </div>
            ))}
          </div>
        </div>
      </div>
    );
  }
}

export default InventoryItem;
