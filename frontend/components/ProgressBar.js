// @flow

import React from "react";
import { colours } from "../lib/theme";

type Props = {
  numberOfQuestionInstances: number,
  currentQuestionInstanceIndex: number
};

export default ({
  numberOfQuestionInstances,
  currentQuestionInstanceIndex
}: Props) => {
  return (
    <div className="root">
      <style jsx>{`
        .root {
          display: flex;
          flex-direction: row;
          flex-wrap: nowrap;
          justify-content: space-between;
        }
        .progressBar {
          background-color: ${colours.pewter7};
          height: 6px;
          flex: 1;
          border-radius: 6px;
        }
        .progressBar :not(:last-child) {
          margin-right: 8px;
        }
        .active {
          background-color: ${colours.pewter1};
        }
      `}</style>

      {[...Array(numberOfQuestionInstances).keys()].map(key => {
        let className = "progressBar";
        if (key <= currentQuestionInstanceIndex) {
          className = "progressBar active";
        }
        return <span className={className} key={`progressBar-${key}`} />;
      })}
    </div>
  );
};
