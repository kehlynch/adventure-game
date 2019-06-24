defmodule Ag.Weathers do
  alias Ag.{Settings, Weathers}
  alias Ag.Settings.Time

  @initial_weather

  @modules %{
    rain: Weathers.Rain,
    sun: Weathers.Sun,
    cloud: Weathers.Cloud,
    foggy: Weathers.Fog,
    snow: Weathers.Snow,
  }

  defp get_module(slug), do: Map.get(@modules, slug)

  def init!(pid) do
    module =
      @modules
      |> Map.get(@initial_weather)

    module.set_to_current!(pid)
  end

  def get_desc(pid, slug) do
    get_module(slug).get_desc(pid)
  end

  def get_past_desc(pid, slug) do
    get_module(slug).get_past(pid)
  end

  def generate_weather(pid) do
    # weather = get_current_weather(pid)

    # case Enum.random(1..2) do
    #   1 -> weather
    #   2 -> Enum.random(Map.keys(@modules))
    # end
  end

  def get_previous_weather(pid) do
    # pid
    # |> get_weather_list()
    # |> Enum.at(1)
  end

  def set_current_weather!(pid, slug) do
    get_module(slug).set_to_current!(pid)
  end
end
