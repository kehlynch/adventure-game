// @flow

import React from "react";
import RangeSlider from "react-rangeslider";
import rangeSliderStyles from "react-rangeslider/lib/index.css";

import { colours } from "../lib/theme";

type Props = {
  onChange: Function,
  value: number
};

type State = {
  isActive: boolean
};

class Slider extends React.Component<Props, State> {
  constructor() {
    super();

    this.state = {
      isActive: false
    };
  }

  componentDidMount() {
    this.setState((state: State) => ({ ...state, isActive: true }));
    this.onInputChange(this.props.value);
  }

  onInputChange = (value: number) => {
    this.props.onChange(value);
  };

  render() {
    const { value } = this.props;
    const { isActive } = this.state;

    return (
      <div className="root">
        <style
          dangerouslySetInnerHTML={{
            // $FlowIgnore: Flow expects imported CSS to be an Object rather than a String
            __html: `
            ${rangeSliderStyles}
            .rangeslider {
              background: none;
              box-shadow: none;
              border: none;
              height: 51px;
              margin: 1rem 0 0 0;
            }
            .rangeslider .rangeslider__fill {
              display: none;
            }
            .rangeslider .rangeslider__handle {
              background-color: ${colours.white};
              background-image: url("/static/img/slider_handle.svg");
              background-position: center center;
              background-repeat: no-repeat;
              background-size: 60%;
              border: 0;
              border-radius: 100px;
              box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
              width: 50px;
              height: 50px;
            }
            .rangeslider .rangeslider__handle:focus {
              outline: none;
            }
            .rangeslider .rangeslider__handle:active {
              background-color: ${colours.raspberry1};
              background-image: url("/static/img/slider_handle_active.svg");
            }
            .rangeslider .rangeslider__handle:after {
              display: none;
            }
          `
          }}
        />
        <style jsx>{`
          .root {
            visibility: ${isActive ? "visible" : "hidden"};
          }
          .sliderContainer {
            position: relative;
          }
          .sliderBackground {
            margin: 0;
            background: ${colours.pewter7};
            box-shadow: none;
            height: 5px;
            position: absolute;
            top: 24px;
            left: 2px;
            right: 2px;
            display: flex;
            justify-content: center;
          }
          .sliderMidpoint {
            background: ${colours.pewter3};
            width: 5px;
          }
          .rangeEndpoints {
            display: flex;
            justify-content: space-between;
          }
          .rangeEndpointIcon {
            height: 50px;
            width: 50px;
          }
        `}</style>
        <div className="rangeEndpoints">
          <img src="/static/img/sad.svg" className="rangeEndpointIcon" />
          <img src="/static/img/happy.svg" className="rangeEndpointIcon" />
        </div>
        <div className="sliderContainer">
          <div className="sliderBackground">
            <div className="sliderMidpoint" />
          </div>
          <RangeSlider
            min={-2}
            max={2}
            step={0.01}
            tooltip={false}
            value={value}
            onChange={this.onInputChange}
          />
        </div>
      </div>
    );
  }
}

export default Slider;
