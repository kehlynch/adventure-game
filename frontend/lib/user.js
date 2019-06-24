// @flow

import { get } from "./api";

import type { Request } from "express";

export async function createUser(req: Request, email: string) {
  const url = `/users/${email}`;
  const response = await get(req, url);
  return response;
}
