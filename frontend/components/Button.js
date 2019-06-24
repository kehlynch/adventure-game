// @flow

import React from "react";
import { colours, fonts } from "../lib/theme";

type Props = {
  text: string,
  onClick: Function,
  type?: "continue" | "secondary" | "link" | "retrieve" | "new" | "inventory",
  disabled?: boolean,
  color?: string
};

export default (props: Props) => {
  const { type, disabled } = props;

  return (
    <div className="root">
      <style jsx>{`
        .root {
          display: flex;
          flex: 1;
        }
        button {
          border-radius: 100px;
          font-family: ${fonts.postGrotesk};
          font-size: 16px;
          font-weight: 700;
          text-align: center;
          flex: 1;
          cursor: pointer;
          padding: 10px 32px;
          background-color: ${colours.white};
          color: ${colours.green};
          border: solid 1px;
          border-color: ${colours.green};
        }
        button:focus {
          outline: none;
        }
        button:disabled {
          cursor: not-allowed;
        }
        .link {
          border-radius: 0;
          padding: 0;
          font-weight: 400;
          text-decoration: underline;
          color: ${colours.pewter1};
          border: 0;
        }
        .retrieve,
        .new {
          background-color: ${colours.green};
          color: ${colours.white};
          border-color: ${colours.green};
          padding: 10px 20px 12px 12px;
          text-align: left;
        }
        .continue {
          background-color: ${colours.green};
          color: ${colours.white};
          border-color: ${colours.green};
        }
        .inventory {
          background-color: ${colours.green};
          color: ${colours.white};
          border-color: ${colours.green};
        }
      `}</style>
      <button onClick={props.onClick} className={type} disabled={disabled}>
        {props.text}
      </button>
    </div>
  );
};
