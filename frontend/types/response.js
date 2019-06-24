// @flow
import type { OptionListType } from "./option";

export type ResponseType = {|
  slug: string,
  response_type: string,
  options: OptionListType,
  text: string
|};
