defmodule Ag.Items.ItemBehaviour do
  alias Ag.Items.Item
  @callback starting_inv?()::boolean()
  @callback inv?(pid()) :: boolean()
  @callback init!(pid()) :: any

  @callback get_item(pid())::%Item{}

  @callback get_name(pid()) :: String.t()
  @callback get_desc(pid()) :: String.t()
  @callback get_options(pid()):: String.t()

  @callback get_settings(pid()) :: map()
  @callback get_setting(pid(), String.t()) :: any()
  @callback get_setting(pid(), String.t(), any()) :: any()
  @callback set_setting!(pid(), String.t(), String.t()) :: none()
  @callback increment_setting!(pid(), String.t(), number()) :: none()
  @callback add(pid(), number())::none()

  @callback apply_choice!(pid(), tuple())::none()
end
