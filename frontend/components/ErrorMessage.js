// @flow

import React from "react";

import { fonts } from "../lib/theme";

type Props = {
  message: string
};

class ErrorMessage extends React.Component<Props> {
  render() {
    const { message } = this.props;

    return (
      <div>
        <style jsx>{`
          .errorMessage {
            color: red;
            text-align: center;
            font-family: ${fonts.postGrotesk};
          }
        `}</style>
        <p className="errorMessage">{message}</p>
      </div>
    );
  }
}

export default ErrorMessage;
