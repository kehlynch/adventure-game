// @flow

import React from "react";

import { colours, fonts } from "../lib/theme";

import type { OptionType } from "../types/option";

type Props = {
  onToggle: Function,
  option: OptionType,
  selected: boolean,
  id: string,
  small?: boolean
};

class Option extends React.Component<Props> {
  render() {
    const { id, option, selected, onToggle, small } = this.props;
    const checkboxOnChange = () => onToggle(option);
    return (
      <div className="root">
        <style jsx>{`
          .root {
            display: flex;
            justify-content: center;
            align-items: center;
          }
          input[type="checkbox"] {
            position: absolute;
            left: -9999px;
            /* For mobile, it's typically better to position checkbox on top of clickable
               area and turn opacity to 0 instead. */
          }
          label {
            cursor: pointer;
            user-select: none;
            font-family: ${fonts.robotoMono};
            font-size: ${small ? "10px" : "14px"};
            color: ${colours.graphite1};
          }
          label.nonDir {
            background-color: ${colours.white};
            border-radius: 50px;
            padding: ${small ? "5px 10px 5px 10px" : "9px 20px 10px 20px"};
            flex: 1;
          }
          label.dir {
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: ${option.direction && "rgba(255, 255, 255, 1)"};
            z-index: 3;
            border-radius: 20px;
            min-width: 40px;
            min-height: 40px;
            font-family: ${fonts.robotoMono};
            font-size: 12px;
            font-weight: 1000;
            color: ${colours.graphite1};
            padding: 5px;
          }
          label.south {
            flex-direction: column-reverse;
          }
          label.west {
          }
          label.east {
          }
          .dirIcon {
            font-size: 50px;
            height: 100%;
            position: absolute;
            top: 0px;
            background: rgba(255, 255, 255, 0.2);
          }
          .dirIcon.north {
          }
          .dirIcon.south {
          }
          .dirIcon.east {
          }
          .dirIcon.west {
          }
          .text {
          }
          input[type="checkbox"]:checked ~ label {
            background-color: ${colours.graphite1};
            color: ${colours.white};
          }
          input[type="checkbox"]:checked ~ label:after {
            color: ${colours.white};
            border-radius: 20px;
          }
        `}</style>
        <input
          type="checkbox"
          id={id}
          onChange={checkboxOnChange}
          checked={selected}
        />
        <label
          htmlFor={id}
          className={option.direction ? `dir ${option.direction}` : "nonDir"}
        >
          <div className={"text"}>{option.text}</div>
        </label>
      </div>
    );
  }
}

export default Option;
