import type { OptionType } from "../types/area";

export function emptyOption(): OptionType {
  return {
    slug: "",
    text: "",
    option_type: "",
    direction: ""
  };
}
