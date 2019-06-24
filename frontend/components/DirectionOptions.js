// @flow

import React from "react";

import Option from "./Option";

import type { OptionListType } from "../types/option";

type Props = {
  options: OptionListType,
  selectedOptions: OptionListType,
  onToggleOption: Function
};

class DirectionOptions extends React.Component<Props> {
  render() {
    const { options, selectedOptions, onToggleOption } = this.props;
    const north = options.filter(o => o.direction === "north")[0];
    const south = options.filter(o => o.direction === "south")[0];
    const east = options.filter(o => o.direction === "east")[0];
    const west = options.filter(o => o.direction === "west")[0];

    return (
      <div className="root">
        <style jsx>{`
          .root {
            position: relative;
            display: flex;
            flex-direction: column;
            margin: auto;
            z-index: 1;
            align-items: center;
            justify-content: center;
            width: 200px;
            height: 200px;
          }
          .root:after {
            position: absolute;
            background: url("/static/img/compass.jpg") no-repeat center top;
            background-size: contain;
            content: "";
            top: 10;
            width: 180px;
            height: 180px;
            border-radius: 160px;
            opacity: 0.3;
            margin: auto;
          }
          .north {
            display: flex;
            flex: 1;
            justify-content: center;
            align-items: flex-start;
            z-index: 5;
          }
          .south {
            display: flex;
            flex: 1;
            justify-content: center;
            align-items: flex-end;
            z-index: 5;
          }
          .eastwest {
            display: flex;
            justify-content: space-between;
            z-index: 5;
            width: 180%;
          }
          .west,
          .east {
            flex: 1;
          }
        `}</style>
        {north && (
          <div className="north">
            <Option
              key={`option-${north.slug}`}
              id={`option-${north.slug}`} // key is a special prop so we pass this separately as id https://reactjs.org/warnings/special-props.html
              option={north}
              onToggle={onToggleOption}
              selected={selectedOptions.indexOf(north) > -1}
              index={options.indexOf(north)}
            />
          </div>
        )}
        <div className="eastwest">
          {!!west && (
            <div className="west">
              <Option
                key={`option-${west.slug}`}
                id={`option-${west.slug}`} // key is a special prop so we pass this separately as id https://reactjs.org/warnings/special-props.html
                option={west}
                onToggle={onToggleOption}
                selected={selectedOptions.indexOf(west) > -1}
                index={options.indexOf(west)}
              />
            </div>
          )}
          {!!east && (
            <div className="east">
              <Option
                key={`option-${east.slug}`}
                id={`option-${east.slug}`} // key is a special prop so we pass this separately as id https://reactjs.org/warnings/special-props.html
                option={east}
                onToggle={onToggleOption}
                selected={selectedOptions.indexOf(east) > -1}
                index={options.indexOf(east)}
              />
            </div>
          )}
        </div>
        {south && (
          <div className="south">
            <Option
              key={`option-${south.slug}`}
              id={`option-${south.slug}`} // key is a special prop so we pass this separately as id https://reactjs.org/warnings/special-props.html
              option={south}
              onToggle={onToggleOption}
              selected={selectedOptions.indexOf(south) > -1}
              index={options.indexOf(south)}
            />
          </div>
        )}
      </div>
    );
  }
}

export default DirectionOptions;
