// @flow

import type { AreaType } from "../types/area";
import type { OptionListType } from "../types/option";
import type { ResponseType } from "../types/response";

export function isBinary(area: AreaType): boolean {
  return isSingleSelect(area) && area.options.length === 2;
}

export function isSingleSelect(area: AreaType): boolean {
  const { type } = area;
  return type === "Select" && area.min_options === 1 && area.max_options === 1;
}

export function getOptions(area: AreaType): OptionListType {
  return area.options;
}

export function getSelectedOptions(
  options: OptionListType,
  response: ResponseType
) {
  return response.options;
}
