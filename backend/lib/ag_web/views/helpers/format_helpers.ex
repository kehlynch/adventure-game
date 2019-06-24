defmodule AgWeb.FormatHelpers do
  def format_boolean(true), do: "Yes"
  def format_boolean(false), do: "No"

  def format_list_as_string(list, delimiter) when is_list(list), do: Enum.join(list, delimiter)
  def format_list_as_string(_, _), do: ""
end
