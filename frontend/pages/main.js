// @flow

import React from "react";

import Layout from "../components/Layout";
import Game from "../components/Game";
import PageContainer from "../components/PageContainer";
import { colours } from "../lib/theme";
import { getGame } from "../lib/game";

import type { GameQueryParamsType } from "../types/query_params.js";
import type { GameType } from "../types/game";

type Context = {
  query: GameQueryParamsType,
  req: Request,
  res: Object
};
type Props = {
  game: GameType,
  inventory: boolean
};
type InitialProps = {
  game: GameType,
  inventory: boolean
};

class Main extends React.Component<Props> {
  static async getInitialProps({
    res,
    req,
    query
  }: Context): Promise<InitialProps> {
    // try {
    const game = await getGame(req, query.game_id);

    return {
      game: game,
      inventory: query.inventory === "true" || false
    };
    // } catch (error) {
    //   res.redirect("/login");
    //   throw error;
    // }
  }

  render() {
    const { game, inventory } = this.props;

    return (
      <Layout>
        <PageContainer
          backgroundColour={colours.white}
          backgroundColourInner={colours.white}
        >
          <Game game={game} inventory={inventory} />
        </PageContainer>
      </Layout>
    );
  }
}

export default Main;
