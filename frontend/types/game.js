// @flow
import type { AreaType } from "./area";
import type { OptionListType } from "./option";

export type InventoryItemType = {|
  slug: string,
  name: string,
  description: string,
  options: OptionListType
|};

export type InventoryType = Array<InventoryItemType>;

export type GameType = {|
  id: number,
  name: string,
  area: AreaType,
  inventory: InventoryType
|};
