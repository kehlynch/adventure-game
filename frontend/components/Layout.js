// @flow

import * as React from "react";
import Head from "next/head";

import { colours } from "../lib/theme";

type Props = {
  children: React.Node
};

class Layout extends React.Component<Props> {
  render() {
    const { children } = this.props;

    return (
      <main>
        <Head>
          <title>Adventure Game</title>
          <meta
            name="viewport"
            content="initial-scale=1.0, width=device-width"
          />
        </Head>
        <div>
          <style jsx global>{`
            @font-face {
              font-family: "PostGrotesk";
              font-weight: 400;
              font-style: normal;
              src: url("/static/fonts/PostGrotesk-Book.eot") format("eot");
              src: url("/static/fonts/PostGrotesk-Book.woff") format("woff");
              src: url("/static/fonts/PostGrotesk-Book.woff2") format("woff2");
            }
            @font-face {
              font-family: "PostGrotesk";
              font-weight: 500;
              font-style: normal;
              src: url("/static/fonts/PostGrotesk-Medium.eot") format("eot");
              src: url("/static/fonts/PostGrotesk-Medium.woff") format("woff");
              src: url("/static/fonts/PostGrotesk-Medium.woff2") format("woff2");
            }
            @font-face {
              font-family: "PostGrotesk";
              font-weight: 700;
              font-style: normal;
              src: url("/static/fonts/PostGrotesk-Bold.eot") format("eot");
              src: url("/static/fonts/PostGrotesk-Bold.woff") format("woff");
              src: url("/static/fonts/PostGrotesk-Bold.woff2") format("woff2");
            }
            @font-face {
              font-family: "RobotoMono";
              font-weight: 400;
              font-style: normal;
              src: url("/static/fonts/RobotoMono-Regular.ttf")
                format("truetype");
              src: url("/static/fonts/RobotoMono-Regular.woff") format("woff");
            }
            @font-face {
              font-family: "RobotoMono";
              font-weight: 500;
              font-style: normal;
              src: url("/static/fonts/RobotoMono-Medium.ttf") format("truetype");
              src: url("/static/fonts/RobotoMono-Medium.woff") format("woff");
            }
            @font-face {
              font-family: "RobotoMono";
              font-weight: 700;
              font-style: normal;
              src: url("/static/fonts/RobotoMono-Bold.ttf") format("truetype");
              src: url("/static/fonts/RobotoMono-Bold.woff") format("woff");
            }
            * {
              box-sizing: border-box;
              -webkit-font-smoothing: antialiased;
              -moz-osx-font-smoothing: grayscale;
            }
            body {
              margin: 0;
              font-family: Sans-Serif;
              line-height: 1.5;
              background-color: ${colours.grey2};
            }
          `}</style>
          {children}
        </div>
      </main>
    );
  }
}

export default Layout;
