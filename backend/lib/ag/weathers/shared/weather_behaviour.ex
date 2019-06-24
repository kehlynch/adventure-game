defmodule Ag.Weathers.WeatherBehaviour do
  alias Ag.Weathers.Weather
  @callback get_name(pid()) :: String.t()
  @callback get_desc(pid()) :: String.t()
  @callback set_to_current!(pid())::none()
end
