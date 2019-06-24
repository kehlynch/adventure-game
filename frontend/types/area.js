// @flow
import type { OptionListType } from "./option";

export type WeatherType = {|
  slug: string,
  description: string
|};

export type AreaType = {|
  game_id: number,
  slug: string,
  description: Array<string>,
  options: OptionListType,
  min_options: number,
  max_options: number,
  type: string,
  show_weather: boolean,
  weather: WeatherType
|};
