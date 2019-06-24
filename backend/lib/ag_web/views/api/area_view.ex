defmodule AgWeb.API.AreaView do
  use AgWeb, :view

  alias Ag.Areas.Area
  alias Ag.Options.Option

  def render_area(%Area{} = area) do
    Map.new()
    |> Map.put(:slug, area.slug)
    |> Map.put(:description, area.desc)
    |> Map.put(:options, render_options(area.options))
    |> Map.put(:min_options, 1)
    |> Map.put(:max_options, 1)
    |> Map.put(:type, area.type)
    |> Map.put(:placeholder_text, area.placeholder_text)
  end

  def render_options(options) do
    Enum.map(options, &render_option(&1))
    |> Enum.reject(&is_nil(&1))
  end

  def render_option(%Option{} = option) do
    Map.new()
    |> Map.put(:slug, option.slug)
    |> Map.put(:text, option.text)
    |> Map.put(:direction, option.direction)
    |> Map.put(:type, option.type)
  end

  def render_option(nil), do: nil
end
