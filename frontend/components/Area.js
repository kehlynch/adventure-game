// @flow

import React from "react";

import Options from "./Options";
import TextInput from "./TextInput";
import Button from "./Button";
import ErrorMessage from "./ErrorMessage";

import { postResponse, emptyResponse } from "../lib/response";
import { fonts, colours } from "../lib/theme";
import { getOptions, getSelectedOptions } from "../lib/area";

import type { AreaType } from "../types/area";
import type { ResponseType } from "../types/response";

type Props = {
  area: AreaType,
  gameId: number,
  setGame: Function,
  setMessage: Function
};

type State = {
  response: ResponseType,
  valid: boolean,
  submissionFailed: boolean
};

class Area extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    const response = emptyResponse();
    this.state = {
      response: response,
      submissionFailed: false,
      valid: true
    };
  }

  componentDidMount() {
    this.setValidity();
  }

  setValidity() {
    this.setState((state: State) => {
      const { area } = this.props;
      const { response } = state;
      let valid = true;
      if (area.type === "Select") {
        const minOptions = area.min_options;
        const maxOptions = area.max_options;
        const selectionCount = 1;
        if (
          (minOptions && selectionCount < minOptions) ||
          (maxOptions && selectionCount > maxOptions)
        ) {
          valid = false;
        }
      } else if (area.type === "Text" && response.text === "") {
        valid = false;
      }

      return {
        ...state,
        valid: valid
      };
    });
  }

  onResponseChange = (field: string, area: AreaType) => {
    return (fieldValue: string) => {
      this.setState((state: State) => {
        const { response } = state;
        const newResponse = {
          slug: area.slug,
          response_type: "area",
          options: response.options,
          text: response.text
        };

        newResponse[field] = fieldValue;
        return {
          ...state,
          response: newResponse
        };
      }, this.submitResponseIfSelect);
    };
  };

  submitResponseIfSelect = () => {
    this.setValidity();
    const { area } = this.props;
    if (area.type === "Select") {
      this.submitResponse();
    }
  };

  submitResponse = async () => {
    const { gameId, setGame, setMessage } = this.props;
    const { response } = this.state;

    try {
      const { game, message } = await postResponse(null, response, gameId);
      setGame(game);
      setMessage(message);
      this.setState((state: State) => ({
        ...state,
        response: emptyResponse()
      }));
    } catch (error) {
      this.setSubmissionFailed();
    }
  };

  setSubmissionFailed = (failed: boolean = true) => {
    this.setState((state: State) => ({
      ...state,
      submissionFailed: failed
    }));
  };

  render() {
    const { area } = this.props;
    const { submissionFailed, valid, response } = this.state;

    const options = getOptions(area);
    const selectedOptions = getSelectedOptions(options, response);

    return (
      <div>
        <style jsx>{`
          .questionText {
            font-family: ${fonts.postGrotesk};
            font-size: 20px;
            font-weight: 700;
            color: ${colours.graphite8};
            text-align: left;
            line-height: 1.2;
          }
          .inputContainer {
            // padding-top: 40px;
          }
          .multi-select-container {
            margin-bottom: 32px;
          }
          .single-select-container {
            padding-bottom: 32px;
          }
          .buttonContainer {
            margin-top: 10px;
            display: flex;
            justify-content: flex-start;
          }
        `}</style>
        {area.description.map((description, i) => (
          <p key={i} className="questionText">
            {description}
          </p>
        ))}
        <div>
          {area.show_weather && (
            <p className="questionText">{area.weather.description}</p>
          )}
        </div>
        <div className="inputContainer">
          {area.type === "Text" && (
            <TextInput
              onChange={this.onResponseChange("text", area)}
              value={(response && response.text) || ""}
              placeholderText={area.placeholder_text || "Answer..."}
            />
          )}
          {area.type === "Select" && (
            <div>
              <div className="option-container" key="binarySelect">
                <Options
                  onChange={this.onResponseChange("options", area)}
                  options={options}
                  selectedOptions={selectedOptions || []}
                />
              </div>
            </div>
          )}
        </div>
        {submissionFailed && (
          <ErrorMessage message="There was a problem submitting your responses. Please try again" />
        )}
        {area.type !== "Select" && (
          <div className="buttonContainer">
            <Button
              text="Continue"
              onClick={this.submitResponse}
              type="continue"
              disabled={!valid}
            />
          </div>
        )}
      </div>
    );
  }
}

export default Area;
