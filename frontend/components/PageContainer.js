// @flow

import * as React from "react";

import mediaQueries from "../lib/mediaQueries";

type Props = {
  children: React.Node,
  backgroundColourInner: string,
  backgroundColour: string,
  fixedHeight?: string,
  fixedHeightOffFull?: string
};

class Layout extends React.Component<Props> {
  render() {
    const { children, backgroundColour } = this.props;

    return (
      <div className="root">
        <style jsx>{`
          .root {
            background-color: ${backgroundColour};
            flex: 1 1 100vh;
            height: 100vh;
          }
          .outerContainer {
            width: 100%;
            position: relative;
          }
          .background {
            width: 100%;
            height: 100vh;
            background: url("/static/img/forest1.jpg") no-repeat center top;
            content: "";
            position: absolute;
            top: 0px;
            left: 0px;
            opacity: 0.2;
            background-size: cover;
          }
          .innerContainer {
            padding: 16px;
            position: relative;
            z-index: 10;
          }
          .test {
            background-color: black;
            height: 100px;
          }
          @media ${mediaQueries.gtSmall} {
            .outerContainer {
              max-width: 760px;
              margin: 0 auto;
              position: relative;
            }
            .background {
              width: 760px;
              height: 100vh;
              background: url("/static/img/forest1.jpg") no-repeat center top;
              content: "";
              position: absolute;
              top: 0px;
              left: 0px;
              opacity: 0.2;
              background-size: cover;
            }
          }
        `}</style>
        <div className="outerContainer">
          <div className="background" />
          <div className="innerContainer">{children}</div>
        </div>
      </div>
    );
  }
}

export default Layout;
