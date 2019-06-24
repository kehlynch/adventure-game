// @flow

import React from "react";
import Router from "next/router";

import Layout from "../components/Layout";
import PageContainer from "../components/PageContainer";
import Button from "../components/Button";
import TextInput from "../components/TextInput";
import ErrorMessage from "../components/ErrorMessage";
import { colours } from "../lib/theme";
import { createGame } from "../lib/game";
import mediaQueries from "../lib/mediaQueries";

import { createUser } from "../lib/user";

import type { AreaType } from "../types/area";

type Props = {
  area: AreaType,
  userId: number,
  url: Object
};
type State = {
  email: string,
  submitError: boolean
};

class Login extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = {
      submitError: false,
      email: ""
    };
  }

  retrieveGames = async () => {
    const { email } = this.state;
    try {
      const result = await createUser(null, email);
      const userId = result.id;

      const newUrl = {
        pathname: "/games",
        query: {
          user_id: userId
        }
      };

      Router.push(newUrl);
      window.scrollTo(0, 0);
    } catch (error) {
      this.setState((state: State) => ({
        ...state,
        submitError: true
      }));
    }
  };

  gotoGame(gameId: number): Function {
    return () => {
      const newUrl = {
        pathname: "/main",
        query: {
          game_id: gameId
        }
      };

      Router.replace(newUrl);
      window.scrollTo(0, 0);
    };
  }

  createGame = async () => {
    const { userId } = this.props;
    const game = await createGame(null, userId);
    this.gotoGame(game.id)();
  };

  onChangeEmail = (email: string) => {
    this.setState((state: State): State => ({
      ...state,
      email: email
    }));
  };

  render() {
    const { email, submitError } = this.state;
    return (
      <Layout>
        <PageContainer
          backgroundColour={colours.grey2}
          backgroundColourInner={colours.white}
        >
          <div className="root">
            <style jsx>{`
              .root {
                align-items: center;
                justify-content: center;
              }
              .submitButtonContainer {
                display: flex;
                justify-content: flex-start;
                align-items: flex-start;
                flex-direction: column;
                margin-top: 20px;
              }
              .submitButton {
                flex: 1;
                max-width: 180px;
                padding-bottom: 10px;
              }
              @media ${mediaQueries.gtSmall} {
                label {
                  margin-bottom: 24px;
                }
              }
            `}</style>
            <h2>Welcome to Lost in the Forest! 🌲</h2>
            <h3>Enter your email address to play</h3>
            <TextInput
              onChange={this.onChangeEmail}
              value={email}
              placeholderText={"email address"}
            />
            <div className="submitButtonContainer">
              <div className="submitButton">
                <Button
                  text="🧙‍♀️ New Game"
                  onClick={this.createGame}
                  type="new"
                  disabled={!email.length}
                />
              </div>
              <div className="submitButton">
                <Button
                  text="🧝‍♀️Retrieve Games"
                  onClick={this.retrieveGames}
                  type="retrieve"
                  disabled={!email.length}
                />
              </div>
            </div>
            {submitError && <ErrorMessage message="Error" />}
          </div>
        </PageContainer>
      </Layout>
    );
  }
}

export default Login;
