// @flow

import React from "react";

import Option from "./Option";
import DirectionOptions from "./DirectionOptions";

import type { OptionType, OptionListType } from "../types/option";

type Props = {
  onChange: Function,
  options: OptionListType,
  selectedOptions: OptionListType
};

class Options extends React.Component<Props> {
  onToggleOption = (option: OptionType) => {
    const { selectedOptions, onChange } = this.props;
    if (selectedOptions.indexOf(option) > -1) {
      // Toggle: deselecting option
      onChange([]);
    } else {
      // Toggle: selecting option
      onChange([option]);
    }
  };

  render() {
    const { options, selectedOptions } = this.props;

    const nonDirectionOptions = options.filter(o => !o.direction);
    const directionOptions = options.filter(o => !!o.direction);
    return (
      <div className="root">
        <style jsx>{`
          .root {
            display: flex;
            flex-direction: column;
            flex: 1;
          }
          .directionOptions {
            display: flex;
            flex: 1;
            flex-direction: column;
            align-items: center;
          }
          .nonDirectionOptions {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
          }
          .nonDirOption {
            margin-bottom: 15px;
          }
        `}</style>
        {!!directionOptions.length && (
          <DirectionOptions
            options={directionOptions}
            onToggleOption={this.onToggleOption}
            selectedOptions={selectedOptions}
          />
        )}
        <div className="nonDirectionOptions">
          {nonDirectionOptions.map(option => (
            <div key={`option-${option.slug}`} className="nonDirOption">
              <Option
                id={`option-${option.slug}`}
                option={option}
                onToggle={this.onToggleOption}
                selected={selectedOptions.indexOf(option) > -1}
                index={options.indexOf(option)}
              />
            </div>
          ))}
        </div>
      </div>
    );
  }
}

export default Options;
