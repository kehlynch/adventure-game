// @flow

import React from "react";

import { colours, fonts } from "../lib/theme";

type Props = {
  onChange: Function,
  value: string,
  placeholderText?: string
};

export default (props: Props) => {
  const onInputChange = (e: Object) => {
    props.onChange(e.target.value);
  };

  return (
    <div className="root">
      <style jsx>{`
        .root {
          display: flex;
        }
        textarea {
          flex: 1;
          border: 0;
          border-radius: 0;
          border-bottom: 1px solid ${colours.pewter7};
          color: ${colours.graphite1};
          font-family: ${fonts.postGrotesk};
          font-size: 19px;
          height: 30px;
          padding: 2px 28px;
          margin: 0;
        }
        img {
          font-size: 8px;
        }
        textarea::placeholder {
          font-size: 19px;
          color: ${colours.pewter1};
        }
        textarea:focus {
          outline: none;
        }
        .pencil {
          position: absolute;
          padding: 5px;
          padding-left: 4px;
          padding-bottom: 4px;
        }
      `}</style>
      <img src="/static/img/pencil.svg" className="pencil" />
      <textarea
        rows="2"
        value={props.value}
        onChange={onInputChange}
        placeholder={props.placeholderText || ""}
      />
    </div>
  );
};
