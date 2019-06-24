// @flow

import { post } from "./api";

import type { ResponseType } from "../types/response";

export async function postResponse(
  req: ?Request,
  response: ResponseType,
  gameId: number
) {
  const option = response.options.length > 0 && response.options[0];
  const returnData = await post(req, `/responses`, {
    game_id: gameId,
    choice: {
      area: response.slug,
      text: response.text,
      option: option,
      choice_type: response.response_type
    }
  });

  return returnData;
}

export function emptyResponse(): ResponseType {
  return {
    slug: "",
    text: "",
    response_type: "",
    options: []
  };
}
