// @flow

import fetch from "cross-fetch";

import type { Request } from "express";

// $FlowIgnore: value is interpolated by transform-define
const API_HOST: string = process.env.API_HOST;
// $FlowIgnore: value is interpolated by transform-define
const JS_API_HOST: string = process.env.JS_API_HOST;

export async function get(req: ?Request, path: string) {
  return request(req, path);
}

export async function post(req: ?Request, path: string, data: Object) {
  const options = {
    method: "POST",
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify(data)
  };

  return request(req, path, options);
}

async function request(req: ?Request, path: string, options: Object = {}) {
  const uri = getUri(req, path);
  const response = await fetch(uri, options);
  if (response.status >= 400) {
    throw new Error(response.statusText);
  }
  const json = await response.json();

  return json;
}

function getUri(req: ?Request, path: string): string {
  let uri;
  if (req) uri = `${API_HOST}/api${path}`;
  else uri = `${JS_API_HOST}/api${path}`;
  return uri;
}
