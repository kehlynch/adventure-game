// @flow

import React from "react";

import Layout from "../components/Layout";
import GameList from "../components/GameList";
import PageContainer from "../components/PageContainer";
import { colours } from "../lib/theme";
import { getGames } from "../lib/game";

import type { GamesQueryParamsType } from "../types/query_params.js";
import type { GameType } from "../types/game";

type Context = {
  query: GamesQueryParamsType,
  req: Request
};

type Props = {
  games: Array<GameType>,
  userId: number
};

type InitialProps = {
  games: Array<GameType>,
  userId: number
};

class Games extends React.Component<Props> {
  static async getInitialProps({
    res,
    req,
    query
  }: Context): Promise<InitialProps> {
    try {
      const response = await getGames(req, query.user_id);

      return {
        games: response.games,
        userId: parseInt(query.user_id)
      };
    } catch (error) {
      // show default 404 page
      error.code = "ENOENT";
      throw error;
    }
  }

  render() {
    const { games, userId } = this.props;

    return (
      <Layout>
        <PageContainer
          backgroundColour={colours.grey2}
          backgroundColourInner={colours.white}
        >
          <GameList games={games} userId={userId} />
        </PageContainer>
      </Layout>
    );
  }
}

export default Games;
