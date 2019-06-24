defmodule Ag.Areas.AreaBehaviour do
  alias Ag.Areas.Area
  @callback get_area(pid())::%Area{}

  @callback get_desc(pid()) :: String.t()
  @callback get_type(pid()) :: Srring.t()
  @callback get_options(pid()) :: List.t()

  @callback get_setting(pid(), String.t()) :: any()
  @callback get_setting(pid(), String.t(), any()) :: any()
  @callback set_setting!(pid(), String.t(), String.t()) :: none()

  @callback set_to_current!(pid())::none()

  @callback apply_choice!(pid(), tuple())::none()
end
