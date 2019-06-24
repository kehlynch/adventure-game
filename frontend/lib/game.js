// @flow

import { get, post } from "./api";

import type { Request } from "express";
import Router from "next/router";

export async function createGame(req: Request, userId: number) {
  const returnData = await post(req, `/games`, {
    user_id: userId
  });
  return returnData;
}

export async function getGame(req: Request, gameId: string) {
  const url = `/games/${gameId}`;
  const response = await get(req, url);
  return response;
}

export async function getGames(req: Request, userId: string) {
  const url = `/usergames/${userId}`;
  const response = await get(req, url);
  return response;
}
export function gotoGame(gameId: number): Function {
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
